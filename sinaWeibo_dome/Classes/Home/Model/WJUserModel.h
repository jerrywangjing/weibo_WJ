//
//  WJUserModel.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/9.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJUserModel : NSObject
/**
 *  用户的UID
 */
@property (nonatomic,copy) NSString * idstr;
/**
 *  用户昵称
 */
@property (nonatomic,copy) NSString * name;
/**
 *  用户头像
 */ 
@property (nonatomic,copy) NSString * profile_image_url;

/**
 *  会员类型(几级会员)
 */
@property (nonatomic,assign) int mbtype;
/**
 *  会员等级（当mbrank返回值大于2的时候说明是会员）
 */
@property (nonatomic,assign) int  mbrank;
/**
 *  是否vip
 */
@property (nonatomic,assign,getter=isVip) BOOL vip;

@end
