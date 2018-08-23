//
//  TTShellUserBaseCell.m
//  TanTan
//
//  Created by 周发明 on 2018/8/23.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import "TTShellUserBaseCell.h"

@implementation TTShellUserBaseCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)updateData:(NSDictionary *)data{
    
}

@end
