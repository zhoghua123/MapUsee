//
//  ViewController.m
//  MapUse-01
//
//  Created by xyj on 2018/5/11.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController ()
@property (nonatomic,strong) CLGeocoder *geocoder;
#pragma mark - 地理编码

@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddressLabel;

#pragma mark - 反地理编码
@property (weak, nonatomic) IBOutlet UITextField *longtitudeField;
@property (weak, nonatomic) IBOutlet UITextField *latitudeField;
@property (weak, nonatomic) IBOutlet UILabel *reverseDetailAddressLabel;

@end

@implementation ViewController
-(CLGeocoder *)geocoder{
    if (_geocoder == nil) {
        _geocoder = [[CLGeocoder alloc] init];
    }
    return _geocoder ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
//地理编码
- (IBAction)geocode:(id)sender {
    if (!self.addressField.text.length) {
        return;
    }
    [self.geocoder geocodeAddressString:self.addressField.text completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {//有错误
            NSLog(@"");
            self.detailAddressLabel.text = @"您查找的地址不存在!";
        }else{
            CLPlacemark *placemark = placemarks.firstObject;
            self.longitudeLabel.text = [NSString stringWithFormat:@"%f",placemark.location.coordinate.longitude];
            self.latitudeLabel.text = [NSString stringWithFormat:@"%f",placemark.location.coordinate.latitude];
            self.detailAddressLabel.text = [NSString stringWithFormat:@"%@-%@-%@",placemark.country,placemark.administrativeArea,placemark.locality];
            NSLog(@"%@",placemark.addressDictionary);
        }
    }];
}

//反地理编码
- (IBAction)reverseGeocode:(id)sender {
    // 1.包装位置
    CLLocationDegrees latitude = [self.latitudeField.text doubleValue];
    CLLocationDegrees longitude = [self.longtitudeField.text doubleValue];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    [self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {//有错误
            NSLog(@"");
            self.reverseDetailAddressLabel.text = @"您查找的地址不存在!";
        }else{
            CLPlacemark *placemark = placemarks.firstObject;
            self.reverseDetailAddressLabel.text = [NSString stringWithFormat:@"%@-%@-%@",placemark.country,placemark.administrativeArea,placemark.locality];
            NSLog(@"%@",placemark.addressDictionary);
        }
    }];
}

@end
