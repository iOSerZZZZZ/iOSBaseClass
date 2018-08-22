//
//  TTShellMatchView.h
//  TanTan
//
//  Created by 周发明 on 2018/8/22.
//  Copyright © 2018年 炫小七. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTShellMatchView : UIView

@property(nonatomic, copy)void(^removeFinish)(TTShellMatchView *view, BOOL isLeftTop);
@property(nonatomic, copy)void(^tapBlock)(TTShellMatchView *view);

@end
