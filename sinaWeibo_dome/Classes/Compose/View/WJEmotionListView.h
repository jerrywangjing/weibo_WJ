//
//  WJEmotionListView.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/8/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
// 表情键盘中的所有表情视图

#import <UIKit/UIKit.h>

@interface WJEmotionListView : UIView
/** 表情(里面存放的WJEmotion模型) */
@property (nonatomic, strong) NSArray *emotions;
@end
