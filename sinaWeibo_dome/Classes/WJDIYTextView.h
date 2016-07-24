//
//  WJDIYTextView.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/23.
//  Copyright © 2016年 JerryWang. All rights reserved.

// **带有占位符的TextView**

#import <UIKit/UIKit.h>
// MJ建议，一般写工具类先写接口
@interface WJDIYTextView : UITextView
/**
 *  占位文字
 */
@property (nonatomic,copy) NSString * placeholder;
/**
 *  占位文字的颜色
 */
@property (nonatomic,strong) UIColor * placeholderColor;
@end
