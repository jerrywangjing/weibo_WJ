//
//  WJEmotionTabbar.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/8/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJEmotionTabbar.h"

@interface WJEmotionTabbar ()
@property (nonatomic,weak) UIButton * selectedBtn; //记录上一个选中的btn

@end
@implementation WJEmotionTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近"];
        [self btnClick:[self setupBtn:@"默认"]]; // 设置默认选中
        [self setupBtn:@"Emoji"];
        [self setupBtn:@"浪小花"];
    }
    return self;
}

-(UIButton *)setupBtn:(NSString *)title{

    UIButton * btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    // 设置背景图片
    
    NSString * image = nil;
    NSString * selectImage = nil;
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if (self.subviews.count == 4){
    
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }else{
    
        image = @"compose_emotion_table_mid_normal";
        selectImage = @"compose_emotion_table_mid_selected";
    }

    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed: selectImage] forState:UIControlStateSelected];
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews{

    [super layoutSubviews];
    
    NSInteger count = self.subviews.count;
    CGFloat btnW = self.frame.size.width/count;
    CGFloat btnH = self.height;
    
    for (int i= 0; i<self.subviews.count; i++) {
        UIButton * btn  = self.subviews[i];
        btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
        
    }
}

-(void)btnClick:(UIButton *)btn{

    self.selectedBtn.selected = NO;
    btn.selected = YES;
    self.selectedBtn = btn;
}
@end
