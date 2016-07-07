//
//  UIBarButtonItem+WJExtension.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/21.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WJExtension)
/**
 *  创建一个自定义item
 *
 *  @param target    点击后调用action方法的对象
 *  @param action    点击后需要执行的方法
 *  @param image     btn默认状态的图片
 *  @param highImage btn选择后的图片
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage;
@end
