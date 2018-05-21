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
#import "ZHAnnotation.h"
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求定位iOS8.0+
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    //设置地图的类型
    self.mapView.mapType = MKMapTypeStandard;
    

    //1. 跟踪用户位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    //2. 设置地图代理
    self.mapView.delegate = self;
    
    // 3. 监听mapView的点击事件
    [self.mapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMapView:)]];
}


/**
 *  监听mapView的点击
 */
- (void)tapMapView:(UITapGestureRecognizer *)tap
{
    // 1.获得用户在mapView点击的位置（x，y）
    CGPoint point = [tap locationInView:tap.view];
    
    // 2.将数学坐标 转为 地理经纬度坐标
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
    
    // 3.创建大头针模型，添加大头针到地图上
    //创建大头针
    ZHAnnotation *anno = [[ZHAnnotation alloc] init];
    anno.title = @"自定义主标题";
    anno.subtitle = @"自定义子标题";
    anno.coordinate = coordinate;
    [self.mapView addAnnotation:anno];
    
    //随机大量添加
    //中国的经纬度范围
    // 纬度范围：N 3°51′ ~  N 53°33′
    // 经度范围：E 73°33′ ~  E 135°05′
    
    //    for (int i = 0; i<1000; i++) {
    //        ZHAnnotation *anno = [[ZHAnnotation alloc] init];
    //        CLLocationDegrees latitude = 4 + arc4random_uniform(50);
    //        CLLocationDegrees longitude = 73 + arc4random_uniform(60);
    //        anno.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    //        anno.title = @"自定义主标题";
    //        anno.subtitle = @"自定义子标题";
    //        [self.mapView addAnnotation:anno];
    //    }
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
