//
//  SWNetManager.m
//  ShareWork
//
//  Created by 周发明 on 2018/4/29.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SWNetManager.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>
//#import "ShareWorkNavViewController.h"
//#import "ShareWorkerLoginViewController.h"
#import "SWAlertManager.h"

@interface SWNetManager()

@property(nonatomic, strong)AFHTTPSessionManager *manager;


@property(nonatomic, copy)NSString *netErrorMsg;
@property(nonatomic, copy)NSString *token;
@end

@implementation SWNetManager

+ (instancetype)manager{
    static SWNetManager *_SWNetManagerInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SWNetManagerInstance = [[SWNetManager alloc] init];
    });
    return _SWNetManagerInstance;
}

- (void)configurationBaseUrl:(NSString *)baseUrl{
    self.baseUrl = baseUrl;
}

- (void)configurationNetErrorMsg:(NSString *)netErrorMsg{
    self.netErrorMsg = netErrorMsg;
}
- (void)configurationToken:(NSString *)token{
    self.token = token;
//    [self.manager.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
}

- (void)requestGetWithPath:(NSString *)path parameters:(NSDictionary *)parameters hasToken:(BOOL)hasToken dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack{
    NSString *url;
    if ([path containsString:@"http://"]) {
        
        url = path;
        
    }else{
        url = [self.baseUrl stringByAppendingString:path];
    }
    NSMutableDictionary *param = [parameters mutableCopy];
    if (hasToken) {
        [self.manager.requestSerializer setValue:self.token ?: [[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forHTTPHeaderField:@"Authorization"];
    }
    [SVProgressHUD show];
    [self printUrl:url param:param hasToken:hasToken];
    [self.manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self requestSuccessActionResponse:responseObject dataClass:dataClass callBackBlock:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self requestFail:error callBackBlock:callBack];
    }];
}

- (void) requestPostWithPath:(NSString *)path parameters:(NSDictionary *)parameters hasToken:(BOOL)hasToken dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack{
    NSString *url;
    if ([path containsString:@"http://"]) {
        
        url = path;
        
    }else{
      url = [self.baseUrl stringByAppendingString:path];
    }
   
    NSMutableDictionary *param = [parameters mutableCopy];
    if (hasToken) {
        [self.manager.requestSerializer setValue:self.token ?: [[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forHTTPHeaderField:@"Authorization"];

    }
    [SVProgressHUD show];
    [self printUrl:url param:param hasToken:hasToken];
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self requestSuccessActionResponse:responseObject dataClass:dataClass callBackBlock:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self requestFail:error callBackBlock:callBack];
    }];
}

- (void)uploadWithPath:(NSString *)path parameters:(NSDictionary *)parameters hasToken:(BOOL)hasToken constructingBody:(void(^)(id<AFMultipartFormData> formData))constructingBody progress:(void(^)(NSProgress *uploadProgress))progress dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack{
    NSString *url = [self.baseUrl stringByAppendingString:path];
    NSMutableDictionary *param = [parameters mutableCopy];
    if (hasToken) {
        [self.manager.requestSerializer setValue:self.token ?: [[NSUserDefaults standardUserDefaults] objectForKey:@"token"] forHTTPHeaderField:@"Authorization"];
    }
    [SVProgressHUD show];
    [self printUrl:url param:param hasToken:hasToken];
    [self.manager POST:url parameters:param constructingBodyWithBlock:constructingBody progress:progress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        [self requestSuccessActionResponse:responseObject dataClass:dataClass callBackBlock:callBack];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [self requestFail:error callBackBlock:callBack];
    }];
}


- (id)modelWithDataClass:(Class)dataClass error:(SWNetError *)swError{
    id model;
    if ([swError.data isKindOfClass:[NSArray class]] && dataClass != [NSDictionary class] && dataClass != [NSArray class]) {
        // data是数组类型  并且传入的类不是数组 不是字典  转模型出去
        model = [dataClass mj_objectArrayWithKeyValuesArray:swError.data];
    } else if ([swError.data isKindOfClass:[NSDictionary class]] && dataClass != [NSDictionary class] && dataClass != [NSArray class]) {
        // data是字典类型  并且传入的类不是数组 不是字典  转模型出去
        model = [dataClass mj_objectWithKeyValues:swError.data];
    } else {
        //  否则直接返回data
        model = swError.data;
    }
    return model;
}

- (void)requestSuccessActionResponse:(id)responseObject dataClass:(Class)dataClass callBackBlock:(SWNetManagerCallBackBlock)callBack{
    NSLog(@"请求成功---------\n%@",responseObject);
    SWNetError *swError = [SWNetError mj_objectWithKeyValues:responseObject];
    id model = [self modelWithDataClass:dataClass error:swError];
    if (swError.code == SWNetErrorCodeSuccess) {
        if (callBack) {
            callBack(swError, model);
        }
    } else if (swError.code == SWNetErrorCodeTokenExpire) {
        [SWAlertManager showMessage:@"令牌失效, 请重新登录!" meaageColor:[UIColor blackColor] okButtonTitle:@"确定" okButtonBlock:^{
//            [UIApplication sharedApplication].keyWindow.rootViewController = [[ShareWorkNavViewController alloc] initWithRootViewController:[[ShareWorkerLoginViewController alloc] init]];
        }];
    } else {
        if (callBack) {
            callBack(swError, model);
        }
        [SVProgressHUD showErrorWithStatus:swError.msg];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
}

- (void)printUrl:(NSString *)url param:(NSDictionary *)param hasToken:(BOOL)hasToken{
    NSMutableString *mutableString = [NSMutableString string];
    [mutableString appendString:url];
    if (param.allKeys.count > 0) {
        [mutableString appendString:@"?"];
        [param enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [mutableString appendString:[NSString stringWithFormat:@"%@", key]];
            [mutableString appendString:@"="];
            [mutableString appendString:[NSString stringWithFormat:@"%@", obj]];
            [mutableString appendString:@"&"];
        }];
    }
    if ([mutableString hasSuffix:@"&"]) {
        [mutableString replaceCharactersInRange:NSMakeRange(mutableString.length - 1, 1) withString:@""];
    }
    NSLog(@"请求路劲---------\n%@", mutableString);
}

- (void)requestFail:(NSError *)error callBackBlock:(SWNetManagerCallBackBlock)callBack{
    SWNetError *swError = [[SWNetError alloc] init];
    swError.code = error.code;
    swError.msg = self.netErrorMsg;
    NSLog(@"请求失败---------\n%@",error.domain);
    [SVProgressHUD showErrorWithStatus:swError.msg];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
    if (callBack) {
        callBack(swError, nil);
    }
}

- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = 20;
    }
    return _manager;
}

@end
