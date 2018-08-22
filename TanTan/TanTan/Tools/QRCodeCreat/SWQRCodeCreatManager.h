//
//  SWQRCodeCreatManager.h
//  ShareWork
//
//  Created by 周发明 on 2018/5/8.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SWQRCodeCreatType) {
    SWQRCodeCreatTypeError = -1,
    SWQRCodeCreatTypeOrderPunchCard = 0, // 订单签到
    SWQRCodeCreatTypeApplyTeamOrGroup = 1, // 加入班组
    SWQRCodeCreatTypeAreaPunchCard = 2, // 工地打卡
};

@interface SWQRCodeCreatManager : NSObject

+ (instancetype)manager;
- (UIImage *)creatImageWithString:(NSString *)string type:(SWQRCodeCreatType)type;
- (void)handleResule:(NSString *)result success:(void(^)(NSString *text, SWQRCodeCreatType type))success;
@end
