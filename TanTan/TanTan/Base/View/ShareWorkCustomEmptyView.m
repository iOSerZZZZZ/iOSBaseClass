//
//  XMJRLoanCustomEmptyElement.m
//  Pods
//
//  Created by hey on 2016/12/9.
//
//

#import "ShareWorkCustomEmptyView.h"

@interface ShareWorkCustomEmptyView ()

@end

@implementation ShareWorkCustomEmptyView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
        [self createConstrains];
    }
    return self;
}

-(instancetype)initEmptyView
{
    self = [super init];
    if (self) {
        [self createViews];
        [self createConstrains];
    }
    return self;
}

-(void)createViews
{
    _infoView = [[UIView alloc] init];
    [self addSubview:_infoView];
    
    _emptyImageView = [[UIImageView alloc] init];
    [_infoView addSubview:_emptyImageView];
    
    _describeLabel = [[UILabel alloc] init];
    _describeLabel.adjustsFontSizeToFitWidth = YES;
    _describeLabel.font = [UIFont systemFontOfSize:15];
    _describeLabel.textColor = COLOR_HEX(0x999999);
    _describeLabel.textAlignment = NSTextAlignmentCenter;
    [_infoView addSubview:_describeLabel];
}

-(void)createConstrains
{
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 200));
    }];
    WeakSelf(self)
    [_emptyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.infoView).offset(20);
        make.centerX.equalTo(weakself.infoView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(150, 150));
    }];
    
    [_describeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.infoView).offset(-10);
        make.left.equalTo(weakself.infoView);
        make.right.equalTo(weakself.infoView);
    }];
}

-(void)updateViewImage:(UIImage *)image description:(NSString *)text
{
    _emptyImageView.image = image;
    _describeLabel.text = text;
}

+ (instancetype)emptyView{
    ShareWorkCustomEmptyView *empty = [[ShareWorkCustomEmptyView alloc] initWithFrame:CGRectMake(0, 0, 0, 300)];
    [empty updateViewImage:[UIImage imageNamed:@"table_nodata"] description:@"暂无数据"];
    return empty;
}

@end
