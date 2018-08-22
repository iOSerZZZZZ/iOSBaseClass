//
//  ShareWorkSelectLocationController.m
//  ShareWork
//
//  Created by 周发明 on 2018/5/9.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "ShareWorkSelectLocationController.h"
#import "JZLocationConverter.h"


@interface ShareWorkSelectLocationController ()<BMKLocationServiceDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate>
@property (nonatomic, strong)   BMKLocationService *locService;
@property (nonatomic, strong)   BMKGeoCodeSearch *geocodesearch;
@property (nonatomic, strong)   BMKMapView *mapView;


@property(nonatomic, assign) CLLocationCoordinate2D location;
@property(nonatomic, copy)NSString *locationName;
@property(nonatomic, copy)NSString *cityId;
@end

@implementation ShareWorkSelectLocationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatSubvies];
    
}




- (void)creatSubvies{
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(sureClick)];
    self.navigationItem.rightBarButtonItem = right;
    
    BMKMapView *mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, self.topNavHeight, KScreenWidth, KScreenHeight - self.topNavHeight)];
    mapView.zoomEnabled = YES;
    
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;//显示定位图层
    mapView.userTrackingMode = BMKUserTrackingModeNone;
    mapView.zoomLevel = 17;
    [self.view addSubview:mapView];
    self.mapView = mapView;
    [self.locService startUserLocationService];//启动定位服务
}

- (void)sureClick{
    if (self.selectLocationBlock) {
        self.selectLocationBlock(self.location, self.locationName, self.cityId);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setLocation:(CLLocationCoordinate2D)location{
    location = [JZLocationConverter bd09ToWgs84:location];
    _location = location;
//    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
//    CLLocation *geoLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
//    [geocoder reverseGeocodeLocation:geoLocation completionHandler:^(NSArray *array, NSError *error) {
//        if (array.count > 0) {
//            CLPlacemark *placemark = [array objectAtIndex:0];
//            /*
//             @property (nonatomic, readonly, copy, nullable) NSString *name; // eg. Apple Inc.
//             @property (nonatomic, readonly, copy, nullable) NSString *thoroughfare; // street name, eg. Infinite Loop
//             @property (nonatomic, readonly, copy, nullable) NSString *subThoroughfare; // eg. 1
//             @property (nonatomic, readonly, copy, nullable) NSString *locality; // city, eg. Cupertino
//             @property (nonatomic, readonly, copy, nullable) NSString *subLocality; // neighborhood, common name, eg. Mission District
//             @property (nonatomic, readonly, copy, nullable) NSString *administrativeArea; // state, eg. CA
//             @property (nonatomic, readonly, copy, nullable) NSString *subAdministrativeArea; // county, eg. Santa Clara
//             @property (nonatomic, readonly, copy, nullable) NSString *postalCode; // zip code, eg. 95014
//             @property (nonatomic, readonly, copy, nullable) NSString *ISOcountryCode; // eg. US
//             @property (nonatomic, readonly, copy, nullable) NSString *country; // eg. United States
//             @property (nonatomic, readonly, copy, nullable) NSString *inlandWater; // eg. Lake Tahoe
//             @property (nonatomic, readonly, copy, nullable) NSString *ocean; // eg. Pacific Ocean
//             @property (nonatomic, readonly, copy, nullable) NSArray<NSString *> *areasOfInterest; // eg. Golden Gate Park
//             */
//            if (placemark != nil) {
//                self.locationName = [NSString stringWithFormat:@"%@%@%@", placemark.locality, placemark.subLocality, placemark.name];
//            }
//        }
//    }];
}


//- (BOOL)reverseGeoCode:(BMKReverseGeoCodeOption*)reverseGeoCodeOption{
//    return YES;
//}
//
//-(void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
//{
//    BMKAddressComponent *component=[[BMKAddressComponent alloc]init];
//    component=result.addressDetail;
//    //这个就是我们要传给服务器的城市 ID    component.adCode;
//    self.cityId = component.adCode;
//    self.locationName = [NSString stringWithFormat:@"%@", result.address];
//}


#pragma mark -- MapView Delegate
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //添加当前位置的标注
    CLLocationCoordinate2D coord;
    coord.latitude = userLocation.location.coordinate.latitude;
    coord.longitude = userLocation.location.coordinate.longitude;
    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
    _pointAnnotation.coordinate = coord;

    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt = (CLLocationCoordinate2D){coord.latitude,coord.longitude};
    self.location = pt;
    
    
//    BMKReverseGeoCodeOption *reverseOption=[[BMKReverseGeoCodeOption alloc]init];
//    //2.给反向地理编码选项对象的坐标点赋值
//    reverseOption.reverseGeoPoint= userLocation.location.coordinate;
//    //3.执行反地理编码
//    [self.geocodesearch reverseGeoCode:reverseOption];
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self->_mapView removeOverlays:self->_mapView.overlays];
//        [self->_mapView setCenterCoordinate:coord animated:true];
//        [self->_mapView addAnnotation:_pointAnnotation];
//        [self->_locService stopUserLocationService];
//    });
}


- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLLocationCoordinate2D coor = [self.mapView convertPoint:self.view.center toCoordinateFromView:mapView];
    
    BMKPointAnnotation *_pointAnnotation = [[BMKPointAnnotation alloc] init];
    _pointAnnotation.coordinate = coor;
    
//    BMKReverseGeoCodeOption *reverseOption=[[BMKReverseGeoCodeOption alloc]init];
//    //2.给反向地理编码选项对象的坐标点赋值
//    reverseOption.reverseGeoPoint= coor;
//    //3.执行反地理编码
//    [self.geocodesearch reverseGeoCode:reverseOption];
    
    CLLocationCoordinate2D pt=(CLLocationCoordinate2D){0,0};
    pt = (CLLocationCoordinate2D){coor.latitude,coor.longitude};
    self.location = pt;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mapView removeAnnotations:self.mapView.annotations];
        [self.mapView addAnnotation:_pointAnnotation];
    });
}

#pragma mark=======地图
//地图定位
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

- (BMKGeoCodeSearch *)geocodesearch{
    if (!_geocodesearch) {
            _geocodesearch = [[BMKGeoCodeSearch alloc] init];
         _geocodesearch.delegate = self;
    }
    return _geocodesearch;
   
}


@end
