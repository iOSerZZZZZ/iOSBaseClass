//
//  SPayDatePicker.m
//  SPay
//
//  Created by Golder on 2017/3/27.
//  Copyright © 2017年 YNET. All rights reserved.
//

#import "SPayDatePicker.h"
//#import "SPayCommon.h"

@interface SPayDatePicker () <UIScrollViewDelegate>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UINavigationBar *navigateBar;
@property (nonatomic, strong) UIDatePicker *startPicker;
@property (nonatomic, strong) UIDatePicker *endPicker;

@end

@implementation SPayDatePicker

+ (instancetype)datePickerWithMode:(UIDatePickerMode)pickerMode {
    SPayDatePicker *picker = [[SPayDatePicker alloc] initWithFrame:[UIScreen mainScreen].bounds];
    picker.datePickerMode = pickerMode;
    return picker;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    _maskView = [[UIView alloc] initWithFrame:CGRectZero];
    _maskView.backgroundColor = [UIColor blackColor];
    _maskView.layer.opacity = 0.4;
    [_maskView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    [self addSubview:_maskView];
    
    _backView = [[UIView alloc] initWithFrame:CGRectZero];
    _backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_backView];
    
    _navigateBar = [[UINavigationBar alloc] initWithFrame:CGRectZero];
    _navigateBar.barTintColor = [UIColor whiteColor];
    _navigateBar.tintColor = /*[UIColor colorWithRed:0 green:64.0/255.0 blue:128.0/255.0 alpha:1.0]*/[UIColor redColor];
    [_navigateBar pushNavigationItem:[self startNavItem] animated:NO];
    [_backView addSubview:_navigateBar];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    _scrollView.scrollEnabled = NO;
    [_backView addSubview:_scrollView];
    
    _startPicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _startPicker.datePickerMode = _datePickerMode;
      [_startPicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"]];
    [_scrollView addSubview:_startPicker];
    
    _endPicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    _endPicker.datePickerMode = _datePickerMode;
    [_endPicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"]];
    [_scrollView addSubview:_endPicker];
    
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    _startPicker.datePickerMode = datePickerMode;
    _endPicker.datePickerMode = datePickerMode;
}

- (UINavigationItem *)startNavItem {
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"起始日期"];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelPicker)];
    [left setTitlePositionAdjustment:UIOffsetMake(8, 0) forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"结束日期 >" style:UIBarButtonItemStylePlain target:self action:@selector(changeToEndDatePicker)];
    [right setTitlePositionAdjustment:UIOffsetMake(-8, 0) forBarMetrics:UIBarMetricsDefault];
    navItem.leftBarButtonItem = left;
    navItem.rightBarButtonItem = right;
    return navItem;
}

- (UINavigationItem *)endNavItem {
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"结束日期"];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"< 起始日期" style:UIBarButtonItemStylePlain target:self action:@selector(changeToStartDatePicker)];
    [left setTitlePositionAdjustment:UIOffsetMake(8, 0) forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(finishPicker)];
    [right setTitlePositionAdjustment:UIOffsetMake(-8, 0) forBarMetrics:UIBarMetricsDefault];
    navItem.leftBarButtonItem = left;
    navItem.rightBarButtonItem = right;
    return navItem;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat tWidth = CGRectGetWidth(self.frame);
    CGFloat tHeight = CGRectGetHeight(self.frame);
    
    _maskView.frame = self.bounds;
    _backView.frame = CGRectMake(0, tHeight-260, tWidth, 260);
    _navigateBar.frame = CGRectMake(0, 0, tWidth, 44);
    _scrollView.frame = CGRectMake(0, CGRectGetMaxY(_navigateBar.frame), tWidth, 216);
    _scrollView.contentSize = CGSizeMake(tWidth*2, 216);
    _startPicker.frame = CGRectMake(0, 0, tWidth, 216);
    _endPicker.frame = CGRectMake(tWidth, 0, tWidth, 216);
}

#pragma mark - Action

- (void)cancelPicker {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerCancelPicker:)]) {
        [self.delegate datePickerCancelPicker:self];
    }
    [self hide];
}

- (void)finishPicker {
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePicker:didPickerStart:endDate:)]) {
        [self.delegate datePicker:self didPickerStart:_startPicker.date endDate:_endPicker.date];
    }
    [self hide];
}

- (void)changeToEndDatePicker {
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    _endPicker.minimumDate = _startPicker.date;
    
    [_navigateBar pushNavigationItem:[self endNavItem] animated:YES];
    [_scrollView setContentOffset:CGPointMake(width, 0) animated:YES];
}

- (void)changeToStartDatePicker {
    if (_navigateBar.items.count > 1) {
        [_navigateBar popNavigationItemAnimated:YES];
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

- (void)show {
    
    dispatch_block_t block = ^{
        
        [self changeToStartDatePicker];
    
        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        
        if ([window.subviews.lastObject isKindOfClass:[SPayDatePicker class]]) {
            return;
        }
        
        [self becomeFirstResponder];
        self.frame = window.bounds;
        
        CATransition *transition = [CATransition animation];
        transition.type = kCATransitionFade;
        [window.layer addAnimation:transition forKey:@"transition"];
        [window addSubview:self];
        
        [CATransaction begin];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = @0.0;
        opacity.toValue = @0.4;
        [_maskView.layer addAnimation:opacity forKey:@"opacity"];
        
        CGFloat tHeight = CGRectGetHeight(self.frame);
        CABasicAnimation *pop = [CABasicAnimation animationWithKeyPath:@"position.y"];
        pop.fromValue = @(tHeight+130);
        pop.toValue = @(tHeight-130);
        [_backView.layer addAnimation:pop forKey:@"pop"];
        
        [CATransaction commit];
    };
    
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)hide {
    
    dispatch_block_t block = ^{
        
        [self resignFirstResponder];
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            [_maskView.layer removeAnimationForKey:@"opacity"];
            [_backView.layer removeAnimationForKey:@"down"];
            [self removeFromSuperview];
        }];
        
        CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacity.fromValue = @0.5;
        opacity.toValue = @0.0;
        opacity.removedOnCompletion = NO;
        opacity.fillMode = kCAFillModeForwards;
        [_maskView.layer addAnimation:opacity forKey:@"opacity"];
        
        CGFloat height = CGRectGetHeight(self.frame);
        CABasicAnimation *down = [CABasicAnimation animationWithKeyPath:@"position.y"];
        down.fromValue = @(height-130);
        down.toValue = @(height+130);
        down.removedOnCompletion = NO;
        down.fillMode = kCAFillModeForwards;
        [_backView.layer addAnimation:down forKey:@"down"];
        
        [CATransaction commit];
    };
    if (dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue())) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

@end
