//
//  SWNetError.h
//  ShareWork
//
//  Created by 周发明 on 2018/4/30.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    SWNetErrorCodeSuccess = 200,
    SWNetErrorCodeTokenExpire = 401,
} SWNetErrorCode;


@interface SWNetError : NSObject

/**
 状态码
 */
@property(nonatomic, assign)NSInteger  code;

/**
 消息提示
 */
@property(nonatomic, copy)NSString *msg;

/**
 返回响应没有解析的数据
 */
@property(nonatomic, strong)id data;
@end
