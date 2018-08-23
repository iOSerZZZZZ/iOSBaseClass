//
//  TTShellUserProfileViewController.m
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellUserProfileViewController.h"
#import "TTShellUserInfoView.h"

#import "TTShellUserEditPhotoView.h"
#import <SDCycleScrollView.h>

#import "TTShellUserSection1Cell.h"
#import "TTShellUserSection2Cell.h"
#import "TTShellUserSection3Cell.h"


@interface TTShellUserProfileViewController ()

@property(nonatomic, assign)BOOL isEditing;
@property(nonatomic, strong)NSMutableArray *sections;

@property(nonatomic, weak)SDCycleScrollView *photoView;
@property(nonatomic, weak)TTShellUserEditPhotoView *photoEditView;

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
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"tt_nav_share"] style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    } else {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
    }
}

- (void)configurationRegisterCell:(UITableView *)table{
    [super configurationRegisterCell:table];
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([TTShellUserSection1Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TTShellUserSection1Cell class])];
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([TTShellUserSection2Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TTShellUserSection2Cell class])];
    [table registerNib:[UINib nibWithNibName:NSStringFromClass([TTShellUserSection3Cell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([TTShellUserSection3Cell class])];
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
                               rightValue:@"那英,关喆,Eason,那英,关喆,Eason,那英,关喆,Eason,那英,关喆,Eason"
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
    
    SDCycleScrollView *scrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth) delegate:self placeholderImage:nil];
    [header addSubview:scrollView];
    self.photoView = scrollView;
    
    TTShellUserEditPhotoView *editPhoto = [[[NSBundle mainBundle] loadNibNamed:@"TTShellUserEditPhotoView" owner:nil options:nil] lastObject];
    editPhoto.hidden = YES;
    editPhoto.frame = CGRectMake(0, 0, KScreenWidth, KScreenWidth);
    [header addSubview:editPhoto];
    self.photoEditView = editPhoto;
    
    self.tableView.tableHeaderView = header;
}

- (void)dimissNav{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)moreClick{
    
}

- (void)editClick{
    self.isEditing = YES;
    self.photoEditView.hidden = NO;
    self.photoView.hidden = YES;
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveClick)];
}

- (void)saveClick{
    self.isEditing = NO;
    self.photoEditView.hidden = YES;
    self.photoView.hidden = NO;
    [self.tableView reloadData];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(editClick)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.sections[section][@"items"] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cell_id = nil;
    if (indexPath.section == 0) {
        cell_id = NSStringFromClass([TTShellUserSection1Cell class]);
    } else if (indexPath.section == 1) {
        cell_id = NSStringFromClass([TTShellUserSection2Cell class]);
    } else {
        cell_id = NSStringFromClass([TTShellUserSection3Cell class]);
    }
    
    TTShellUserBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cell_id];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(TTShellUserBaseCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    cell.accessoryType = self.isEditing ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    [cell updateData:self.sections[indexPath.section][@"items"][indexPath.row]];
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



- (CGFloat)heightWithIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 45;
    }
    
    NSDictionary *dict = self.sections[indexPath.section][@"items"][indexPath.row];
    NSString *title = dict[leftTitle];
    NSString *value = dict[rightValue];
    if (indexPath.section == 1) {
        NSArray *titles = [value componentsSeparatedByString:@","];
        NSMutableArray *rects = [NSMutableArray array];
        CGFloat btnH = 25; // 高度
        CGFloat leftMargin = 15;//左右间距
        CGFloat margin = 10; // 间距
        CGFloat insetMargin = 6;// 内边距
        NSInteger lines = 0; // 行数
        NSInteger count = titles.count;// 总个数
        UIFont *btnFont = [UIFont systemFontOfSize:14]; // 字体大小
        CGFloat availableMaxW = KScreenWidth - (self.isEditing ? 30 : 0);
        CGFloat remainWidth = availableMaxW - 20 - leftMargin * 2;// 剩余宽度
        for (int i = 0; i < count; i++) {
            NSString *title = titles[i];
            CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName : btnFont}].width;
            CGFloat btnW = width + insetMargin * 2;
            CGFloat btnX = 0;
            CGFloat btnY = 0;
            if ((btnW + margin) < remainWidth) { // 可以放在这一行
                btnX = availableMaxW - remainWidth - margin + leftMargin;
                btnY = lines * (btnH + margin) + margin;
            } else { // 剩余不够
                lines++;
                remainWidth = availableMaxW - 20 - leftMargin * 2;
                btnX = availableMaxW - remainWidth - margin + leftMargin;
                btnY = lines * (btnH + margin) + margin;
            }
            CGRect frame = CGRectMake(btnX,btnY,btnW,btnH);
            remainWidth = remainWidth - btnW - margin;
            [rects addObject:[NSValue valueWithCGRect:frame]];
        }
        
        NSMutableDictionary *dictM = [dict mutableCopy];
        dictM[@"rects"] = rects;
        [self.sections[indexPath.section][@"items"] replaceObjectAtIndex:indexPath.row withObject:dictM];
        return 9 + (lines + 1) * (btnH + margin);
    }
    
    CGFloat leftHeight = [title boundingRectWithSize:CGSizeMake(KScreenWidth - (self.isEditing ? 60 : 30), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    CGFloat valueHeight = [value boundingRectWithSize:CGSizeMake(KScreenWidth - (self.isEditing ? 60 : 30), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    return 7 + leftHeight + 8 + valueHeight + 5;
}

@end
