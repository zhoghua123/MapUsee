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
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (nonatomic,strong) CLLocationManager *locationManager;
@end

@implementation ViewController
-(CLLocationManager *)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate =self;
    }
    return _locationManager ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //1. 创建位置管理者
    if (CLLocationManager.headingAvailable) {
        [self.locationManager startUpdatingHeading];
    }else{
        NSLog(@"当前磁力计设备不支持!!!");
    }
}
- (void)locationManager:(CLLocationManager *)manager
       didUpdateHeading:(CLHeading *)newHeading{
    NSLog(@"---------");
    //1. 拿到当前设备朝向
    //真正的北方: trueHeading
    //磁北方向
   CLLocationDirection angle = newHeading.magneticHeading;
    //2. 让图片反向旋转
    //把角度转换为弧度
    CGFloat hudu = angle/180 * M_PI;
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.transform = CGAffineTransformMakeRotation(-hudu);
    }];
}

@end
