//
//  ZHDefineDataModel.h
//  MapUse-01
//
//  Created by xyj on 2018/5/16.
//  Copyright © 2018年 xyj. All rights reserved.
//
/*
 自定义大头针视图对应的数据模型
 */

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface ZHDefineDataModel : NSObject
/**
 *  标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  图标
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  配图
 */
@property (nonatomic, copy) NSString *image;
/**
 *  团购的位置
 */
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@end
