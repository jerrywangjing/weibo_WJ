//
//  WJAccountTools.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/1.
//  Copyright © 2016年 JerryWang. All rights reserved.
//处理账号的所有操作：存储账号，取出账号，

#import <Foundation/Foundation.h>
@class WJAccount;
@interface WJAccountTools : NSObject
/**
 *  存储账号
 */
+(void)saveAccount:(WJAccount *)account;
/**
 *  返回账号信息
 *
 *  @return 账号模型(如果账号过期，返回nil)
 */
+(WJAccount *)unarchiverAccount;
@end
