//
//  WJMainNavigationController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/21.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJMainNavigationController.h"

@implementation WJMainNavigationController

+(void)initialize{

    // 设置全局所有导航栏item的主题样式（颜色，大小）
    UIBarButtonItem * item = [UIBarButtonItem appearance];
    
    // 设置item普通状态
    NSMutableDictionary * textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
//    // 设置item不可用状态
    NSMutableDictionary * disableTextAttrs = [NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = WJRGBColor(200, 200, 200);
    disableTextAttrs[NSFontAttributeName] = textAttrs[NSFontAttributeName];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    

}

-(void)viewDidLoad{

    [super viewDidLoad];
    
}
@end
