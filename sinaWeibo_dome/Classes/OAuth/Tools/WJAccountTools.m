//
//  WJAccountTools.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/1.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJAccountTools.h"
#import "WJAccount.h"

// 账号的存储路径
#define  accountPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:@"account.archiver"]

@implementation WJAccountTools

/**
 *  存储账号
 *
 *  @param account 账号模型
 */
+(void)saveAccount:(WJAccount *)account{

    // 存储账号数据，存进沙盒
    
    /*注意*：1.自定义对象的存储必须用NSKeyedArchiver归档，不能用writeToFiles 方法(此方法只适用于数组、字典类型)
     2.而且所要归档的对象必须遵守NSCoding协议,实现协议方法
     */
    // 归档
    BOOL success = [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
    if (success) {
        //NSLog(@"保存成功");
    }else{
    
        NSLog(@"保存失败");
    }
    
}

/**
 *  返回账号信息
 *
 *  @return 账号模型(如果账号过期，返回nil)
 */
+(WJAccount *)unarchiverAccount{

    // 加载模型
    WJAccount * account = [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    // 验证账号是否过期
    long long expires_in = [account.expires_in longLongValue];
    // 获取过期时间
    NSDate * expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获取当前时间
    NSDate * now = [NSDate date];
    // 比较
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {// 过期
        return nil;
    }
    return account;
}
@end
