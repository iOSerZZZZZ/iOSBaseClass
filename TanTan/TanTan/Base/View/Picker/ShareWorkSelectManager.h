//
//  ShareWorkSelectManager.h
//  qygt
//
//  Created by 周发明 on 17/3/13.
//  Copyright © 2017年 途购. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShareWorkPickerView.h"

@interface ShareWorkSelectManager : NSObject

+ (instancetype)manager;

- (void)showSelectTimeMode:(UIDatePickerMode)datePickerMode middleTitle:(NSString *)middleTitle okBlock:(void(^)(NSDate *date))okBlock;

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle okBlock:(void(^)(NSDate *date))okBlock;

- (void)showSelectTimeWithMiddleTitle:(NSString *)middleTitle showDate:(NSDate *)date okBlock:(void(^)(NSDate *date))okBlock;

/**
 不联动的选择

 @param middleTitle 显示标题
 @param items 显示数据
 @param components 多少列
 @param okBlock 点击确定回调
 */
- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<ShareWorkPickerItem *>*)items components:(NSInteger)components okBlock:(ShareWorkSelectManagerFinishBlock)okBlock;

/**
 不联动的选择, 显示之前的选择项
 
 @param middleTitle 显示标题
 @param items 显示数据
 @param components 多少列
 @param okBlock 点击确定回调
 @param selectedRows 显示选择的数据
 */
- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<ShareWorkPickerItem *>*)items selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components okBlock:(ShareWorkSelectManagerFinishBlock)okBlock;

/**
 传入是否联动选择   之前的选择项

 @param middleTitle 显示标题
 @param items 显示数据
 @param components 多少列
 @param okBlock 点击确定回调
 @param selectedRows 显示选择的数据
 @param linkageType 联动选择项
 */
- (void)showSelectDataWithMiddleTitle:(NSString *)middleTitle items:(NSArray<NSArray *>*)items  selectedRow:(NSArray<NSNumber *> *)selectedRows components:(NSInteger)components linkageType:(ShareWorkPickerViewLinkageType)linkageType okBlock:(ShareWorkSelectManagerFinishBlock)okBlock;

/**
 城市联动选择

 @param middleTitle 中间的标题
 @param okBlock 确定的回调
 */
- (void)showSelectCityWithMiddleTitle:(NSString *)middleTitle okBlock:(ShareWorkSelectManagerFinishBlock)okBlock;


- (void)showCultureLevelWithTitle:(NSString *)middleTitle okBlock:(ShareWorkSelectManagerFinishBlock)okBlock;


- (void)loadCityData;

@end
