//
//  ShareWorkSelectLocationController.h
//  ShareWork
//
//  Created by 周发明 on 2018/5/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkBaseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface ShareWorkSelectLocationController : ShareWorkBaseViewController
@property(nonatomic, copy)void(^selectLocationBlock)(CLLocationCoordinate2D location, NSString *locationName, NSString *locationCityId);
@end
