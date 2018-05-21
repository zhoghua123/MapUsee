//
//  ZHDefineAlertAnnotation.m
//  MapUse-01
//
//  Created by xyj on 2018/5/16.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ZHDefineAlertAnnotation.h"

@implementation ZHDefineAlertAnnotation
-(void)setDefineModel:(ZHDefineDataModel *)defineModel{
    _defineModel = defineModel;
    _coordinate = defineModel.coordinate;
}
@end
