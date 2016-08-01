//
//  WJDIYSearchBar.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/28.
//  Copyright © 2016年 JerryWang. All rights reserved.

/**
    使用UITextField 来实现自定义UISearchBar
 */

#import "WJDIYSearchBar.h"

@implementation WJDIYSearchBar

-(id)initWithFrame:(CGRect)frame{

    if ([super initWithFrame:frame]) {
        
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.width = [UIScreen mainScreen].bounds.size.width;
        // 通过init来创建初始化绝大部分控件，控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;

    }
    return  self;
}

+(instancetype)DIYSearchBar{

    return [[self alloc] init];
}
@end
