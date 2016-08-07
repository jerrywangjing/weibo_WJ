//
//  WJComposeToolbar.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJComposeToolbar.h"

@interface WJComposeToolbar ()
@property (nonatomic,weak)  UIButton * emtionBtn;

@end
@implementation WJComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 初始化按钮
        [self setupImgWithNor:@"compose_camerabutton_background" hltImg:@"compose_camerabutton_background_highlighted" type:WJComposeToolbarButtonTypeCamera];
        [self setupImgWithNor:@"compose_toolbar_picture" hltImg:@"compose_toolbar_picture_highlighted" type:WJComposeToolbarButtonTypePicture];
        [self setupImgWithNor:@"compose_mentionbutton_background" hltImg:@"compose_mentionbutton_background_highlighted" type:WJComposeToolbarButtonTypeMention];
        [self setupImgWithNor:@"compose_trendbutton_background" hltImg:@"compose_trendbutton_background_highlighted" type:WJComposeToolbarButtonTypeTrend];
        self.emtionBtn = [self setupImgWithNor:@"compose_emoticonbutton_background" hltImg:@"compose_emoticonbutton_background_highlighted" type:WJComposeToolbarButtonTypeEmotion];
    }
    return self;
}

-(UIButton *)setupImgWithNor:(NSString *)norImg hltImg:(NSString *)hltImg type:(WJComposeToolbarButtonType) type{

    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hltImg] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    // 给每个按钮绑定一个枚举值
    btn.tag = type;
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置多有按钮的frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width/count;
    CGFloat btnH = self.height;
    for (NSInteger i = 0; i<count; i++) {
        UIButton * btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i*btnW;
        btn.height = btnH;
    }
    
}
// btn点击方法
-(void)btnClick:(UIButton *)btn{

    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:(int)btn.tag];
    }
}

-(void)setShowKeyboardBtn:(BOOL)showKeyboardBtn{
    _showKeyboardBtn = showKeyboardBtn;
    
    if (showKeyboardBtn) {
        // 显示键盘表情
        [self.emtionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background"] forState:UIControlStateNormal];
        [self.emtionBtn setImage:[UIImage imageNamed:@"compose_keyboardbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }else{
        // 显示表情按钮
        [self.emtionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background"] forState:UIControlStateNormal];
        [self.emtionBtn setImage:[UIImage imageNamed:@"compose_emoticonbutton_background_highlighted"] forState:UIControlStateHighlighted];
    }
}
@end
