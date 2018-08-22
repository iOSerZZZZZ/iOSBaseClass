//
//  UIView+Utils.m
//  YIDATA
//
//  Created by mousekang on 2017/11/22.
//  Copyright © 2017年 mousekang. All rights reserved.
//

#import "UIView+Utils.h"

@implementation UIView (Utils)

/****------> UIView +Layer <------ ****/
-(void)drawLayerShadowWithColor:(UIColor*)color Radius:(float) radius Opacity:(float) opacity
{
    self.layer.shadowOpacity = opacity;//阴影透明度
    
    self.layer.shadowColor = color.CGColor;//阴影的颜色
    
    self.layer.shadowRadius = radius;//阴影扩散的范围控制
    
    self.layer.shadowOffset  = CGSizeMake(1,1);//阴影的范围
}

-(void)drawLayerBorderWithColor:(UIColor*)color  Width:(CGFloat) width
{
    self.layer.borderColor = color.CGColor;//边框颜色
    
    self.layer.borderWidth = width;//边框宽度
}

-(void)drawLayerCornerWithRadius:(CGFloat) radius
{
    self.layer.masksToBounds =YES;
    
    self.layer.cornerRadius = radius;
    
}

/****------> UIView +Frame <------ ****/
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
-(CGFloat)right{
    
    return self.x+self.width;
}

-(CGFloat)bottom{
    
    return self.y+self.height;
}


- (CGSize)size
{
    return self.frame.size;
}

@end
