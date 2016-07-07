//
//  UIWindow+WJExtension.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/3.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "UIWindow+WJExtension.h"
#import "WJNewFeatureController.h"
#import "WJTabBarViewController.h"

@implementation UIWindow (WJExtension)
-(void)exchangeRootViewController{

    // 判断是否需要显示新特性
    // 获取上一次版本号
    NSString * lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"userVersion"];
    // 获得当前软件的版本号(从info.plist中获取)
    NSDictionary * info = [NSBundle mainBundle].infoDictionary;
    NSString * currentVersion = info[@"CFBundleVersion"];
    
    
    if ([currentVersion doubleValue] > [lastVersion doubleValue]) { // 显示新特性
        WJNewFeatureController * newFeature = [[WJNewFeatureController alloc] init];
        self.rootViewController = newFeature;
        // 将版本号存入沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:@"userVersion"];
        [[NSUserDefaults standardUserDefaults] synchronize];//立即存储
        
    }else{ // 直接进入主页面
        
        WJTabBarViewController * tabBarVc = [[WJTabBarViewController alloc] init];
        self.rootViewController = tabBarVc;
    }

}
@end
