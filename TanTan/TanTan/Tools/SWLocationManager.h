//
//  SWLocationManager.h
//  ShareWork
//
//  Created by 周发明 on 2018/5/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWLocationManager : NSObject
@property(nonatomic, copy)NSString *latitude; // 纬度
@property(nonatomic, copy)NSString *longitude;// 经度
@property(nonatomic, copy)NSString *coordinate;// 经纬度
@property(nonatomic, copy)NSString *currentCity;// 当前城市
@property(nonatomic, assign)BOOL enable;// 是否授权可以获取位置
+ (instancetype)manager;
- (void)startLocationService;
@end
