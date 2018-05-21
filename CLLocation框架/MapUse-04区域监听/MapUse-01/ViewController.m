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
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate =self;
        //要想进行区域监听,必须进行定位授权
        //iOS8.0+ 前台/前后台定位
        [_locationManager requestWhenInUseAuthorization];
        [_locationManager requestAlwaysAuthorization];
    }
    return _locationManager ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 创建区域
    CLLocationCoordinate2D center =  CLLocationCoordinate2DMake(22.33, 122.44);
    CLLocationDistance distance = 1000;

    if (distance>self.locationManager.maximumRegionMonitoringDistance) {
        NSLog(@"监听区域超过了最大值");
        distance = self.locationManager.maximumRegionMonitoringDistance;
    }
    CLRegion *region = [[CLCircularRegion alloc] initWithCenter:center radius:distance identifier:@"eeee"];
    //class: 监听的区域时什么种类: 圆形(CLCircularRegion)/其他
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        //2. 监听区域
        [self.locationManager startMonitoringForRegion:region];
        //2.1 请求当前区域的状态(程序已启动,先查看当前位置是不是在对应区域内)
        [self.locationManager requestStateForRegion:region];
    }else{
        NSLog(@"不能监听区域");
    }
    
}

//进入区域时调用
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region{
    NSLog(@"进入了区域");
}
//离开区域时调用
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region{
    NSLog(@"离开了区域");
}
/*
 情况:
 因为上面的两个代理方法,只有在动作即区域改变的时候才会调用,但是在有些时候,程序加载之后,我就要展示当前位置是否在区域内,这就需要这个代理方法了
 该代理方法跟: [self.locationManager requestStateForRegion:region];结合使用
 */
-(void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
    switch (state) {
        case CLRegionStateUnknown:
            NSLog(@"不知道");
            break;
        case CLRegionStateInside:
            NSLog(@"在区域内");
            break;
        case CLRegionStateOutside:
            NSLog(@"在区域外");
            break;
        default:
            break;
    }
}
@end
