//
//  TTShellUserSection2Cell.m
//  TanTan
//
//  Created by 周发明 on 2018/8/23.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellUserSection2Cell.h"


@interface TTShellUserSection2Cell()

@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;
@property (weak, nonatomic) IBOutlet UIView *labelsView;

@end


@implementation TTShellUserSection2Cell

- (void)updateData:(NSDictionary *)data{
    self.leftIcon.image = [UIImage imageNamed:data[@"leftTitle"]];
    
    [self.labelsView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSArray *titles = [data[@"rightValue"] componentsSeparatedByString:@","];
    for (int i = 0; i<titles.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = COLOR_HEX(0xF5586D);
        label.font = [UIFont systemFontOfSize:13];
        label.text = titles[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [label drawLayerCornerWithRadius:4];
        [self.labelsView addSubview:label];
        label.frame = [data[@"rects"][i] CGRectValue];
    }
}

@end
