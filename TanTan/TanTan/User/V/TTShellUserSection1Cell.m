//
//  TTShellUserSection1Cell.m
//  TanTan
//
//  Created by 周发明 on 2018/8/23.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellUserSection1Cell.h"

@interface TTShellUserSection1Cell()

@property (weak, nonatomic) IBOutlet UILabel *leftTitleLabel;

@property (weak, nonatomic) IBOutlet UILabel *rightValueLabel;

@end

@implementation TTShellUserSection1Cell

- (void)updateData:(NSDictionary *)data{
    self.leftTitleLabel.text = data[@"leftTitle"];
    self.rightValueLabel.text = data[@"rightValue"];
}

@end
