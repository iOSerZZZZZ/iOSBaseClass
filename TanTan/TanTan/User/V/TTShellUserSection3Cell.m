//
//  TTShellUserSection3Cell.m
//  TanTan
//
//  Created by 周发明 on 2018/8/23.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellUserSection3Cell.h"

@interface TTShellUserSection3Cell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation TTShellUserSection3Cell


- (void)updateData:(NSDictionary *)data{
    self.titleLabel.text = data[@"leftTitle"];
    self.valueLabel.text = data[@"rightValue"];
}


@end
