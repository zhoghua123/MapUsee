//
//  ZHAnnotation.h
//  MapUse-01
//
//  Created by xyj on 2018/5/15.
//  Copyright © 2018年 xyj. All rights reserved.
//

//系统自带大头针视图对应的大头针模型

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ZHAnnotation : NSObject<MKAnnotation>

/** 坐标位置 */
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@end
