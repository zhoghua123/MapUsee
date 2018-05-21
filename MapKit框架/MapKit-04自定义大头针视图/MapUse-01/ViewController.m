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
#import "ZHDefineAlertAnnotation.h"
#import "ZHDefineAlertAnnotationView.h"
#import "ZHDefineDataModel.h"
@interface ViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong) CLLocationManager *locationManager;
//自定义大头针视图的模型数组
@property (nonatomic,strong) NSArray *defineDatas;
@end

@implementation ViewController
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
    }
    return _locationManager ;
}

-(NSArray *)defineDatas{
    if (_defineDatas == nil) {
        ZHDefineDataModel *tg1 = [[ZHDefineDataModel alloc] init];
        tg1.title = @"xxx大饭店";
        tg1.desc = @"全场一律15折，会员20折";
        tg1.icon = @"category_1";
        tg1.image = @"me";
        tg1.coordinate = CLLocationCoordinate2DMake(39, 116);
        
        ZHDefineDataModel *tg2 = [[ZHDefineDataModel alloc] init];
        tg2.title = @"xxx影院";
        tg2.desc = @"最新大片：美国队长2，即将上映。。。";
        tg2.icon = @"category_5";
        tg2.image = @"other";
        tg2.coordinate = CLLocationCoordinate2DMake(29, 110);
        
        _defineDatas = @[tg1,tg2];
    }
    return _defineDatas ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //请求定位iOS8.0+
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    //设置地图代理
    self.mapView.delegate = self;
}
//添加大头针
- (IBAction)addAnno:(id)sender {
    
    //根据数据模型添加对应的系统视图对应的大头针模型
    for (ZHDefineDataModel *dataModel in self.defineDatas) {
        ZHAnnotation *anno = [[ZHAnnotation alloc] init];
        anno.defineModel = dataModel;
        [self.mapView addAnnotation:anno];
    }
}

#pragma  mark -MKMapViewDelegate

/*
 该方法中大头针也是循环利用的
 调用时刻: 根据大头针模型,展示大头针视图
 */
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    //系统自带的大头针视图
    if ([annotation isKindOfClass:[ZHAnnotation class]]){
        
        static NSString *ID = @"tuangou";
        // 从缓存池中取出可以循环利用的大头针view
        MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (annoView == nil) {
            annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        }
        // 传递模型
        annoView.annotation = annotation;
        //设置图片
        ZHAnnotation *anno = annotation;
        annoView.image = [UIImage imageNamed:anno.defineModel.icon];
        return annoView;
    }else if ([annotation isKindOfClass:[ZHDefineAlertAnnotation class]]){
        //自定义的大头针视图
        static NSString *ID = @"defAnno";
        ZHDefineAlertAnnotationView *defAnnoView = (ZHDefineAlertAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (defAnnoView == nil) {
            defAnnoView = [[ZHDefineAlertAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:ID];
        }
        // 传递模型
        defAnnoView.annotation = annotation;
        return defAnnoView;
    }else{//使用户位置大头针
        return nil;
    }
}
/*
 选中一个大头针
 */
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    if ([view isKindOfClass:[ZHDefineAlertAnnotationView class]]) { //点击自定义的大头针视图
#warning 跳转控制器代码
        ZHDefineAlertAnnotation *anno = view.annotation;
        NSLog(@"跳转控制器---%@", anno.defineModel.title);
    }else{ //点击系统自带的大头针视图
        //1.拿到系统自带大头针的模型
        ZHAnnotation *anno = view.annotation;
        if (anno.isShowDesc) return;
        
        // 2.删除以前的ZHDefineAlertAnnotation
        for (id annotation in mapView.annotations) {
            if ([annotation isKindOfClass:[ZHDefineAlertAnnotation class]]) {
                [mapView removeAnnotation:annotation];
            } else if ([annotation isKindOfClass:[ZHAnnotation class]]) {
                ZHAnnotation *annof1 = annotation;
                annof1.showDesc = NO;
            }
        }
        anno.showDesc = YES;
        // 3.添加新的ZHDefineAlertAnnotation 大头针视图
        // 在这颗被点击的大头针上面, 添加一颗用于描述的大头针视图
        ZHDefineAlertAnnotation *deAnno = [[ZHDefineAlertAnnotation alloc] init];
        deAnno.defineModel = anno.defineModel;
        [mapView addAnnotation:deAnno];
    }
}

@end
