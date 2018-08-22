//
//  SWNetManager.h
//  ShareWork
//
//  Created by 周发明 on 2018/4/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "SWNetError.h"
#import "ShareWorkApi.h"

/**
 请求结束的回调

 @param error 响应的错误信息
 @param dataModel data的实体
 */
typedef void(^SWNetManagerCallBackBlock)(SWNetError *error, id dataModel);

@interface SWNetManager : NSObject
@property(nonatomic, copy)NSString *baseUrl;
+ (instancetype)manager;

/**
 配置基础的域名服务器

 @param baseUrl 服务器地址
 */
- (void)configurationBaseUrl:(NSString *)baseUrl;

/**
 配置网路请求错误时, 弹出的提示

 @param netErrorMsg 提示的文字
 */
- (void)configurationNetErrorMsg:(NSString *)netErrorMsg;

/**
 配置请求是需要加上的token

 @param token token
 */
- (void)configurationToken:(NSString *)token;

/**
 Get请求

 @param path 短路劲
 @param parameters 参数
 @param hasToken 是否需要token
 @param dataClass data的需要转为的实体, 传NSDictionary则不转
 @param callBack 请求结束的回调
 */
- (void)requestGetWithPath:(NSString *)path parameters:(NSDictionary *)parameters hasToken:(BOOL)hasToken dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack;






/**
 POST请求

 @param path 短路劲
 @param parameters 参数
 @param hasToken 是否需要token
 @param dataClass data的需要转为的实体, 传NSDictionary则不转
 @param callBack 请求结束的回调
 */
- (void)requestPostWithPath:(NSString *)path parameters:(NSDictionary *)parameters hasToken:(BOOL)hasToken dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack;

/**
 上传文件

 @param path 同上
 @param parameters 同上
 @param hasToken 同上
 @param constructingBody 拼接文件上传
 @param progress 进度回调
 @param dataClass 同上
 @param callBack 同上
 */
- (void)uploadWithPath:(NSString *)path parameters:(NSDictionary *)parameters hasToken:(BOOL)hasToken constructingBody:(void(^)(id<AFMultipartFormData> formData))constructingBody progress:(void(^)(NSProgress *uploadProgress))progress dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack;

@end
