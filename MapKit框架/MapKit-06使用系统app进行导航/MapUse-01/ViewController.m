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
@property (weak, nonatomic) IBOutlet UIImageView *snapshootImageView;
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
    
    
}
//开始使用自带app进行导航
- (IBAction)startNav:(id)sender {
    NSString *address1 = @"北京";
    //地理编码出目的位置
    [self.geocoder geocodeAddressString:address1 completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) return;
        
        CLPlacemark *toPm = [placemarks firstObject];
        
        [self beginNavEndPlacemark:toPm];
    }];
}
//3D视图
- (IBAction)DView:(id)sender {
    // 创建视角中心坐标
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(23.132931, 113.375924);
    // 创建3D视角
    MKMapCamera *camera = [MKMapCamera cameraLookingAtCenterCoordinate:center fromEyeCoordinate:CLLocationCoordinate2DMake(center.latitude + 0.001, center.longitude + 0.001) eyeAltitude:1];
    // 设置到地图上显示
    self.mapView.camera = camera;

}
//截屏
- (IBAction)snipPic:(id)sender {
    // 截图附加选项
    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
    // 设置截图区域(在地图上的区域,作用在地图)
    options.region = self.mapView.region;
    //    options.mapRect = self.mapView.visibleMapRect;
    
    // 设置截图后的图片大小(作用在输出图像)
    options.size = self.mapView.frame.size;
    // 设置截图后的图片比例（默认是屏幕比例， 作用在输出图像）
    options.scale = [[UIScreen mainScreen] scale];
    
    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
    [snapshotter startWithCompletionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
        if (error) {
            NSLog(@"截图错误：%@",error.localizedDescription);
        }else
        {
            // 设置屏幕上图片显示
            self.snapshootImageView.image = snapshot.image;
            // 将图片保存到指定路径（此处是桌面路径，需要根据个人电脑不同进行修改）
            NSData *data = UIImagePNGRepresentation(snapshot.image);
            [data writeToFile:@"/Users/wangshunzi/Desktop/snap.png" atomically:YES];
        }
    }];

}
/*
 POI检索: 即搜索附近的小吃等
 */
- (IBAction)POIsearch:(id)sender {
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = @"小吃";
    request.region = self.mapView.region;
    MKLocalSearch *search=  [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse * _Nullable response, NSError * _Nullable error) {
        NSArray *items = response.mapItems;
        for (MKMapItem *item in items) {
            NSLog(@"%@===%@",item.name,item.url);
        }
    }];
}

// 根据两个地标对象进行调用系统导航
- (void)beginNavEndPlacemark:(CLPlacemark *)endPlacemark
{
    // 创建起点:当前位置为起点
     MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    
    // 创建终点:根据 CLPlacemark 地标对象创建 MKPlacemark 地标对象
    MKPlacemark *itemP2 = [[MKPlacemark alloc] initWithPlacemark:endPlacemark];
    MKMapItem *item2 = [[MKMapItem alloc] initWithPlacemark:itemP2];
    
    NSDictionary *launchDic = @{
                                // 设置导航模式参数
                                MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                                // 设置地图类型
                                MKLaunchOptionsMapTypeKey : @(MKMapTypeHybridFlyover),
                                // 设置是否显示交通
                                MKLaunchOptionsShowsTrafficKey : @(YES),
                                
                                };
    //核心代码!!!!!!!!
    // 根据 MKMapItem 数组 和 启动参数字典 来调用系统地图进行导航
    [MKMapItem openMapsWithItems:@[currentLocation, item2] launchOptions:launchDic];
}

@end
