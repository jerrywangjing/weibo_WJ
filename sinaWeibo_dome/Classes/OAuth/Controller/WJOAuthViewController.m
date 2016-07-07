//
//  WJOAuthViewController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/30.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJOAuthViewController.h"
#import "WJAccount.h"
#import "MBProgressHUD+MJ.h"
#import "WJAccountTools.h"

#define appKey @"2581243918"
#define appSecret @"57ff3e5945989444d6e9bca983917a76"

@implementation WJOAuthViewController
-(void)viewDidLoad{

    UIWebView * webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // 用webview加载登录界面
    NSString * redirectUri = @"http://";
    
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&response_type=code&redirect_uri=%@",appKey,redirectUri]];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    
}

#pragma mark - webViewd delegate 
-(void)webViewDidStartLoad:(UIWebView *)webView{

    [MBProgressHUD showMessage:@"正在加载..."];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView{

    [MBProgressHUD hideHUD];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{

    [MBProgressHUD hideHUD];
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
 
    // 1.获取返回的完整url
    NSString * url = request.URL.absoluteString;
    // 2. 判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    
    if (range.length != 0) {
        // 截取code= 后面的参数
        NSUInteger fromIndex = range.location + range.length;
        NSString * code = [url substringFromIndex:fromIndex];
        // 利用code换取一个accessToken
        [self accessTokenWithCode:code];
        // 禁止加载回调地址,防止页面会转到其他页面
        return NO;
    }
    return YES;
}
/**
 * 利用code换取一个accessToken
 *
 *  @param code 授权成功后的请求标记
 */
-(void)accessTokenWithCode:(NSString * )code{

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    //manager.responseSerializer = [AFJSONResponseSerializer serializer];默认值
//    NSString * fullUrl = htstps://api.weibo.com/oauth2/access_token?client_id=YOUR_CLIENT_ID&client_secret=YOUR_CLIENT_SECRET&grant_type=authorization_code&redirect_uri=YOUR_REGISTERED_REDIRECT_URI&code=CODE
//"
    NSString * requestUrl = @"https://api.weibo.com/oauth2/access_token";
    
    // post 请求参数存放在字典中
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"client_id"] = appKey;
    params[@"client_secret"] = appSecret;
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = code;
    // 发送post请求
    [manager POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
        [MBProgressHUD hideHUD];
        // 存储账号信息
            //将返回的字典转为模型，存进沙盒
        WJAccount * account = [WJAccount accountWithDic:responseObject];
        [WJAccountTools saveAccount:account];
        // 切换窗口的根控制器
       UIWindow * window = [UIApplication sharedApplication].keyWindow;
        [window exchangeRootViewController];
     //access_token = 2.00CAkcBD79dgoC798bd67e01qoaJ9E
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"授权失败%@",error);
        [MBProgressHUD hideHUD];
    }];
}

@end
