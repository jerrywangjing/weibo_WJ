//
//  NSString+WJExtension.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/6.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "NSString+WJExtension.h"

@implementation NSString (WJExtension)

// 计算文字大小（size）
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
