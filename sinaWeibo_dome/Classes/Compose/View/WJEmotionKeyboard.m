//
//  WJEmotionKeyboard.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/8/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
// 表情视图根视图

#import "WJEmotionKeyboard.h"
#import "WJEmotionTabbar.h"
#import "WJEmotionListView.h"

@interface WJEmotionKeyboard ()
@property (nonatomic,weak) WJEmotionListView * listView;
@property (nonatomic,weak) WJEmotionTabbar * tabBar;

@end
@implementation WJEmotionKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.表情内容
        WJEmotionListView * listView = [[WJEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        // 2. tabbar
        WJEmotionTabbar * tabbar = [[WJEmotionTabbar alloc] init];
        [self addSubview:tabbar];
        self.tabBar = tabbar;
    }
    return self;
}


-(void)layoutSubviews{

    // 1.表情tabBar
    self.tabBar.height = 40;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.width = self.width;
    self.tabBar.x = 0;
    // 2.表情内容
    self.listView.x = self.listView.y = 0;
    self.listView.width = self.width;
    self.listView.height = self.tabBar.y;
}
@end
