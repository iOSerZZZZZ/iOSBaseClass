//
//  TTShellMatchViewController.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellMatchViewController.h"
#import "TTShellUserProfileViewController.h"
#import "TTShellMatchView.h"

@interface TTShellMatchViewController ()
@property(nonatomic, strong)NSMutableArray<UIView *> *views;
@end

static NSInteger const MaxCount = 4;
static CGFloat const MaxXScale = 1.1;
static CGFloat const MaxYScale = 1.1;

@implementation TTShellMatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.views = [NSMutableArray arrayWithCapacity:MaxCount];
    [self initViews];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self animationViews];
}

- (void)initViews{
    [self.views addObject:[[TTShellMatchView alloc] init]];
    [self.views addObject:[[TTShellMatchView alloc] init]];
    [self.views addObject:[[TTShellMatchView alloc] init]];
    [self.views addObject:[[TTShellMatchView alloc] init]];
    
    void(^block)(TTShellMatchView *view, BOOL isLeft) = ^(TTShellMatchView *view, BOOL isLeft){
        NSLog(@"%@", isLeft ? @"左边滑" : @"右边滑");
        [self.views removeObject:view];
        [self.views insertObject:view atIndex:0];
        [view.superview sendSubviewToBack:view];
        view.transform = CGAffineTransformIdentity;
        view.alpha = 1;
        [self animationViews];
    };
    
    void(^tap)(TTShellMatchView *) = ^(TTShellMatchView *view){
        TTShellUserProfileViewController *profile = [[TTShellUserProfileViewController alloc] init];
        UINavigationController *nav= [[UINavigationController alloc] initWithRootViewController:profile];
        [self presentViewController:nav animated:YES completion:nil];
    };
    
    [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.view addSubview:obj];
        [obj mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(70));
            make.left.equalTo(@50);
            make.right.equalTo(@(-50));
            make.bottom.equalTo(@(-150));
        }];
        ((TTShellMatchView *)obj).removeFinish = block;
        ((TTShellMatchView *)obj).tapBlock = tap;
    }];
    
    UIButton *refresh = [[UIButton alloc] init];
    [refresh setImage:[UIImage imageNamed:@"tt_home_middle_refresh"] forState:UIControlStateNormal];
    [self.view addSubview:refresh];
    [refresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view.mas_bottom).offset(-75);
    }];
    
    UIButton *hate = [[UIButton alloc] init];
    [hate setImage:[UIImage imageNamed:@"tt_home_middle_hate"] forState:UIControlStateNormal];
    [self.view addSubview:hate];
    [hate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(refresh);
        make.right.equalTo(refresh.mas_left).offset(-60);
    }];
    
    UIButton *like = [[UIButton alloc] init];
    [like setImage:[UIImage imageNamed:@"tt_home_middle_like"] forState:UIControlStateNormal];
    [self.view addSubview:like];
    [like mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(refresh);
        make.left.equalTo(refresh.mas_right).offset(60);
    }];
    
}

- (void)animationViews{
    
    CGFloat scaleX = (MaxXScale - 1) / (MaxCount * 1.0);
    CGFloat scaleY = (MaxYScale - 1) / (MaxCount * 1.0);
    CGFloat margin = 7.0;
    NSMutableArray<NSValue *> *transforms = [NSMutableArray array];
    [self.views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat scaleH = obj.height * (idx * scaleY * 0.5);
        CGFloat translate = scaleH + idx * margin;
        CGAffineTransform transform = CGAffineTransformMakeScale(1 + scaleX * idx, 1 + scaleY * idx);
        transform = CGAffineTransformTranslate(transform, 0, -translate);
        [transforms addObject:[NSValue valueWithCGAffineTransform:transform]];
        
        obj.userInteractionEnabled = idx == MaxCount - 1;
    }];
    
    [UIView animateWithDuration:1 animations:^{
        self.views[0].transform = [transforms[0] CGAffineTransformValue];
        self.views[1].transform = [transforms[1] CGAffineTransformValue];
        self.views[2].transform = [transforms[2] CGAffineTransformValue];
        self.views[3].transform = [transforms[3] CGAffineTransformValue];
    }];
}

@end
