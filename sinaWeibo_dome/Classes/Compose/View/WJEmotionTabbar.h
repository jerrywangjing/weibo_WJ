//
//  WJEmotionTabbar.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/8/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
// 表情底部的选项卡

#import <UIKit/UIKit.h>

@class WJEmotionTabbar;
typedef enum {

    WJEmotionTabbarButtonTypeRecent,
    WJEmotionTabbarButtonTypeDefault,
    WJEmotionTabbarButtonTypeEmoji,
    WJEmotionTabbarButtonTypeLxh,
    
}WJEmotionTabbarButtonType;
@protocol WJEmotionTabbarDelegate <NSObject>

@optional
-(void)emotienTabBar:(WJEmotionTabbar *)tabBar didSelectButton:(WJEmotionTabbarButtonType)buttonType;

@end
@interface WJEmotionTabbar : UIView
@property (nonatomic,weak) id<WJEmotionTabbarDelegate> delegate;

@end
