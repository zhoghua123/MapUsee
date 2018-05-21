//
//  ZHDefineAlertView.m
//  MapUse-01
//
//  Created by xyj on 2018/5/16.
//  Copyright © 2018年 xyj. All rights reserved.
//

#import "ZHDefineAlertView.h"
@interface ZHDefineAlertView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;

@end

@implementation ZHDefineAlertView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}
+(instancetype)defineAlertView{
    return [[NSBundle mainBundle] loadNibNamed:@"ZHDefineAlertView" owner:nil options:nil].lastObject;
}

-(void)setDefineDataModel:(ZHDefineDataModel *)defineDataModel{
    _defineDataModel = defineDataModel;
    self.iconView.image = [UIImage imageNamed:defineDataModel.image];
    self.titleLabel.text = defineDataModel.title;
    self.subLabel.text = defineDataModel.desc;
}

/**
 *  重要方法!!!!!!!: 当一个view被添加到父控件中,就会调用
 */
- (void)didMoveToSuperview{
    //缩放动画: 有一些弹簧效果
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.scale";
    anim.values = @[@0, @1.5, @1, @1.5, @1];
    anim.duration = 0.5;
    [self.layer addAnimation:anim forKey:nil];
}
@end
