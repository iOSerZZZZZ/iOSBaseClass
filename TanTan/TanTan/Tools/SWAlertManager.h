//
//  SWAlertManager.h
//  ShareWork
//
//  Created by 周发明 on 2018/5/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SWAlertManagerButtonClickBlock)(void);

#import <UIKit/UIKit.h>

@interface SWAlertManager : UIView

+ (void)initializeFirst;

+ (void)showMessage:(NSString *)message meaageColor:(UIColor *)messageColor cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle cancelButtonBlock:(SWAlertManagerButtonClickBlock)cancelBlock okButtonBlock:(SWAlertManagerButtonClickBlock)okBlock;

+ (void)showMessage:(NSString *)message meaageColor:(UIColor *)messageColor cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle cancelButtonBlock:(SWAlertManagerButtonClickBlock)cancelBlock okButtonBlock:(SWAlertManagerButtonClickBlock)okBlock extraBlock:(SWAlertManagerButtonClickBlock)extraBlock;

+ (void)showMessage:(NSString *)message meaageColor:(UIColor *)messageColor okButtonTitle:(NSString *)okTitle okButtonBlock:(SWAlertManagerButtonClickBlock)okBlock;

+ (void)showMessage:(NSString *)message;

@end
