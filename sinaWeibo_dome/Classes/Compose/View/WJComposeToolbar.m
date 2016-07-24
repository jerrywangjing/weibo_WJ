//
//  WJComposeToolbar.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJComposeToolbar.h"

@implementation WJComposeToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        // 初始化按钮
        [self setupImgWithNor:@"compose_camerabutton_background" hltImg:@"compose_camerabutton_background_highlighted"];
        [self setupImgWithNor:@"compose_toolbar_picture" hltImg:@"compose_toolbar_picture_highlighted"];
        [self setupImgWithNor:@"compose_mentionbutton_background" hltImg:@"compose_mentionbutton_background_highlighted"];
        [self setupImgWithNor:@"compose_trendbutton_background" hltImg:@"compose_trendbutton_background_highlighted"];
        [self setupImgWithNor:@"compose_emoticonbutton_background" hltImg:@"compose_emoticonbutton_background_highlighted"];
    }
    return self;
}

-(void)setupImgWithNor:(NSString *)norImg hltImg:(NSString *)hltImg{

    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:norImg] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hltImg] forState:UIControlStateHighlighted];
    [self addSubview:btn];
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
@end
