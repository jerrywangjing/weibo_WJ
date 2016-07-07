//
//  WJDIYSearchBar.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/28.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJDIYSearchBar : UITextField
/**
 *  <自定义搜索框>
 *  使用注意：添加后，需要设置搜索框的高度才能显示出来，自定义背景图片需要设置拉伸属性
 *  例如:
 *   WJDIYSearchBar * diyBar = [WJDIYSearchBar DIYSearchBar];
     diyBar.height = 30;
     self.navigationItem.titleView = diyBar;
 */
+(instancetype)DIYSearchBar;
@end
