//
//  SWAlertManager.m
//  ShareWork
//
//  Created by 周发明 on 2018/5/11.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SWAlertManager.h"

@interface SWAlertManager()

@property(nonatomic, weak)UIView *baseView;

@property(nonatomic, weak)UILabel *contentLabel;

@property(nonatomic, weak)UIButton *cancelButton;

@property(nonatomic, weak)UIButton *okButton;

@property(nonatomic, weak)UIView *buttonView;


@property(nonatomic, copy)SWAlertManagerButtonClickBlock cancelBlock;

@property(nonatomic, copy)SWAlertManagerButtonClickBlock okBlock;

@property(nonatomic, copy)void(^extraBlock)();

@end

#define SWAlertManagerBaseViewWitdth (KScreenWidth == 320 ? 260 : (KScreenWidth - 104))
#define SWAlertManagerButtonViewHeight (50)

static SWAlertManager *_SWAlertManagerInstance;

@implementation SWAlertManager

+ (void)initializeFirst{
    if (_SWAlertManagerInstance == nil) {
        _SWAlertManagerInstance = [[SWAlertManager alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:_SWAlertManagerInstance];
    }
    [_SWAlertManagerInstance hide];
}

+ (void)showMessage:(NSString *)message meaageColor:(UIColor *)messageColor cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle cancelButtonBlock:(SWAlertManagerButtonClickBlock)cancelBlock okButtonBlock:(SWAlertManagerButtonClickBlock)okBlock{
    if (_SWAlertManagerInstance == nil) {
        _SWAlertManagerInstance = [[SWAlertManager alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [[UIApplication sharedApplication].keyWindow addSubview:_SWAlertManagerInstance];
    }
    if (![[UIApplication sharedApplication].keyWindow.subviews containsObject:_SWAlertManagerInstance]) {
        [[UIApplication sharedApplication].keyWindow addSubview:_SWAlertManagerInstance];
    }
    [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_SWAlertManagerInstance];
    
    if (okTitle){
        [_SWAlertManagerInstance.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@((SWAlertManagerBaseViewWitdth - 1) * 0.5));
        }];
    } else {
        [_SWAlertManagerInstance.cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(SWAlertManagerBaseViewWitdth));
        }];
    }
    
    _SWAlertManagerInstance.contentLabel.text = message;
    _SWAlertManagerInstance.contentLabel.textColor = messageColor;
    [_SWAlertManagerInstance.cancelButton setTitle:cancelTitle forState:UIControlStateNormal];
    [_SWAlertManagerInstance.okButton setTitle:okTitle forState:UIControlStateNormal];
    _SWAlertManagerInstance.cancelBlock = cancelBlock;
    _SWAlertManagerInstance.okBlock = okBlock;
    [_SWAlertManagerInstance layoutIfNeeded];
    [_SWAlertManagerInstance hide];
    [_SWAlertManagerInstance show];
    _SWAlertManagerInstance.extraBlock = nil;
}

+ (void)showMessage:(NSString *)message meaageColor:(UIColor *)messageColor cancelButtonTitle:(NSString *)cancelTitle okButtonTitle:(NSString *)okTitle cancelButtonBlock:(SWAlertManagerButtonClickBlock)cancelBlock okButtonBlock:(SWAlertManagerButtonClickBlock)okBlock extraBlock:(SWAlertManagerButtonClickBlock)extraBlock{
    [self showMessage:message meaageColor:messageColor cancelButtonTitle:cancelTitle okButtonTitle:okTitle cancelButtonBlock:cancelBlock okButtonBlock:okBlock];
    _SWAlertManagerInstance.extraBlock = extraBlock;
}

+ (void)showMessage:(NSString *)message meaageColor:(UIColor *)messageColor okButtonTitle:(NSString *)okTitle okButtonBlock:(SWAlertManagerButtonClickBlock)okBlock{
    [self showMessage:message meaageColor:messageColor cancelButtonTitle:okTitle okButtonTitle:nil cancelButtonBlock:okBlock okButtonBlock:nil extraBlock:okBlock];
}

+ (void)showMessage:(NSString *)message{
    [self showMessage:message meaageColor:[UIColor blackColor] cancelButtonTitle:@"确定" okButtonTitle:nil cancelButtonBlock:nil okButtonBlock:nil extraBlock:nil];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@(SWAlertManagerBaseViewWitdth));
        }];
        
        [self.buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.baseView);
            make.height.equalTo(@(SWAlertManagerButtonViewHeight));
        }];
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@15);
            make.right.equalTo(@(-15));
            make.top.equalTo(@(30));
            make.bottom.equalTo(self.buttonView.mas_top).offset(-30);
        }];
        
        [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@1);
            make.left.bottom.equalTo(self.buttonView);
            make.width.equalTo(@((SWAlertManagerBaseViewWitdth - 1) * 0.5));
        }];
        
        [self.okButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@1);
            make.right.bottom.equalTo(self.buttonView);
            make.left.equalTo(self.cancelButton.mas_right).offset(1);
        }];
        
    }
    return self;
}

- (void)cancelButtonClick{
    [self hide];
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)okButtonClick{
    [self hide];
    if (self.okBlock) {
        self.okBlock();
    }
}

- (void)show{
    self.hidden = NO;
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    [self.superview bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.baseView.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)hide{
    [self.superview endEditing:YES];
    self.hidden = YES;
    self.baseView.transform = CGAffineTransformMakeScale(0.1, 0.1);
}

- (UIView *)baseView{
    if (_baseView == nil) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor whiteColor];
        view.layer.cornerRadius = 10;
        view.layer.masksToBounds = YES;
        [self addSubview:view];
        _baseView = view;
    }
    return _baseView;
}

- (UILabel *)contentLabel{
    if (_contentLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"我是内容";
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 0;
        [self.baseView addSubview:label];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIView *)buttonView{
    if (_buttonView == nil) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = MainBackgroundColor;
        [self.baseView addSubview:view];
        _buttonView = view;
    }
    return _buttonView;
}

- (UIButton *)cancelButton{
    if (_cancelButton == nil) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = self.baseView.backgroundColor;
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancelButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:PickerButtonTitleColor forState:UIControlStateNormal];
        [self.buttonView addSubview:btn];
        _cancelButton = btn;
    }
    return _cancelButton;
}

- (UIButton *)okButton{
    if (_okButton == nil) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = self.baseView.backgroundColor;
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(okButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:PickerButtonTitleColor forState:UIControlStateNormal];
        [self.buttonView addSubview:btn];
        _okButton = btn;
    }
    return _okButton;
}

@end
