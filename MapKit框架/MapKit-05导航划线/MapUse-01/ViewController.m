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
@property (nonatomic, strong) CLGeocoder *geocoder;
@end

@implementation ViewController
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager ;
}

- (CLGeocoder *)geocoder
{
    if (!_geocoder) {
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //请求定位iOS8.0+
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];

    //设置地图代理
    self.mapView.delegate = self;
    
    NSString *address1 = @"北京";
    NSString *address2 = @"广州";
    //地理编码出2个位置
    [self.geocoder geocodeAddressString:address1 completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) return;
        
        CLPlacemark *fromPm = [placemarks firstObject];
        
        [self.geocoder geocodeAddressString:address2 completionHandler:^(NSArray *placemarks, NSError *error) {
            if (error) return;
            
            CLPlacemark *toPm = [placemarks firstObject];
            
            [self addLineFrom:fromPm to:toPm];
        }];
    }];
}

/**
 *  添加导航的线路
 *
 *  @param fromPm 起始位置
 *  @param toPm   结束位置
 */
- (void)addLineFrom:(CLPlacemark *)fromPm to:(CLPlacemark *)toPm{
    
    // 1.根据编码的位置添加2个大头针
    ZHAnnotation *fromAnno = [[ZHAnnotation alloc] init];
    fromAnno.coordinate = fromPm.location.coordinate;
    fromAnno.title = fromPm.name;
    [self.mapView addAnnotation:fromAnno];
    
    ZHAnnotation *toAnno = [[ZHAnnotation alloc] init];
    toAnno.coordinate = toPm.location.coordinate;
    toAnno.title = toPm.name;
    [self.mapView addAnnotation:toAnno];
    
    
    /*******核心代码*********/
    // 2.查找路线
    
    // 方向请求
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    // 设置起点
    MKPlacemark *sourcePm = [[MKPlacemark alloc] initWithPlacemark:fromPm];
    request.source = [[MKMapItem alloc] initWithPlacemark:sourcePm];
    
    // 设置终点
    MKPlacemark *destinationPm = [[MKPlacemark alloc] initWithPlacemark:toPm];
    request.destination = [[MKMapItem alloc] initWithPlacemark:destinationPm];
    
    // 方向对象
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    // 计算路线
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        NSLog(@"总共=====%d条路线", response.routes.count);
        
        // 遍历所有的路线
        for (MKRoute *route in response.routes) {
            // 添加路线遮盖(就回调用下面的代理方法)
            /*
             注意：这里不像添加大头针那样，只要我们添加了大头针模型，默认就会在地图上添加系统的大头针视图
             添加覆盖层，需要我们实现对应的代理方法，在代理方法中返回对应的覆盖层
             */
            [self.mapView addOverlay:route.polyline];
        }
    }];
}

#pragma mark - MKMapViewDelegate
/*
 Overlay: 遮盖的意思
 跟这个方法很相似(根据模型返回大头针视图)
 - (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
 那么这个方法就是根据overlay模型来返回遮盖
 MKPolyline系统自带的overlay模型
 */
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    renderer.strokeColor = [UIColor redColor];
    return renderer;
}
@end
