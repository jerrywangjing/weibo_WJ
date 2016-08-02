//
//  WJAccount.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/31.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJAccount : NSObject<NSCoding>
/**
 *  接口授权成功后返回的访问密钥(yue)
 */
@property (nonatomic,copy) NSString * access_token;
/**
 *  access_token 的生命周期，单位是秒
 */
@property (nonatomic,copy) NSString * expires_in;
/**
 *  当前授权用户的UID (用户ID)
 */
@property (nonatomic,copy) NSString * uid;
/**
 *  access_Token的创建时间
 */
@property (nonatomic,strong) NSDate * created_time;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString * name;


+(instancetype)accountWithDic:(NSDictionary *)dic;
@end
