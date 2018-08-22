/*
 * QRCodeReaderViewController
 *
 * Copyright 2014-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#import "QRCodeReaderView.h"


@interface QRCodeReaderView ()
@property (nonatomic, strong) CAShapeLayer *overlay;
@property (nonatomic, strong) CAShapeLayer *cornerLayer;
@property (nonatomic, strong) CAGradientLayer *scanLine;
@property (nonatomic, strong) CAShapeLayer *maskLayer;
@property (nonatomic, strong) CATextLayer *tipLayer;

@property CGRect startRect;
@property CGRect endRect;

@end

@implementation QRCodeReaderView

- (id)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
      [self addMask];
      [self addOverlay];
      [self addScan];
      [self addCorner];
      [self addTip];
  }

  return self;
}

- (void)drawRect:(CGRect)rect
{
    CGRect innerRect = CGRectInset(rect, 50, 50);

    CGFloat minSize = MIN(innerRect.size.width, innerRect.size.height);
    if (innerRect.size.width != minSize) {
    innerRect.origin.x   += (innerRect.size.width - minSize) / 2;
    innerRect.size.width = minSize;
    }
    else if (innerRect.size.height != minSize) {
    innerRect.origin.y    += (innerRect.size.height - minSize) / 2;
    innerRect.size.height = minSize;
    }

    CGRect offsetRect = CGRectOffset(innerRect, 0, -30);

    _overlay.path = [UIBezierPath bezierPathWithRect:offsetRect].CGPath;
    
    // add by Golder
    
    _maskLayer.frame = rect;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRect:rect];
    UIBezierPath *offPath = [UIBezierPath bezierPathWithRect:offsetRect];
    [maskPath appendPath:offPath];
    maskPath.usesEvenOddFillRule = YES;
    _maskLayer.path = maskPath.CGPath;
    _maskLayer.fillRule = kCAFillRuleEvenOdd;
    
    
    _startRect = CGRectMake(CGRectGetMinX(offsetRect), CGRectGetMinY(offsetRect), CGRectGetWidth(offsetRect), 2.0);
    _endRect = CGRectMake(CGRectGetMinX(offsetRect), CGRectGetMaxY(offsetRect), CGRectGetWidth(offsetRect), 1.5);
    _scanLine.frame = _startRect;
    
    CGFloat gap = 15;
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    // left top
    [path moveToPoint:CGPointMake(CGRectGetMinX(offsetRect), CGRectGetMinY(offsetRect)+gap)];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(offsetRect), CGRectGetMinY(offsetRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(offsetRect)+gap, CGRectGetMinY(offsetRect))];
    
    // right top
    [path moveToPoint:CGPointMake(CGRectGetMaxX(offsetRect)-gap, CGRectGetMinY(offsetRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(offsetRect), CGRectGetMinY(offsetRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(offsetRect), CGRectGetMinY(offsetRect)+gap)];
    
    // right down
    [path moveToPoint:CGPointMake(CGRectGetMaxX(offsetRect), CGRectGetMaxY(offsetRect)-gap)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(offsetRect), CGRectGetMaxY(offsetRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(offsetRect)-gap, CGRectGetMaxY(offsetRect))];
    
    // left down
    [path moveToPoint:CGPointMake(CGRectGetMinX(offsetRect)+gap, CGRectGetMaxY(offsetRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(offsetRect), CGRectGetMaxY(offsetRect))];
    [path addLineToPoint:CGPointMake(CGRectGetMinX(offsetRect), CGRectGetMaxY(offsetRect)-gap)];
    
    _cornerLayer.path = path.CGPath;
    
    CGRect tipRect = CGRectOffset(offsetRect, 0, CGRectGetHeight(offsetRect)+20);
    tipRect.size.height = 20;
    _tipLayer.frame = tipRect;
}

#pragma mark - Private Methods

- (void)addOverlay
{
  _overlay = [[CAShapeLayer alloc] init];
  _overlay.backgroundColor = [UIColor clearColor].CGColor;
  _overlay.fillColor       = [UIColor clearColor].CGColor;
  _overlay.strokeColor     = [UIColor whiteColor].CGColor;
  _overlay.lineWidth       = 1;
//  _overlay.lineDashPattern = @[@7.0, @7.0];
  _overlay.lineDashPhase   = 0;

  [self.layer addSublayer:_overlay];
}

- (void)addMask {
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.backgroundColor = [UIColor clearColor].CGColor;
    _maskLayer.opacity = 0.5;
    [self.layer addSublayer:_maskLayer];
}

- (void)addCorner {
    _cornerLayer = [CAShapeLayer layer];
    
    _cornerLayer.backgroundColor = [UIColor clearColor].CGColor;
    _cornerLayer.fillColor = [UIColor clearColor].CGColor;
    _cornerLayer.strokeColor = RGBColor(244, 198, 58).CGColor;
    _cornerLayer.lineWidth = 5;
    
    [self.layer addSublayer:_cornerLayer];
}

- (void)addTip {
    _tipLayer = [CATextLayer layer];
    _tipLayer.string = @"将二维码放入框内，即可自动扫描";
    _tipLayer.fontSize = 13;
    _tipLayer.foregroundColor = RGBColor(244, 198, 58).CGColor;
    _tipLayer.alignmentMode = kCAAlignmentCenter;
    _tipLayer.contentsScale = [UIScreen mainScreen].scale;
    [self.layer addSublayer:_tipLayer];
}

- (void)addScan {
    _scanLine = [CAGradientLayer layer];
    
//    CGColorRef side = [UIColor colorWithRed:200.0/255 green:1 blue:1 alpha:0.5].CGColor;
    CGColorRef side = RGBColor(243, 162, 97).CGColor;
    CGColorRef cent = RGBColor(244, 198, 58).CGColor;
    
    _scanLine.colors = @[(__bridge id)side, (__bridge id)cent, (__bridge id)side];
    _scanLine.startPoint = CGPointMake(0, 0.5);
    _scanLine.endPoint = CGPointMake(1, 0.5);
    _scanLine.opacity = 0.4;
    _scanLine.shadowColor = RGBColor(244, 198, 58).CGColor;
    [self.layer addSublayer:_scanLine];
}

- (void)startAnimation:(BOOL)animated {
    if (animated) {
        [self scanAnimation];
    } else {
        [_scanLine removeAnimationForKey:@"scan"];
    }
}

- (void)scanAnimation {
    
    CABasicAnimation *posAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    posAnimation.fromValue = @(CGRectGetMaxY(_startRect));
    posAnimation.toValue = @(CGRectGetMinY(_endRect));
    
    CABasicAnimation *shaOpaAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOpacity"];
    shaOpaAnimation.fromValue = @(0.2);
    shaOpaAnimation.toValue = @(1.0);
    
    CABasicAnimation *shaOffAnimation = [CABasicAnimation animationWithKeyPath:@"shadowOffset"];
    shaOffAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, -3)];
    shaOffAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0, -6)];
    
    CABasicAnimation *shaRadAnimation = [CABasicAnimation animationWithKeyPath:@"shadowRadius"];
    shaRadAnimation.fromValue = @(0);
    shaRadAnimation.toValue = @(5);
    
    CABasicAnimation *opaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opaAnimation.fromValue = @(0.5);
    opaAnimation.toValue = @(1.0);
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[posAnimation, opaAnimation, shaOpaAnimation, shaOffAnimation, shaRadAnimation];
    group.duration = 2.5;
    group.repeatCount = HUGE_VALF;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [_scanLine addAnimation:group forKey:@"scan"];
}

@end
