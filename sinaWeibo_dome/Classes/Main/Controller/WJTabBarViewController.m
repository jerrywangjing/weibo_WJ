//
//  WJTabBarViewController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/19.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJTabBarViewController.h"
#import "WJHomeTableViewController.h"
#import "WJMessageTableViewController.h"
#import "WJDiscoverTableViewController.h"
#import "WJMeTableViewController.h"
#import "WJMainNavigationController.h"
#import "WJTabBar.h"
#import "WJComposeViewController.h"

@interface WJTabBarViewController ()

@end

@implementation WJTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tabbar属性

    //  设置子控制器
    WJHomeTableViewController * vc1 = [[WJHomeTableViewController alloc] init];
    [self setChildVc:vc1 AttributesWithTitle:@"首页" addImg:@"tabbar_home" hiltImg:@"tabbar_home_selected"];
    vc1.view.backgroundColor = [UIColor whiteColor];
    
    WJMessageTableViewController * vc2 = [[WJMessageTableViewController alloc] init];
    [self setChildVc:vc2 AttributesWithTitle:@"消息" addImg:@"tabbar_message_center" hiltImg:@"tabbar_message_center_selected"];
    
    WJDiscoverTableViewController * vc3 = [[WJDiscoverTableViewController alloc] init];
    [self setChildVc:vc3 AttributesWithTitle:@"发现" addImg:@"tabbar_discover" hiltImg:@"tabbar_discover_selected"];
    
    WJMeTableViewController * vc4 = [[WJMeTableViewController alloc] init];
    [self setChildVc:vc4 AttributesWithTitle:@"我" addImg:@"tabbar_profile" hiltImg:@"tabbar_profile_selected"];
    
    //使用自定义tabBar更换系统自带的tabbar
    WJTabBar * tabBar = [[WJTabBar alloc] init];
    /**
     *  这里使用kvc 修改系统的只读属性，即便此属性是只读的kvc任然可以去修改
     */
    [self setValue:tabBar forKeyPath:@"tabBar"];

}

// 创建tabbarVc子控制器
-(void)setChildVc:(UIViewController *)childVc AttributesWithTitle:(NSString *)title addImg:(NSString *)image hiltImg:(NSString *)HImg{

    childVc.title = title;
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:HImg]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置字体样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //textAttrs[NSForegroundColorAttributeName] = LCColorForTabBar(123, 123, 123);//简便方法
    [textAttrs setObject:WJRGBColor(123, 123, 123) forKey:NSForegroundColorAttributeName];
                                        
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];

    // 嵌入导航控制器
    WJMainNavigationController * navVc = [[WJMainNavigationController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:navVc];

}

#pragma mark - WJTabBarDelegate代理方法_自定义tabBar

- (void)tabBarDidClickPlusButton:(WJTabBar *)tabBar
{
    WJComposeViewController * vc = [[WJComposeViewController alloc] init];
    WJMainNavigationController * nav = [[WJMainNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:YES completion:nil];
}
@end
