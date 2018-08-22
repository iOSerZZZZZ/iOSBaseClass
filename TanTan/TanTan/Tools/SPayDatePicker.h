//
//  SPayDatePicker.h
//  SPay
//
//  Created by Golder on 2017/3/27.
//  Copyright © 2017年 YNET. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPayDatePicker;
@protocol SPayDatePickerDelegate <NSObject>
@optional
- (void)datePicker:(SPayDatePicker *)picker
    didPickerStart:(NSDate *)startDate
           endDate:(NSDate *)endDate;
- (void)datePickerCancelPicker:(SPayDatePicker *)picker;
@end

@interface SPayDatePicker : UIView

@property (nonatomic, weak) id <SPayDatePickerDelegate> delegate;
@property (nonatomic) UIDatePickerMode datePickerMode;

+ (instancetype)datePickerWithMode:(UIDatePickerMode)pickerMode;

- (void)show;

@end
