//
//  UIBarButtonItem+WJExtension.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/21.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "UIBarButtonItem+WJExtension.h"

@implementation UIBarButtonItem (WJExtension)

+(UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(UIImage *)image highImage:(UIImage *)highImage{

    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    btn.size = btn.currentImage.size;
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]  initWithCustomView:btn];
}
@end
