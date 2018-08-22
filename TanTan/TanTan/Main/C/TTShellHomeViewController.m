//
//  TTShellHomeViewController.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellHomeViewController.h"

@interface TTShellHomeViewController ()

@end

@implementation TTShellHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [self initSubViews];
}

- (void)initSubViews{
    
    UIButton *btn = [[UIButton alloc] init];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn setTitle:@"查看/编辑" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_HEX(0x747576) forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(changeProfile) forControlEvents:UIControlEventTouchUpInside];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    UILabel *name = [[UILabel alloc] init];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:15];
    name.text = @"呵呵哒";
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(btn.mas_top).offset(-15);
    }];
    
    UIImageView *icon = [[UIImageView alloc] init];
    icon.backgroundColor = COLOR_HEX(0xeeeeee);
    [self.view addSubview:icon];
    [icon drawLayerBorderWithColor:COLOR_HEX(0x999999) Width:2];
    [icon drawLayerCornerWithRadius:51];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@102);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(name.mas_top).offset(-25);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = COLOR_HEX(0xC5A771);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@63);
        make.right.equalTo(@(-63));
        make.top.equalTo(btn.mas_bottom).offset(25);
        make.height.equalTo(@1);
    }];
    
    UIButton *setting = [[UIButton alloc] init];
    [setting setImage:[UIImage imageNamed:@"tt_home_left_setting"] forState:UIControlStateNormal];
    [setting setTitle:@"设置" forState:UIControlStateNormal];
    [self.view addSubview:setting];
    [setting mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_centerX);
        make.width.equalTo(@90);
        make.height.equalTo(@70);
        make.top.equalTo(line.mas_bottom);
    }];
}

- (void)changeProfile{
    
}

@end
