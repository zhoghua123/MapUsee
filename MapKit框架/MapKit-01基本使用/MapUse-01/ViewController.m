//
//  ViewController.m
//  MapUse-01
//
//  Created by xyj on 2018/5/11.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager ;
}
/*
 MKMapTypeStandard = 0, 普通地图
 MKMapTypeSatellite,    卫星云图
 MKMapTypeHybrid,       混合模式（普通地图覆盖于卫星云图之上 ）
 MKMapTypeSatelliteFlyover  3D立体卫星 （iOS9.0）
 MKMapTypeHybridFlyover NS_ENUM_AVAILABLE(10_11, 9_0),
 MKMapTypeMutedStandard NS_ENUM_AVAILABLE(10_13, 11_0)
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求定位iOS8.0+
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    //设置地图的类型
    self.mapView.mapType = MKMapTypeStandard;
    
    // 显示用户的位置
    //方式一: 只显示不会追踪
//    self.mapView.showsUserLocation = YES;
    //方式二: 跟踪用户位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //设置地图代理
    self.mapView.delegate = self;
}

#pragma  mark -MKMapViewDelegate
/*
 当用户的位置更新，就会调用（不断地监控用户的位置，调用频率特别高）
 userLocation 表示地图上蓝色那颗大头针的数据
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    //1.给userLocation设置数据
    userLocation.title = @"我是主标题";
    userLocation.subtitle = @"我是子标题";
    //2. 设置显示地图的中心点(将当前用户的位置设置为地图的中心点)
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    //3. 设置地图的展示范围
    //我们如何拿到这个范围呢: 1. 实现下面的代理方法. 2. 拖动地图放大,一直放到认为合适的位置 3	. 在下面代理方法中,拿到相应的span
     MKCoordinateSpan span = MKCoordinateSpanMake(0.021321, 0.019366);
     MKCoordinateRegion region = MKCoordinateRegionMake(userLocation.location.coordinate, span);
    [mapView setRegion:region animated:YES];
}
/*
 用户缩放时,就会调用,该方法可用于调试出适合的跨度,然后用到setRegion方法中
 */
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
        NSLog(@"%f %f", mapView.region.span.latitudeDelta, mapView.region.span.longitudeDelta);
}
@end
