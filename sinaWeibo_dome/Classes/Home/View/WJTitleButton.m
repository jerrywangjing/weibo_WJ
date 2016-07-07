//
//  WJTitleButton.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/5.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJTitleButton.h"

@implementation WJTitleButton

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        // 初始化
        
        /**
         *  设置按钮高亮状态时不变灰
         */
        self.adjustsImageWhenHighlighted = NO;
        //_titleBtn.backgroundColor = [UIColor grayColor];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        // 设置内容居中
        self.imageView.contentMode = UIViewContentModeCenter;
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:15];


    }
    return self;
}
/**
 *  设置按钮内部imageView、title的frame
 *
 *  @param contentRect 按钮的bounds
 *
 *  @return 内容frame
 */
//-(CGRect)imageRectForContentRect:(CGRect)contentRect{
//
//    
//}
//
//-(CGRect)titleRectForContentRect:(CGRect)contentRect{
//
//    self.titleLabel.x = self.imageView.image.x;
//    
//}

// 目的：想在系统计算和设置完成按钮的尺寸后,再修改一下尺寸的话可以在此方法中修改
-(void)setFrame:(CGRect)frame{

    frame.size.width +=  10; // 给按钮的宽度增加10
    [super setFrame:frame];
}
-(void)layoutSubviews{

    [super layoutSubviews];//这句一定不能再忘记了
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
    
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}
@end
