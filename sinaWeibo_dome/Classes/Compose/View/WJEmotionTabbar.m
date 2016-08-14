//
//  WJEmotionTabbar.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/8/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJEmotionTabbar.h"
#import "WJEmotionTabbarButton.h"

@interface WJEmotionTabbar ()
@property (nonatomic,weak) UIButton * selectedBtn; //记录上一个选中的btn

@end
@implementation WJEmotionTabbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" btnType:WJEmotionTabbarButtonTypeRecent];
        [self setupBtn:@"默认" btnType:WJEmotionTabbarButtonTypeDefault];
        [self setupBtn:@"Emoji" btnType:WJEmotionTabbarButtonTypeEmoji];
        [self setupBtn:@"浪小花" btnType:WJEmotionTabbarButtonTypeLxh];
    }
    return self;
}

-(WJEmotionTabbarButton *)setupBtn:(NSString *)title btnType:(WJEmotionTabbarButtonType)type{

    WJEmotionTabbarButton * btn = [[WJEmotionTabbarButton alloc] init];
    btn.tag = type;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    // 设置默认按钮
    if (type == WJEmotionTabbarButtonTypeDefault) {
        [self btnClick:btn];
    }
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
    [btn setBackgroundImage:[UIImage imageNamed: selectImage] forState:UIControlStateDisabled];
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

- (void)setDelegate:(id<WJEmotionTabbarDelegate>)delegate
{
    _delegate = delegate;
    
    // 选中“默认”按钮
    [self btnClick:(WJEmotionTabbarButton *)[self viewWithTag:WJEmotionTabbarButtonTypeDefault]];
}

-(void)btnClick:(UIButton *)btn{

    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(emotienTabBar:didSelectButton:)]) {
        [self.delegate emotienTabBar:self didSelectButton:(int)btn.tag];
    }
}
@end
