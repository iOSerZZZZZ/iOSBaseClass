//
//  TTShellMatchView.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellMatchView.h"

@interface TTShellMatchView()

@property(nonatomic, assign)CGAffineTransform originalTransform;
@property(nonatomic, assign)CGAffineTransform currentTransform;

@end

@implementation TTShellMatchView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
        [self drawLayerCornerWithRadius:4];
        self.layer.masksToBounds = NO;
        [self drawLayerShadowWithColor:[UIColor blackColor] Radius:4 Opacity:0.5];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(viewPan:)];
        [self addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTap:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)viewTap:(UITapGestureRecognizer *)tap{
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

- (void)viewPan:(UIPanGestureRecognizer *)pan{
    switch (pan.state) {
        case UIGestureRecognizerStateBegan:
            self.originalTransform = self.transform;
            break;
        case UIGestureRecognizerStateEnded:
        {
            CGPoint point = [pan translationInView:self.superview];
            if (fabsf(point.x) > self.width*0.5 || fabsf(point.y) > self.height*0.5) {
                CGAffineTransform transform = CGAffineTransformTranslate(self.originalTransform, point.x * 2, point.y * 2);
                [UIView animateWithDuration:0.1 animations:^{
                    self.alpha = 0;
                    self.transform = transform;
                } completion:^(BOOL finished) {
                    if (self.removeFinish) {
                        self.removeFinish(self, point.x <= 0);
                    }
                }];
            } else {
                [UIView animateWithDuration:0.1 animations:^{
                    self.transform = self.originalTransform;
                }];
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [pan translationInView:self.superview];
            CGAffineTransform transform = CGAffineTransformTranslate(self.originalTransform, point.x, point.y);
            self.transform = transform;
        }
            break;
        default:
            break;
    }
}

@end
