//
//  ShareWorkUserProfile.m
//  ShareWork
//
//  Created by 周发明 on 2018/4/22.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkUserProfile.h"

@implementation ShareWorkUserProfile

+ (instancetype)shareProfile{
    static ShareWorkUserProfile *_ShareWorkUserProfileInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ShareWorkUserProfileInstance = [[ShareWorkUserProfile alloc] init];
    });
    return _ShareWorkUserProfileInstance;
}

- (instancetype)init{
    if (self = [super init]) {
        _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        _userPhone = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPhone"];
        _userType = [[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
        _userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        _userPic = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPic"];
        _userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
        _laborCompany = [[NSUserDefaults standardUserDefaults] objectForKey:@"laborCompany"];
    }
    return self;
}

- (BOOL)isLogin{
    if (_token == nil) {
        return NO;
    }
    if (_token.length == 0) {
        return NO;
    }
    return YES;
}

- (void)setToken:(NSString *)token{
    _token = token;
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
}

- (void)setUserName:(NSString *)userName{
    _userName = userName;
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
}

- (void)setUserType:(NSString *)userType{
    _userType = userType;
    [[NSUserDefaults standardUserDefaults] setObject:userType forKey:@"userType"];
}

- (void)setUserPhone:(NSString *)userPhone{
    _userPhone = userPhone;
    [[NSUserDefaults standardUserDefaults] setObject:userPhone forKey:@"userPhone"];
}

- (void)setUserPic:(NSString *)userPic{
    _userPic = userPic;
    [[NSUserDefaults standardUserDefaults] setObject:userPic forKey:@"userPic"];
}

-(void)setManageType:(NSString *)manageType{
    
    _manageType = manageType;
    [[NSUserDefaults standardUserDefaults] setObject:manageType forKey:@"manageType"];
}

-(void)setUserId:(NSString *)userId{
    
    _userId = userId;
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
}

-(void)setRealFlag:(NSString *)realFlag{
    
    _realFlag = realFlag;
    
    [[NSUserDefaults standardUserDefaults] setObject:realFlag forKey:@"realFlag"];
    
}

-(void)setWorkTypeId:(NSString *)workTypeId{
    _workTypeId = workTypeId;
    
    [[NSUserDefaults standardUserDefaults] setObject:workTypeId forKey:@"workTypeId"];
}

-(void)setWorkTypeName:(NSString *)workTypeName{
    _workTypeName= workTypeName;
    
    [[NSUserDefaults standardUserDefaults] setObject:workTypeName forKey:@"workTypeName"];
}
-(void)setSiteId:(NSString *)siteId{
    _siteId= siteId;
    
    [[NSUserDefaults standardUserDefaults] setObject:siteId forKey:@"siteId"];
    
}


//-(void)setSiteName:(NSString *)siteName{
//
//    _siteName= siteName;
//    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//
//    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:userId];
//
//    [dict setValue:siteName forKey:@"siteName"];
//    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:@"userId"];
//}

-(void)setTeamIdSiteName:(NSString *)teamIdSiteName{
    

    _teamIdSiteName= teamIdSiteName;
    NSString *xx = [teamIdSiteName componentsSeparatedByString:@"-"].firstObject;
    NSString *yy = [teamIdSiteName componentsSeparatedByString:@"-"].lastObject;
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSDictionary *teamIdDict = @{
                             @"teamId":xx,
                             @"siteName":yy,
                             };
    [[NSUserDefaults standardUserDefaults] setObject:teamIdDict forKey:userId];
    
}
-(void)setLaborCompany:(NSString *)laborCompany{
    
    _laborCompany = laborCompany;
    
    [[NSUserDefaults standardUserDefaults] setObject:laborCompany forKey:@"laborCompany"];
}

-(void)setUserIdCard:(NSString *)userIdCard{
    _userIdCard = userIdCard;
    [[NSUserDefaults standardUserDefaults] setObject:userIdCard forKey:@"userIdCard"];
}

- (void)clearProfile{
    self.token = @"";
    self.userPic = @"";
    self.userName = @"";
    self.userType = @"";
    self.userPhone = @"";
    self.siteId = @"";
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPic"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userPhone"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userType"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"token"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"siteId"];
    NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];

    NSDictionary *dics = [defatluts dictionaryRepresentation];
    for(NSString *key in [dics allKeys]){
        [defatluts removeObjectForKey:key];
        [defatluts synchronize];
    }
    
}

- (NSString *)getTeamId{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSDictionary *dict =  [[NSUserDefaults standardUserDefaults] objectForKey:userId];
    NSString *teamId = [dict objectForKey:@"teamId"];
    
    return teamId;

}

- (NSString *)getUserSiteName{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    NSDictionary *dict =  [[NSUserDefaults standardUserDefaults] objectForKey:userId];
    NSString *getUserSite = [dict objectForKey:@"siteName"];
    
    return getUserSite;
    
}
@end
