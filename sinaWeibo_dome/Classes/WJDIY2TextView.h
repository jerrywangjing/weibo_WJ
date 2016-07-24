//
//  WJDIY2TextView.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJDIY2TextView : UITextView
// MJ建议，一般写工具类先写接口
/**
 *  占位文字
 */
@property (nonatomic,copy) NSString * placeholderStr;
/**
 *  占位文字的颜色
 */
@property (nonatomic,strong) UIColor * placeholderColor;

@end
