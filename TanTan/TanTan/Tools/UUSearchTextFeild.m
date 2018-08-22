//
//  UUSearchTextFeild.m
//  UUWorking
//
//  Created by apple on 2018/4/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "UUSearchTextFeild.h"

@implementation UUSearchTextFeild


-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        self.returnKeyType = UIReturnKeySearch;
        
    }
    
    return self;
}

-(CGRect) textRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super textRectForBounds:bounds];
    iconRect.origin.x+=10;
    return iconRect;
}
//改变编辑时文字位置
-(CGRect) editingRectForBounds:(CGRect)bounds{
    CGRect iconRect=[super editingRectForBounds:bounds];
    iconRect.origin.x+=10;
    return iconRect;
}

@end
