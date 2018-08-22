//
//  ShareWorkSelectManager.m
//  qygt
//
//  Created by 周发明 on 17/3/13.
//  Copyright © 2017年 途购. All rights reserved.
//

#import "ShareWorkSelectManager.h"
#import <MJExtension.h>
#import "SWNetManager.h"

@interface ShareWorkSelectManager ()

@property(nonatomic, strong)ShareWorkPickerView *pickerView;
@property(nonatomic, strong)NSArray *cityData;
@end

@implementation ShareWorkSelectManager

+ (instancetype)manager{
    static ShareWorkSelectManager *_ShareWorkSelectManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ShareWorkSelectManager = [[ShareWorkSelectManager alloc] init];
        [_ShareWorkSelectManager pickerView];
        [_ShareWorkSelectManager loadCityData];
    });
    return _ShareWorkSelectManager;
}

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle okBlock:(void (^)(NSDate *))okBlock{
    [self showSelectTimeMode:UIDatePickerModeDateAndTime middleTitle:middleTitle okBlock:okBlock];
}

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle showDate:(NSDate *)date okBlock:(void(^)(NSDate *date))okBlock{
    [self showSelectTimeWithMiddleTitle:middleTitle okBlock:okBlock];
    if (date) {
        self.pickerView.datePickerView.date = date;
    } else {
        self.pickerView.datePickerView.date = [NSDate date];
    }
}

- (void)showSelectTimeMode:(UIDatePickerMode)datePickerMode middleTitle:(NSString *)middleTitle okBlock:(void(^)(NSDate *date))okBlock{
    self.pickerView.middleLabel.text = middleTitle;
    self.pickerView.timeOKBlock = okBlock;
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:self.pickerView];
    self.pickerView.datePickerView.datePickerMode = datePickerMode;
    [self.pickerView showWithType:ShareWorkPickerViewTimeType];
}

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<ShareWorkPickerItem *>*)items components:(NSInteger)components okBlock:(ShareWorkSelectManagerFinishBlock)okBlock{
    [self showSelectDataWithMiddleTitle:middleTitle items:items selectedRow:nil components:components okBlock:okBlock];
}

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<ShareWorkPickerItem *>*)items selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components okBlock:(ShareWorkSelectManagerFinishBlock)okBlock{
    [self showSelectDataWithMiddleTitle:middleTitle items:(NSArray<NSArray *> *)items selectedRow:selectedRows components:components linkageType:ShareWorkPickerViewLinkageNormalType okBlock:okBlock];
}

- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<ShareWorkPickerItem *> *)items  selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components linkageType:(ShareWorkPickerViewLinkageType)linkageType okBlock:(ShareWorkSelectManagerFinishBlock)okBlock{
    if (self.pickerView.items) {
        [self.pickerView.pickerView selectRow:0 inComponent:0 animated:YES];
    }
    self.pickerView.middleLabel.text = middleTitle;
    self.pickerView.dataOKBlock = okBlock;
    self.pickerView.linkageType = linkageType;
    self.pickerView.items = (NSMutableArray *)items;
    self.pickerView.components = components;
    [self.pickerView.pickerView reloadAllComponents];
    [[[[UIApplication sharedApplication] delegate] window] bringSubviewToFront:self.pickerView];
    [self.pickerView showWithType:ShareWorkPickerViewDataType];
    if (selectedRows && selectedRows.count > 0) {
        [selectedRows enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < components) {
                if (linkageType == ShareWorkPickerViewLinkageNormalType) { // 联动的
                    [self.pickerView.pickerView selectRow:obj.integerValue inComponent:idx animated:NO];
                    [self.pickerView pickerView:self.pickerView.pickerView didSelectRow:obj.integerValue inComponent:idx];
                } else {
                    [self.pickerView.pickerView selectRow:obj.integerValue inComponent:idx animated:NO];
                }
            }
        }];
    }
}

- (void)showSelectCityWithMiddleTitle:(NSString *)middleTitle okBlock:(ShareWorkSelectManagerFinishBlock)okBlock{
    [self showSelectDataWithMiddleTitle:middleTitle items:self.cityData selectedRow:nil components:3 linkageType:ShareWorkPickerViewLinkageNormalType okBlock:okBlock];
}




- (void)loadCityData{
    [ShareWorkPickerItem mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 @"extraValue":@"id",
                 @"subItems":@"children"
                 };
    }];
    [ShareWorkPickerItem mj_setupObjectClassInArray:^NSDictionary *{
        return @{
                 @"subItems":@"ShareWorkPickerItem"
                 };
    }];
    NSString *url = [[SWNetManager manager].baseUrl stringByAppendingString:SW_Area_GetTree];
    if (self.cityData.count == 0) {
    
    
    [[AFHTTPSessionManager manager] GET:url parameters:@{} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.cityData = [ShareWorkPickerItem mj_objectArrayWithKeyValuesArray:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"%@",error.userInfo);
        
    }];
        
    }
}

- (ShareWorkPickerView *)pickerView{
    if (_pickerView == nil) {
        ShareWorkPickerView *picker = [ShareWorkPickerView viewForXib];
//        picker.datePickerView.minimumDate = [NSDate date];
        picker.hidden = YES;
        picker.frame = CGRectMake(0, 0, KScreenWidth, KScreenHeight);
        [[[[UIApplication sharedApplication] delegate] window] addSubview:picker];
        _pickerView = picker;
    } else {
        if (![[[[[UIApplication sharedApplication] delegate] window] subviews] containsObject:_pickerView]) {
            [[[[UIApplication sharedApplication] delegate] window] addSubview:_pickerView];
        }
    }
    return _pickerView;
}

@end

@implementation ShareWorkPickerItem

+ (instancetype)itemWithName:(NSString *)name subItems:(NSArray<ShareWorkPickerItem *> *)subItems{
    ShareWorkPickerItem *item = [[ShareWorkPickerItem alloc] init];
    item.name = name;
    item.subItems = subItems;
    return item;
}

@end
