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
    
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    //设置地图代理
    self.mapView.delegate = self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //创建大头针
    //餐厅模型
    ZHAnnotation *anno = [[ZHAnnotation alloc] init];
    anno.title = @"饭店";
    anno.subtitle = @"饭店子标题";
    //给该模型添加一个icon属性!!!!
    anno.icon = @"category_1";
    anno.coordinate = CLLocationCoordinate2DMake(39, 115);
    [self.mapView addAnnotation:anno];
    
    //电影
    ZHAnnotation *anno2 = [[ZHAnnotation alloc] init];
    anno2.title = @"影院";
    anno2.subtitle = @"影院子标题";
    anno2.icon = @"category_5";
    anno2.coordinate = CLLocationCoordinate2DMake(39, 116);
    [self.mapView addAnnotation:anno2];
}
#pragma  mark -MKMapViewDelegate

/*
 该方法中大头针也是循环利用的
 
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    //用户位置这个大头针不是ZHAnnotation 而是(MKUserLocation *)userLocation
    if (![annotation isKindOfClass:[ZHAnnotation class]]) return nil;

    static NSString *ID = @"tuangou";
    // 从缓存池中取出可以循环利用的大头针view
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (annoView == nil) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        //点击大头针,显示标题和子标题
        annoView.canShowCallout = YES;
        //设置大头针的偏移量
        annoView.calloutOffset = CGPointMake(0, -10);
        //设置大头针描述右边的内容
        annoView.rightCalloutAccessoryView = [UISwitch new];
        //设置大头针描述左边的内容
        annoView.leftCalloutAccessoryView = [UISwitch new];
    }

    // 传递模型
    annoView.annotation = annotation;
    //设置图片
    ZHAnnotation *anno = annotation;
    annoView.image = [UIImage imageNamed:anno.icon];

    return annoView;
}

// MKPinAnnotationView的使用
//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    if (![annotation isKindOfClass:[ZHAnnotation class]]) return nil;
//
//    static NSString *ID = @"tuangou";
//    // 从缓存池中取出可以循环利用的大头针view
//    MKPinAnnotationView *annoView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
//    if (annoView == nil) {
//        annoView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
//        annoView.canShowCallout = YES;
//        // 设置从天而降的动画
//        annoView.animatesDrop = YES;
//    }
//
//    // 传递模型
//    annoView.annotation = annotation;
//
//    return annoView;
//}
@end
