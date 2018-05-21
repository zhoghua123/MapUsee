//
//  ZHDefineAlertAnnotationView.m
//  MapUse-01
//
//  Created by xyj on 2018/5/16.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ZHDefineAlertAnnotationView.h"
#import "ZHDefineAlertView.h"
#import "UIView+MJ.h"
#import "ZHDefineAlertAnnotation.h"


@interface ZHDefineAlertAnnotationView ()
@property (nonatomic,strong) ZHDefineAlertView *defineAlertView;
@end

@implementation ZHDefineAlertAnnotationView

-(instancetype)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
//初始化子控件
-(void)setup{
    
    //设置自己子控件的frame
    ZHDefineAlertView *defineAlertView = [ZHDefineAlertView defineAlertView];
    defineAlertView.frame = CGRectMake(-55, -100, 120, 50);
    [self addSubview:defineAlertView];
    self.defineAlertView = defineAlertView;
    //设置自己的frame
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, defineAlertView.frame.size.width, defineAlertView.frame.size.height );
}

//给自己的子控件传递模型
-(void)setAnnotation:(id<MKAnnotation>)annotation{
    [super setAnnotation:annotation];
    ZHDefineAlertAnnotation *defineAnno = annotation;
    self.defineAlertView.defineDataModel  = defineAnno.defineModel;
}

@end
