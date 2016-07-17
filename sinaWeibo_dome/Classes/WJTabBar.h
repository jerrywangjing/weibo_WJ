//
//  WJTabBar.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/17.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJTabBar;

#warning 因为HWTabBar继承自UITabBar，所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol WJTabBarDelegate <UITabBarDelegate>

@optional
- (void)tabBarDidClickPlusButton:(WJTabBar *)tabBar;

@end
@interface WJTabBar : UITabBar
@property (nonatomic,weak) id<WJTabBarDelegate> delegate;

@end
