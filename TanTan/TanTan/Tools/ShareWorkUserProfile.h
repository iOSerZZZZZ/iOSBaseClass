//
//  ShareWorkUserProfile.h
//  ShareWork
//
//  Created by 周发明 on 2018/4/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareWorkUserProfile : NSObject

/**
 是否是企业
 YES  企业
 NO   工人
 */
@property(nonatomic, assign)BOOL  isEnterprise;

/**
 是否已登录
 */
@property(nonatomic, assign, readonly)BOOL  isLogin;

@property (nonatomic, copy) NSString *token;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userPhone;
@property (nonatomic, copy) NSString *userPic;


/**
 实名认证
 */
@property (nonatomic, copy) NSString *realRecoganise;

/**
 1--个人 2--企业
 */
@property (nonatomic, copy) NSString *userType;

/**
 1--个人 2--班组长
 */
@property (nonatomic, copy) NSString *manageType;

@property (nonatomic, copy) NSString *realFlag;

@property (nonatomic, copy) NSString *userId;

@property (nonatomic, copy) NSString *workTypeId;

@property (nonatomic, copy) NSString *workTypeName;

@property (nonatomic, copy) NSString *siteId;



@property (nonatomic, copy) NSString *teamIdSiteName;

@property (nonatomic, copy) NSString *laborCompany;

@property (nonatomic, copy) NSString *userIdCard;
+ (instancetype)shareProfile;

- (void)clearProfile;

- (NSString *)getTeamId;
- (NSString *)getUserSiteName;
@end
