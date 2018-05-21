//
//  ZHDefineAlertAnnotation.h
//  MapUse-01
//
//  Created by xyj on 2018/5/16.
//  Copyright © 2018年 xyj. All rights reserved.
//

// 自定义大头针视图对应的大头针模型

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "ZHDefineDataModel.h"
@interface ZHDefineAlertAnnotation : NSObject<MKAnnotation>
/** 坐标位置 */
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

//数据模型
@property (nonatomic,strong) ZHDefineDataModel *defineModel;

@end
