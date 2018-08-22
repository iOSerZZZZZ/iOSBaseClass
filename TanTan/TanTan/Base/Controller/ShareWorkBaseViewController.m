//
//  ShareWorkBaseViewController.m
//  ShareWork
//
//  Created by 周发明 on 2018/4/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkBaseViewController.h"
#import <IQKeyboardManager.h>
@interface ShareWorkBaseViewController ()

@end

@implementation ShareWorkBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBackgroundColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.navigationController != nil && self.navigationController.childViewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"tt_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(back)];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
    [self setUpKeyboardManager];
    
}

- (void)setUpKeyboardManager{
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    keyboardManager.shouldToolbarUsesTextFieldTintColor = YES; // 控制键盘上的工具条文字颜色是否用户自定义
    
    keyboardManager.toolbarManageBehaviour = IQAutoToolbarBySubviews; // 有多个输入框时，可以通过点击Toolbar 上的“前一个”“后一个”按钮来实现移动到不同的输入框
    
    keyboardManager.enableAutoToolbar = YES; // 控制是否显示键盘上的工具条
    
    keyboardManager.shouldShowTextFieldPlaceholder = YES; // 是否显示占位文字
    
    keyboardManager.placeholderFont = [UIFont boldSystemFontOfSize:17]; // 设置占位文字的字体
    
    keyboardManager.keyboardDistanceFromTextField = 30.0f; // 输入框距离键盘的距离
    
    
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (CGFloat)topNavHeight{
    return self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
}
- (NSString *)getCurrentDateStr{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM"];
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}

@end
