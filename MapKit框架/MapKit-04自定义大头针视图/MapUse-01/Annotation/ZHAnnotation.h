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
#import "ZHDefineDataModel.h"
@interface ZHAnnotation : NSObject<MKAnnotation>

/** 坐标位置 */
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
//数据模型
@property (nonatomic,strong) ZHDefineDataModel *defineModel;

//记录是否已经显示了(如果显示了就不在显示了)
@property (nonatomic, assign, getter = isShowDesc) BOOL showDesc;
@end
