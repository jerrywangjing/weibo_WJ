//
//  AppDelegate.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/19.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "AppDelegate.h"
#import "WJTabBarViewController.h"
#import "WJNewFeatureController.h"
#import "WJOAuthViewController.h"
#import "WJAccount.h"
#import "WJAccountTools.h"
#import "SDWebImageManager.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1. 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    // 注意： 一般把这段代码放到前面创建完window就显示
    [self.window makeKeyAndVisible];
    // 2. 设置根控制器( *判断是否显示新特性* )
        // 2.1判断是否需要登录授权
    WJAccount * account = [WJAccountTools unarchiverAccount ];
    //NSLog(@"%@",account.uid);
    if (account) { // 不需要授权登录
        // 切换主窗口
        [self.window exchangeRootViewController];

    }else{
        // 进行授权登录
        self.window.rootViewController = [[WJOAuthViewController alloc] init];
    }
    
     
    return YES;
}
// 应用程序接到内存报警的时候做如下处理
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application{

    SDWebImageManager * mgr = [SDWebImageManager sharedManager];
    // 1.取消下载
    [mgr cancelAll];
    // 2. 清除内容中的所有图片
    [mgr.imageCache clearMemory];
}
// 当app 进入后台时会调用此方法
-(void)applicationDidEnterBackground:(UIApplication *)application{

    // 向操作系统申请后台运行的资格,能维持多久，就不确定的
        // Expiration : 过期
    UIBackgroundTaskIdentifier task = [application beginBackgroundTaskWithExpirationHandler:^{
        [application endBackgroundTask:task];
    }];
}
@end
