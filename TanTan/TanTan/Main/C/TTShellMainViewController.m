//
//  TTShellMainViewController.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellMainViewController.h"
#import "TTShellMatchViewController.h"
#import "TTShellHomeViewController.h"
#import "TTShellMessageViewController.h"
#import "TTShellMainTopNavView.h"
#import "UIImage+ShareWork.h"

@interface TTShellMainViewController ()

@end

@implementation TTShellMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    TTShellHomeViewController *home = [[TTShellHomeViewController alloc] init];
    [self addChildViewController:home];
    
    TTShellMatchViewController *match = [[TTShellMatchViewController alloc] init];
    [self addChildViewController:match];
    
    TTShellMessageViewController *message = [[TTShellMessageViewController alloc] init];
    [self addChildViewController:message];
    
    TTShellMainTopNavView *navView = [[TTShellMainTopNavView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth - 40, 44)];
    [navView setBtnClickBlock:^(NSInteger index) {
        self.selectedIndex = index;
    }];
    self.navigationItem.titleView = navView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor blackColor]] forBarMetrics:UIBarMetricsDefault];
    [self.tabBar removeFromSuperview];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.tabBar removeFromSuperview];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
}

@end
