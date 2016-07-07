//
//  WJStatusesModel.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/9.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WJUserModel;

@interface WJStatusesModel : NSObject
/**
 *  微博ID(字符串类型)
 */
@property (nonatomic,copy) NSString * idstr;
/**
 *  微博信息内容
 */
@property (nonatomic,copy) NSString * text;
/**
 *  微博作者的用户信息字段
 */
@property (nonatomic,strong) WJUserModel * user;
/**	string	微博创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	string	微博来源*/
@property (nonatomic, copy) NSString *source;
/** 微博配图 */
@property (nonatomic,strong) NSArray * pic_urls;
/** 转发的微博对象*/
@property (nonatomic,strong) WJStatusesModel * retweeted_status;

/** 转发、评论、表态数*/
@property (nonatomic,assign) NSInteger  reposts_count;
@property (nonatomic,assign) NSInteger  comments_count;
@property (nonatomic,assign) NSInteger  attitudes_count;


@end
