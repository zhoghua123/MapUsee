//
//  ZHDefineAlertView.h
//  MapUse-01
//
//  Created by xyj on 2018/5/16.
//  Copyright © 2018年 xyj. All rights reserved.
//
/*
  自定义大头针视图子控件
 */

#import <UIKit/UIKit.h>
#import "ZHDefineDataModel.h"
@interface ZHDefineAlertView : UIView
+(instancetype)defineAlertView;
@property (nonatomic,strong) ZHDefineDataModel *defineDataModel;
@end
