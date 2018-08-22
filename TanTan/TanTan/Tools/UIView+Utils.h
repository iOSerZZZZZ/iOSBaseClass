//
//  UIView+Utils.h
//  YIDATA
//
//  Created by mousekang on 2017/11/22.
//  Copyright © 2017年 mousekang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utils)

@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGSize size;
@property (nonatomic,assign) CGFloat right;
@property (nonatomic,assign) CGFloat bottom;
/**
 *  添加阴影效果
 *  color   颜色
 *  radius  范围
 *  opacity 透明度
 */
-(void)drawLayerShadowWithColor:(UIColor*)color Radius:(float) radius Opacity:(float) opacity;
/**
 *     添加边框
 */
-(void)drawLayerBorderWithColor:(UIColor*)color  Width:(CGFloat) width ;
/**
 *      设置圆角
 */
-(void)drawLayerCornerWithRadius:(CGFloat) radius;



@end
