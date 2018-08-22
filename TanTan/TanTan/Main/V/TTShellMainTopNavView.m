//
//  TTShellMainTopNavView.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellMainTopNavView.h"

@implementation TTShellMainTopNavView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews{
    NSArray *titles = @[@"主页", @"匹配", @"消息"];
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:obj forState:UIControlStateNormal];
        [self addSubview:btn];
        btn.tag = idx;
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(self.width * (idx / (titles.count * 1.0))));
            make.top.bottom.equalTo(@0);
            make.width.equalTo(@(self.width * (1 / (titles.count * 1.0))));
        }];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }];
}

- (void)btnClick:(UIButton *)sender{
    if (self.btnClickBlock) {
        self.btnClickBlock(sender.tag);
    }
}

- (CGSize)intrinsicContentSize{
    return CGSizeMake(KScreenWidth - 40, 44);
}

@end
