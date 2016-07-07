//
//  WJDropDownMenu.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/28.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJDropDownMenu.h"

@interface WJDropDownMenu ()
/**
 *  用来显示具体内容的容器
 */
@property (nonatomic,weak) UIImageView * contentView;

@end
@implementation WJDropDownMenu
/**
 *  注意：使用懒加载的时候属性需要用strong修饰，但是如果先创建再用属性指向它就可以用weak修饰（比较安全）
 */
-(UIImageView *)contentView{

    if (!_contentView) {
        // 添加内容视图
        UIImageView * imgView = [[UIImageView alloc] init];
        imgView.image = [UIImage imageNamed:@"popover_background"];
        _contentView = imgView;
        _contentView.userInteractionEnabled = YES;//开启交互
        [self addSubview:_contentView];
    }
    return _contentView;
}
-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}
+(instancetype)dropDownMenu{

    return [[self alloc] init];
}

-(void)setContent:(UIView *)content{

    _content = content;
    // 调整内容位置
    _content.x = 10;
    _content.y = 15;
    // 添加用户内容到下拉菜单
    self.contentView.height = CGRectGetMaxY(content.frame)+11;
    self.contentView.width = CGRectGetMaxX(content.frame) +10;
    _content.width = self.contentView.width - 2 * content.x;
    [self.contentView addSubview:content];
}
-(void)setContentController:(UIViewController *)contentController{

    _contentController = contentController;
    self.content = contentController.view;
}
/**
 *  对menu的操作方法
 */
-(void)showMenuFrom:(UIView *)from{
    
    // 1. 获得最上层的窗口
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    // 2. 添加自己到窗口上
    [window addSubview:self];
    // 3.设置尺寸
    self.frame = window.bounds;
    // 4.调整内容视图的位置
    /**
     *  知识点：坐标原点转换
         [from convertRect:from.bounds toView:window];
        将from控件的参考原点坐标转换为window 的原点坐标
     */
        [from convertRect:from.frame toView:window];
    self.contentView.x = CGRectGetMaxX(from.frame)-self.contentView.width/2 -10;
    self.contentView.y = CGRectGetMaxY(from.frame) +15;
    // 动画效果
    self.contentView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.35 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        if (finished) {
            // 发出视图以显示的通知
            if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
                [self.delegate dropdownMenuDidShow:self];
            }
        }
    }];
}
-(void)dismissMenu{

    [UIView animateWithDuration:0.3 animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            // 发出视图关闭的通知
            if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
                [self.delegate dropdownMenuDidDismiss:self];
            }else{
            
                NSLog(@"代理方法不能识别");
            }
        }else{
        
            NSLog(@"关闭失败");
        }
    }];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissMenu];
}
@end
