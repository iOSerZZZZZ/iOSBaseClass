//
//  TTShellUserProfileViewController.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellUserProfileViewController.h"
#import "TTShellUserInfoView.h"

@interface TTShellUserProfileViewController ()
@property(nonatomic, assign)BOOL isEditing;
@property(nonatomic, strong)NSMutableArray *sections;
@end

static NSString const *leftTitle = @"leftTitle";
static NSString const *rightValue = @"rightValue";

@implementation TTShellUserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.isSelf ? @"自己" : @"别人";
    // Do any additional setup after loading the view.
    
    if (!self.isSelf) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(dimissNav)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tt_nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareClick)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    }
}

- (void)configurationViewDidLoadFirst{
    [super configurationViewDidLoadFirst];
    self.sections = [NSMutableArray array];
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"title"] = self.isSelf ? @"我的信息" : @"TA的信息";
        NSMutableArray *items = [NSMutableArray array];
        {
            [items addObject:@{
                               leftTitle:@"星座",
                               rightValue:@"双鱼座"
                               }];
            [items addObject:@{
                               leftTitle:@"职业",
                               rightValue:@"文艺"
                               }];
            [items addObject:@{
                               leftTitle:@"领域",
                               rightValue:@"互联网"
                               }];
            [items addObject:@{
                               leftTitle:@"家乡",
                               rightValue:@"草原"
                               }];
        }
        dict[@"items"] = items;
        [self.sections addObject:dict];
    }
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"title"] = self.isSelf ? @"我的喜好" : @"TA的喜好";
        NSMutableArray *items = [NSMutableArray array];
        {
            [items addObject:@{
                               leftTitle:@"tt_user_detail_yundong",
                               rightValue:@"跑步,篮球,足球,健身"
                               }];
            [items addObject:@{
                               leftTitle:@"tt_user_detail_yinyue",
                               rightValue:@"那英,关喆,Eason,那英,关喆,Eason,那英,关喆,Eason,那英,关喆,Eason,"
                               }];
            [items addObject:@{
                               leftTitle:@"tt_user_detail_meishi",
                               rightValue:@"牛排,烧烤,鹅肝,腰子"
                               }];
            [items addObject:@{
                               leftTitle:@"tt_user_detail_dianying",
                               rightValue:@"教父,复联,黑镜,雷神"
                               }];
            [items addObject:@{
                               leftTitle:@"tt_user_detail_xiaoshuo",
                               rightValue:@"教父,复联,黑镜,雷神"
                               }];
            [items addObject:@{
                               leftTitle:@"tt_user_detail_feiji",
                               rightValue:@"教父,复联,黑镜,雷神"
                               }];
        }
        dict[@"items"] = items;
        [self.sections addObject:dict];
    }
    {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[@"title"] = self.isSelf ? @"我的问答" : @"TA的问答";
        NSMutableArray *items = [NSMutableArray array];
        [items addObject:@{
                           leftTitle:@"我的问题一",
                           rightValue:@"我的答案一"
                           }];
        [items addObject:@{
                           leftTitle:@"我的问题二",
                           rightValue:@"我的答案二"
                           }];
        dict[@"items"] = items;
        [self.sections addObject:dict];
    }
}

- (void)configurationViewDidLoadLast{
    [super configurationViewDidLoadLast];
    CGFloat infoH = 75;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth + infoH)];
    header.backgroundColor = COLOR_HEX(0xeeeeee);
    
    
    UIView *infoView = [[UIView alloc] init];
    [header addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(infoH));
    }];
    TTShellUserInfoView *info = [[[NSBundle mainBundle] loadNibNamed:@"TTShellUserInfoView" owner:nil options:nil] lastObject];
    [infoView addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.equalTo(@0);
    }];
    self.tableView.tableHeaderView = header;
}

- (void)dimissNav{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)shareClick{
    
}

- (void)editClick{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
}

- (void)saveClick{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sections[section][@"items"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = self.sections[section][@"title"];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = COLOR_HEX(0x999999);
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.centerY.equalTo(@0);
    }];
    return view;
}

@end
