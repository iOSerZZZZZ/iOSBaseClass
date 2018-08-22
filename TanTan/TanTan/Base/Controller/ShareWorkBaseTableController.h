//
//  ShareWorkBaseTableController.h
//  ShareWork
//
//  Created by 周发明 on 2018/4/20.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkBaseViewController.h"
#import "ShareWorkBaseTableView.h"
#import "ShareWorkCustomEmptyView.h"

@interface ShareWorkBaseTableController : ShareWorkBaseViewController<UITableViewDelegate, UITableViewDataSource>

/**
 列表
 默认已注册UITableviewCell
 */
@property(nonatomic, weak)ShareWorkBaseTableView *tableView;
@property(nonatomic, assign)BOOL  showEmpty;
@property(nonatomic, assign)NSInteger currentPage;
@property(nonatomic, assign)NSInteger totalPage;

/**
 是否有header
 */
@property(nonatomic, assign)NSInteger hasHeader;

/**
 是否有footer
 */
@property(nonatomic, assign)NSInteger hasFooter;
@property(nonatomic, assign)UITableViewStyle tableStyle;// 列表的样式
@property(nonatomic, strong)NSMutableArray *items;// 列表所需的数据    懒加载
/**
 viewDidLoad里面最先调用的方法
 */
- (void)configurationViewDidLoadFirst;
/**
 viewDidLoad里面最后调用的方法
 */
- (void)configurationViewDidLoadLast;
/**
 注册cell
 */
- (void)configurationRegisterCell:(UITableView *)table;
// header刷新的方法
- (void)headerRefresh;
// footer刷新的方法
- (void)footerRefresh;
@end
