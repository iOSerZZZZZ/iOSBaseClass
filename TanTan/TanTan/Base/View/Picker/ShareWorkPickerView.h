//
//  ShareWorkPickerView.h
//  qygt
//
//  Created by 周发明 on 17/3/10.
//  Copyright © 2017年 途购. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ShareWorkSelectManagerFinishBlock)(id selectData, NSArray<NSNumber *> *selectRows);

typedef NS_ENUM(NSInteger, ShareWorkPickerViewType){
    ShareWorkPickerViewTimeType,
    ShareWorkPickerViewDataType
};

typedef NS_ENUM(NSInteger, ShareWorkPickerViewLinkageType){
    ShareWorkPickerViewLinkageNormalType, /// 联动
    ShareWorkPickerViewLinkageForbidType  /// 禁止联动
};


@class ShareWorkPickerItem;
@interface ShareWorkPickerView : UIView<UIPickerViewDelegate, UIPickerViewDataSource>

+ (instancetype)viewForXib;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (weak, nonatomic) IBOutlet UILabel *middleLabel;

@property(nonatomic, copy)void(^timeOKBlock)(NSDate *date);

@property(nonatomic, copy)ShareWorkSelectManagerFinishBlock dataOKBlock;

@property(nonatomic, assign)NSInteger  components;

@property(nonatomic, strong)NSMutableArray *items;

@property(nonatomic, assign)ShareWorkPickerViewLinkageType linkageType;

- (void)showWithType:(ShareWorkPickerViewType)type;

- (void)hide;

@end


@interface ShareWorkPickerItem : NSObject

@property(nonatomic, copy)NSString *name;

@property(nonatomic, strong)NSArray *subItems;

@property(nonatomic, strong)id extraValue;

+ (instancetype)itemWithName:(NSString *)name subItems:(NSArray<ShareWorkPickerItem *> *)subItems;

@end
