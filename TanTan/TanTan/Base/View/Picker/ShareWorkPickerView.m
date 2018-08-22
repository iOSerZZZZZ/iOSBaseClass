//
//  ShareWorkPickerView.m
//  qygt
//
//  Created by 周发明 on 17/3/10.
//  Copyright © 2017年 途购. All rights reserved.
//

#import "ShareWorkPickerView.h"

@interface ShareWorkPickerView ()

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pickerBottomHeight;

@property(nonatomic, assign)ShareWorkPickerViewType type;


@property(nonatomic, weak)UIView *selectView;

@end

CGFloat ShareWorkPickerViewHeight = 256;

@implementation ShareWorkPickerView

+ (instancetype)viewForXib{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)okButtonClick{
    self.hidden = YES;
    if (self.type == ShareWorkPickerViewTimeType) {
        if (self.timeOKBlock) {
            self.timeOKBlock(self.datePickerView.date);
        }
    } else {
        if (self.linkageType == ShareWorkPickerViewLinkageForbidType) {
            NSMutableArray *arrM = [NSMutableArray array];
            NSMutableArray *rows = [NSMutableArray array];
            for (int i = 0; i<self.components; i++) {
                NSArray *arr = self.items[i];
                NSInteger row = [self.pickerView selectedRowInComponent:i];
                if (row < arr.count) {
                    [arrM addObject:arr[row]];
                    [rows addObject:@(row)];
                } else {
                    [rows addObject:@(0)];
                }
            }
            if (self.dataOKBlock){
                self.dataOKBlock(arrM, rows);
            }
        } else {
            NSMutableArray *selectItems = [NSMutableArray array];
            NSArray *items = self.items;
            ShareWorkPickerItem *item = nil;
            NSMutableArray *rows = [NSMutableArray array];
            for (int i = 0; i<self.components; i++) {
                if (items && items.count > 0) {
                    item = items[[self.pickerView selectedRowInComponent:i]];
                    items = item.subItems;
                    [rows addObject:@([self.pickerView selectedRowInComponent:i])];
                    [selectItems addObject:item];
                } else {
                    break;
                }
            }
            if (self.dataOKBlock){
                self.dataOKBlock(selectItems, rows);
            }
        }
    }
}

- (void)showWithType:(ShareWorkPickerViewType)type{
    self.type = type;
    if (type == ShareWorkPickerViewTimeType) {
        self.datePickerView.hidden = NO;
        self.pickerView.hidden = YES;
    } else {
        self.datePickerView.hidden = YES;
        self.pickerView.hidden = NO;
    }
    self.hidden = NO;
    self.pickerBottomHeight.constant = 0;
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self layoutIfNeeded];
    }];
}

- (void)hide{
    if (self.type == ShareWorkPickerViewDataType) {
        [self.pickerView selectRow:0 inComponent:0 animated:NO];
    }
    self.pickerBottomHeight.constant = - ShareWorkPickerViewHeight;
    [UIView animateWithDuration:0.25 animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void)cancelButtonClick{
    [self hide];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    [self.cancelButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.okButton addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.pickerBottomHeight.constant = - ShareWorkPickerViewHeight;
    self.datePickerView.minimumDate = [NSDate dateWithTimeIntervalSince1970:0];
}

- (void)setItems:(NSMutableArray *)items{
    _items = items;
    [self.pickerView reloadAllComponents];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return self.components;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.linkageType == ShareWorkPickerViewLinkageForbidType) {
        if (component < self.items.count) {
            NSArray *arr = self.items[component];
            return arr.count;
        } else {
            return 0;
        }
    }
    NSArray *items = self.items;
    if (component == 0) {
        return items.count;
    }
    ShareWorkPickerItem *item = items[[pickerView selectedRowInComponent:0]];
    items = item.subItems;
    for (int i = 1; i < component; i++) {
        if (items.count == 0) {
            return 0;
        }
        item = items[[pickerView selectedRowInComponent:i]];
        items = item.subItems;
    }
    return item.subItems.count;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (view == nil) {
        view = [[UILabel alloc] init];
    }
    NSString *name = nil;
    
    if (self.linkageType == ShareWorkPickerViewLinkageForbidType) {
        if (component < self.items.count) {
            NSArray *arr = self.items[component];
            if (row < arr.count) {
                ShareWorkPickerItem *item = arr[row];
                name = item.name;
            }
        } else {
            name = @"";
        }
    } else {
        NSArray *items = self.items;
        if (component == 0) {
            ShareWorkPickerItem *item = items[row];
            name = item.name;
        } else {
            ShareWorkPickerItem *item = items[[pickerView selectedRowInComponent:0]];
            items = item.subItems;
            for (int i = 1; i <= component; i++) {
                if (i == component) {
                    if (row < items.count) {
                        item = items[row];
                    }
                } else {
                    NSInteger selectRow = [pickerView selectedRowInComponent:i];
                    if (selectRow < items.count) {
                        item = items[selectRow];
                    }
                }
                items = item.subItems;
            }
            name = item.name;
        }
    }
    UILabel *label = (UILabel *)view;
    label.textAlignment = NSTextAlignmentCenter;
    label.text = name;
    label.font = [UIFont systemFontOfSize:[self fontSize]];
    
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1.0];
        }
    }
    
    
    return label;
}





- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return KScreenWidth / self.components;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return [self rowHeight];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.linkageType == ShareWorkPickerViewLinkageForbidType) {
        return;
    }
    self.userInteractionEnabled = NO;
    if (component < self.components - 1) {
        [pickerView reloadAllComponents];
    }
    self.userInteractionEnabled = YES;
}

- (CGFloat)fontSize{
    return [self rowHeight] / 2;
}

- (CGFloat)rowHeight{
    if (self.components == 1 && self.linkageType == ShareWorkPickerViewLinkageNormalType) {
        switch (self.items.count) {
            case 2:
                return 42;
                break;
            case 3:
                return 38;
                break;
            case 4:
                return 34;
                break;
            default:
                return 30;
                break;
        }
    }
    return 30;
}

@end
