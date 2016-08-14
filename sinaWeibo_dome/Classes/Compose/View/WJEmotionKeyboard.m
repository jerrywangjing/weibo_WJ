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
#import "WJEmotion.h"

@interface WJEmotionKeyboard ()<WJEmotionTabbarDelegate>
/** 保存正在显示listView */
@property (nonatomic, weak) WJEmotionListView *showingListView;
/** 表情内容 */
@property (nonatomic, strong) WJEmotionListView *recentListView;
@property (nonatomic, strong) WJEmotionListView *defaultListView;
@property (nonatomic, strong) WJEmotionListView *emojiListView;
@property (nonatomic, strong) WJEmotionListView *lxhListView;

@property (nonatomic,weak) WJEmotionTabbar * tabBar;

@end
@implementation WJEmotionKeyboard

#pragma mark - 懒加载
- (WJEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[WJEmotionListView alloc] init];
    }
    return _recentListView;
}

- (WJEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[WJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [WJEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

- (WJEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[WJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [WJEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (WJEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[WJEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [WJEmotion mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        // tabbar
        WJEmotionTabbar * tabbar = [[WJEmotionTabbar alloc] init];
        [self addSubview:tabbar];
        tabbar.delegate = self;
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
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
}

-(void)emotienTabBar:(WJEmotionTabbar *)tabBar didSelectButton:(WJEmotionTabbarButtonType)buttonType{

    // 移除正在显示的listView控件
    [self.showingListView removeFromSuperview];
    
    // 根据按钮类型，切换键盘上面的listview
    switch (buttonType) {
        case WJEmotionTabbarButtonTypeRecent: { // 最近
            [self addSubview:self.recentListView];
            //self.showingListView = self.recentListView;
            break;
        }
            
        case WJEmotionTabbarButtonTypeDefault: { // 默认
            [self addSubview:self.defaultListView];
            //self.showingListView = self.defaultListView;
            break;
        }
            
        case WJEmotionTabbarButtonTypeEmoji: { // Emoji
            [self addSubview:self.emojiListView];
            //self.showingListView = self.emojiListView;
            break;
        }
            
        case WJEmotionTabbarButtonTypeLxh: { // Lxh
            [self addSubview:self.lxhListView];
            //self.showingListView = self.lxhListView;
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    // 设置frame
    [self setNeedsLayout];
}
@end
