//
//  ShareWorkBaseTableController.m
//  ShareWork
//
//  Created by 周发明 on 2018/4/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkBaseTableController.h"
#import <Masonry.h>
#import <MJRefresh.h>
#import <IQKeyboardManager.h>
@interface ShareWorkBaseTableController ()

@end

@implementation ShareWorkBaseTableController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self configurationViewDidLoadFirst];
    [self configurationSubviews];
    [self configurationViewDidLoadLast];
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

- (void)configurationViewDidLoadFirst{
    self.showEmpty = YES;
}
- (void)configurationViewDidLoadLast{
    
}

- (void)headerRefresh{
    
}

- (void)footerRefresh{
    
}

//- (void)setTotalPage:(NSInteger)totalPage{
//    _totalPage = totalPage;
//    if (totalPage <= 1) {
//        [self.tableView.mj_footer endRefreshing];
//    }
//}

- (void)configurationRegisterCell:(UITableView *)table{
    [table registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)configurationSubviews{
    self.tableView.backgroundColor = MainBackgroundColor;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
//        make.left.right.bottom.equalTo(self.view);
//        make.top.mas_equalTo(self.view).offset(self.topNavHeight);
    }];
}

#pragma mark -- tableViewDelegate & dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
}

#pragma mark -- getter
- (UITableView *)tableView{
    if (nil == _tableView) {
        ShareWorkBaseTableView *table = [[ShareWorkBaseTableView alloc] initWithFrame:CGRectZero style:self.tableStyle];
        if (self.showEmpty) {
            table.showEmptyView = YES;
            table.emptyText = @"暂无数据";
            table.emptyImg = [UIImage imageNamed:@"table_nodata"];
        }
        
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.separatorColor = MainBackgroundColor;
        [self configurationRegisterCell:table];
        if (self.hasHeader) {
            table.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        }
        if (self.hasFooter) {
            table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
        }
        [self.view addSubview:table];
        _tableView = table;
    }
    return _tableView;
}

- (NSMutableArray *)items{
    if (nil == _items) {
        _items = [NSMutableArray array];
    }
    return _items;
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
