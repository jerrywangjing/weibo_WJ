//
//  NSString+WJExtension.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (WJExtension)
/** 计算文字大小(可指定文字最大宽度)*/
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

/** 计算文字大小(文字宽度无限制)*/
- (CGSize)sizeWithFont:(UIFont *)font;
@end
