//
//  ShareWorkPickerImageManage.h
//  ShareWork
//
//  Created by 周发明 on 2018/5/2.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^ShareWorkPickerImageManageBlock)(UIImage *image);

@interface ShareWorkPickerImageManage : NSObject

+ (instancetype)manager;

-(void)showToViewController:(UIViewController *)vc canEdit:(BOOL)canEdit finishBlock:(ShareWorkPickerImageManageBlock)finishBlock;

-(void)showToViewController:(UIViewController *)vc  onlyCameraCanEdit:(BOOL)canEdit finishBlock:(ShareWorkPickerImageManageBlock)finishBlock;

@end
