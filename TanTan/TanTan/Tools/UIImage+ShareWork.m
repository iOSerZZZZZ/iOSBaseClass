//
//  UIImage+ShareWork.m
//  ShareWork
//
//  Created by 周发明 on 2018/4/26.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UIImage+ShareWork.h"

UIImage *_swAddDrawImage;

@implementation UIImage (ShareWork)

+ (instancetype)creatNormalBtnBg{
    return [UIImage creatImageWithStartColor:COLOR_HEX(0xFF9C00) endColor:COLOR_HEX(0xFF9C00)];
}
+ (instancetype)creatDisableBtnBg{
    return [UIImage creatImageWithStartColor:COLOR_HEX(0xDDDDDD) endColor:COLOR_HEX(0xDDDDDD)];
}

+ (instancetype)creatImageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
    gradientLayer.frame = view.bounds;
    [gradientLayer setColors:[NSArray arrayWithObjects:
                              (id)[startColor CGColor],
                              (id)[endColor CGColor], nil]];
    [gradientLayer setLocations:@[@0.0,@1.0]];
    [gradientLayer setStartPoint:CGPointMake(0.0, 0.0)];
    [gradientLayer setEndPoint:CGPointMake(0.0, 1.0)];
    [view.layer addSublayer:gradientLayer];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef content = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:content];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [view removeFromSuperview];
    
    return image;
}

+ (instancetype)creatAddImage{
    
    if (_swAddDrawImage == nil) {
        _swAddDrawImage = [self creatAddImageWithWidth:20 margin:1 lineWidth:3];
    }
    return _swAddDrawImage;
}

+ (instancetype)creatAddImageWithWidth:(CGFloat)width margin:(CGFloat)margin lineWidth:(CGFloat)lineWidth{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    UIView *line1 = [[UIView alloc] init];
    [line1 drawLayerCornerWithRadius:1];
    line1.backgroundColor = COLOR_HEX(0xF5CA49);
    [view addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@(lineWidth));
        make.height.equalTo(@(width - margin));
    }];
    
    UIView *line2 = [[UIView alloc] init];
    [line2 drawLayerCornerWithRadius:1];
    line2.backgroundColor = COLOR_HEX(0xF5CA49);
    [view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@(width - margin));
        make.height.equalTo(@(lineWidth));
    }];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef content = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:content];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [view removeFromSuperview];
    
    return image;
}

+ (instancetype)createImageWithColor:(UIColor *)color{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    view.backgroundColor = color;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef content = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:content];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [view removeFromSuperview];
    
    return image;
}

@end
