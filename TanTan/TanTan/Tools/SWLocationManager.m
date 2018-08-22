//
//  SWLocationManager.m
//  ShareWork
//
//  Created by 周发明 on 2018/5/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SWLocationManager.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

@interface SWLocationManager()<BMKLocationServiceDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong)   BMKLocationService *locService;
@property(nonatomic, strong)CLLocationManager *systemLocationManager;
@end

@implementation SWLocationManager

- (BMKLocationService *)locService
{
    if (!_locService)
    {
        _locService = [[BMKLocationService alloc] init];
        _locService.desiredAccuracy = kCLLocationAccuracyBest;
        _locService.delegate = self;
        
    }
    return _locService;
}

- (CLLocationManager *)systemLocationManager{
    if (_systemLocationManager == nil) {
        _systemLocationManager = [[CLLocationManager alloc] init];
        _systemLocationManager.delegate = self;
    }
    return _systemLocationManager;
}

- (NSString *)coordinate{
    if (_coordinate == nil) {
        _coordinate = @"";
    }
    return _coordinate;
}

+ (instancetype)manager{
    static SWLocationManager *_SWLocationManagerInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _SWLocationManagerInstance = [[SWLocationManager alloc] init];
    });
    return _SWLocationManagerInstance;
}

- (void)startLocationService{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if(status == kCLAuthorizationStatusAuthorizedAlways||status==kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locService startUserLocationService];
        self.enable = YES;
    } else {
        [self.systemLocationManager requestWhenInUseAuthorization];
    }
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    self.latitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.latitude];
    self.longitude = [NSString stringWithFormat:@"%f", userLocation.location.coordinate.longitude];
    self.coordinate = [NSString stringWithFormat:@"%f,%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation: userLocation.location completionHandler:^(NSArray *array, NSError *error) {
        if (array.count > 0) {
            [self.locService stopUserLocationService];
            CLPlacemark *placemark = [array objectAtIndex:0];
            if (placemark != nil) {
                NSString *city = placemark.locality;
                self.currentCity = [NSString stringWithFormat:@"%@",placemark.locality];
                NSLog(@"当前城市名称------%@",city);
            }
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status == kCLAuthorizationStatusAuthorizedAlways||status==kCLAuthorizationStatusAuthorizedWhenInUse){
        [self.locService startUserLocationService];
        self.enable = YES;
    }
}

@end
