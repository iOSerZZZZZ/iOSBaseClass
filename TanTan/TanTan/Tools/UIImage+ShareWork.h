//
//  UIImage+ShareWork.h
//  ShareWork
//
//  Created by 周发明 on 2018/4/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ShareWork)

+ (instancetype)creatImageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor;

+ (instancetype)creatNormalBtnBg;
+ (instancetype)creatDisableBtnBg;

+ (instancetype)creatAddImage;
+ (instancetype)creatAddImageWithWidth:(CGFloat)width margin:(CGFloat)margin lineWidth:(CGFloat)lineWidth;

+ (instancetype)createImageWithColor:(UIColor *)color;



@end
