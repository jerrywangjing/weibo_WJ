//
//  HWHttpTool.m
//  黑马微博2期
//
//  Created by apple on 14-10-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HWHttpTool.h"
#import "AFNetworking.h"

@implementation HWHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2. 发送请求
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure
{
    // 1.创建请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.发送请求
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}
@end
