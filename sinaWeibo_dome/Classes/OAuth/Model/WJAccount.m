//
//  WJAccount.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/31.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJAccount.h"

@implementation WJAccount
+(instancetype)accountWithDic:(NSDictionary *)dic{

    WJAccount * account = [[self alloc] init];
    account.access_token = dic[@"access_token"];
    account.uid = dic[@"uid"];
    account.expires_in = dic[@"expires_in"];
    account.name = dic[@"name"];
    
    // 获取账号存储的时间(accessToken的产生时间)只产生一次
    account.created_time = [NSDate date];
    return account;
}

#pragma mark - NSCoding delegate
/**
 *  当一个对象要归档进沙盒的时候就必须调用这个方法
 *  目的：要告诉NSCoder(编码器)这个对象的那些属性要存进沙盒
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{

    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

/**
 *  当从沙盒中解档一个对象是(从沙盒中加载一个对象时)，就会调用这个方法
 *  目的：在这个方法中说明沙盒中的属性该怎么解析(需要取出那些属性)
 */
-(instancetype)initWithCoder:(NSCoder *)aDecoder{

    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
    }
    return self;
}
@end
