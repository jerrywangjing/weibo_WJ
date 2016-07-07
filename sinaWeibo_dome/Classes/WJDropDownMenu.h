//
//  WJDropDownMenu.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/28.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJDropDownMenu;
@protocol WJDropDownMenuDelegate<NSObject>
@optional
/**
 *  当视图显示完成时调用
 */
-(void)dropdownMenuDidShow:(WJDropDownMenu *)dropMenu;
/**
 *   当视图关闭后调用
 */
-(void)dropdownMenuDidDismiss:(WJDropDownMenu *)dropMenu;

@end
@interface WJDropDownMenu : UIView
/**
 *  代理对象
 */
@property (nonatomic,weak) id<WJDropDownMenuDelegate> delegate;
/**
 *  用户自定义需要用到的内容视图
 */
@property (nonatomic,strong) UIView * content;
/**
 *  内容视图控制器
 */
@property (nonatomic,strong) UIViewController * contentController;
/**
 *  实例类方法
 *
 *  @return self
 */
+(instancetype)dropDownMenu;
/**
 *   显示菜单
 */
-(void)showMenuFrom:(UIView *)from;
/**
 *  关闭菜单
 */
-(void)dismissMenu;
@end
