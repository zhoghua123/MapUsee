//
//  ZHAnnotation.h
//  MapUse-01
//
//  Created by xyj on 2018/5/15.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface ZHAnnotation : NSObject<MKAnnotation>

/** 坐标位置 */
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 子标题 */
@property (nonatomic, copy) NSString *subtitle;
//图片数据
@property (nonatomic,strong) NSString *icon;
@end
