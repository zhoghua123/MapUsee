//
//  ViewController.m
//  MapUse-01
//
//  Created by xyj on 2018/5/11.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<CLLocationManagerDelegate>
@property (nonatomic,strong) CLLocationManager *localManager;
@end

@implementation ViewController
-(CLLocationManager *)localManager{
    if (_localManager == nil) {
        //1. 创建定位服务管理者
        _localManager = [[CLLocationManager alloc] init];;
        _localManager.delegate = self;
        //每隔多少米定位一次
        _localManager.distanceFilter = 100;
        //定位精度
        _localManager.desiredAccuracy = kCLLocationAccuracyBest;
        //iOS8.0+ 前台/前后台定位
        [_localManager requestWhenInUseAuthorization];
        [_localManager requestAlwaysAuthorization];
        /*
         常用常量:
 kCLLocationAccuracyBestForNavigation
         //最适合导航
 kCLLocationAccuracyBest
         //最好的
 kCLLocationAccuracyNearestTenMeters
         //10m
 kCLLocationAccuracyHundredMeters
         //100m
 kCLLocationAccuracyKilometer
         //1000m
 kCLLocationAccuracyThreeKilometers
         //3000m

         */
    }
    return _localManager ;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //开始定位用户位置
    [self.localManager startUpdatingLocation];
//    if (@available(iOS 9.0, *)) {
//        [self.localManager requestLocation];
//    } else {
//        // Fallback on earlier versions
//    }
}
/*
 只要定位的用户位置就会调用(调用频率特别高)
 locations: 数组里面是CLLocation对象
 
 */
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"--------%@",locations);
    //1. 获取位置对象
    CLLocation *location = locations.lastObject;
    //2. 取出经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度为:%f--经度为:-%f",coordinate.latitude,coordinate.longitude);
    /*
     struct CLLocationCoordinate2D {
     CLLocationDegrees latitude;//纬度
     CLLocationDegrees longitude;//经度
     };
     */
    
//    // 停止定位(省电措施：只要不想用定位服务，就马上停止定位服务)
//    [manager stopUpdatingLocation];
}
//检查用户授权的状态
/*
 CLAuthorizationStatus枚举如下:
 kCLAuthorizationStatusNotDetermined 用户还未决定
 
 kCLAuthorizationStatusRestricted 访问受限
 
 kCLAuthorizationStatusDenied 用户拒绝
 
 kCLAuthorizationStatusAuthorizedAlways 获得了前后台定位授权
 
 kCLAuthorizationStatusAuthorizedWhenInUse 获得了前台定位授权

 */
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
}
//定位失败时调用
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}
@end
