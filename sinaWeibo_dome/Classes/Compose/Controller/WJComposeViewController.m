//
//  WJComposeViewController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/23.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJComposeViewController.h"
#import "WJAccountTools.h"
#import "WJAccount.h"
#import "WJDIYTextView.h"
#import "WJDIY2TextView.h"
#import "WJComposeToolbar.h"

@interface WJComposeViewController ()<UITextViewDelegate>
/** 输入控件 */
@property (nonatomic, weak) WJDIY2TextView *textView;
/** 键盘顶部的工具条 */
@property (nonatomic, weak) WJComposeToolbar *toolbar;
/** 相册（存放拍照或者相册中选择的图片） */
//@property (nonatomic, weak) WJComposePhotosView *photosView;

@end

@implementation WJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav]; // 创建导航栏内容
    [self setupTextView]; //创建输入控件
    [self setupToolbar]; // 创建工具条

}

-(void)setupNav{

    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    
    // titleView的创建
    UILabel * titleView = [[UILabel alloc] init];
    titleView.width = 200;
    titleView.height = 100;
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.numberOfLines = 0; //自动换行
    
    NSString * name = [WJAccountTools unarchiverAccount].name;
    name = @"晶晶亮By2016";
    if (name) {
    NSString * str = [NSString stringWithFormat:@"发微博\n%@",name];
    // 创建一个带有属性的字符串(比如颜色属性、字体属性等文字属性)
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    // 添加属性
    
    NSRange range = [str rangeOfString:@"晶晶亮By2016"];
    [attrStr addAttribute:NSForegroundColorAttributeName value:WJRGBColor(150, 150, 150) range:range];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
    titleView.attributedText = attrStr;
    
    self.navigationItem.titleView = titleView;
    }else{
    
        self.navigationItem.title = @"发微博"; 
    }
}
/**
    UITextField:
 1.文字永远是一行，不能显示多行文字
 2.有placehoder 
 3.继承中UIControl 可以使用addTarget 添加监听事件
 4.可以设置代理
 5.可以监听通知
    UITextView
 1.能显示多行文字
 2.不能设置占位符
 3.继承自UIScrollview
 4.可设置代理
 5.可设置通知
 
 */
-(void)setupTextView{

    WJDIY2TextView * textView = [[WJDIY2TextView alloc] init];
    textView.placeholderStr = @"分享你的新鲜事...";
    //textView.placeholderColor = [UIColor redColor]; //默认是灰色
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:13];
    textView.alwaysBounceVertical = YES;//垂直方向上一直可以拖拽
    textView.delegate = self;
    [self.view  addSubview:textView];
    self.textView = textView;
    
    // 文字改变的通知
    [WJNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    // 键盘通知
    [WJNotificationCenter addObserver:self selector:@selector(keyboaedwillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
}

-(void)setupToolbar{

    WJComposeToolbar * toolbar = [[WJComposeToolbar alloc] init];
    _toolbar = toolbar;
    toolbar.width = self.view.width;
    toolbar.height = 44;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    // inputAccessoryView 设置显示在键盘顶部的内容
    //self.textView.inputAccessoryView = toolbar;
}
//在这里修改导航栏按钮属性
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 此方法在viewDidLoad方法完成后执行
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)cancel{

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)send{
//
//    if (self.photosView.photos.count) {
//        [self sendWithImage];
//    } else {
        [self sendWithoutImage];
//    }
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

//-(void)sendWithImage{

    
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    /**	pic true binary 微博的配图。*/
    
    // 1.请求管理者
//    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
//    
//    // 2.拼接请求参数
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = [WJAccountTools unarchiverAccount].access_token;
//    params[@"status"] = self.textView.text;
//    
//    // 3.发送请求
//    
//    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        // 拼接文件数据
//        UIImage *image = [self.photosView.photos firstObject];
//        NSData *data = UIImageJPEGRepresentation(image, 1.0);
//        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
//    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         [MBProgressHUD showSuccess:@"发送成功"];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//         [MBProgressHUD showSuccess:@"发送失败"];
//    }];
//
//}
-(void)sendWithoutImage{

    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status: true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token: true string*/
    // 1.请求管理者
    AFHTTPSessionManager * mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WJAccountTools unarchiverAccount].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showSuccess:@"发送失败"];
    }];

}
-(void)textDidChange{

    if (self.textView.text.length > 0) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }else{
    
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
    
}
//键盘出现监听方法
-(void)keyboaedwillChangeFrame:(NSNotification *)noti{

    /**
     userInfo 中的信息：
     {
     UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 568}, {320, 224}},
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 344}, {320, 224}},//键盘弹出隐藏的frame
     UIKeyboardAnimationDurationUserInfoKey = 0.25,//弹出隐藏动画时间
     UIKeyboardAnimationCurveUserInfoKey = 7,//弹出隐藏的动画节奏(先块后慢，等等)
     }
     */
    NSDictionary * userInfo = noti.userInfo;
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue]; // 键盘的frame
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.y = keyboardFrame.origin.y - self.toolbar.height;
    }];
}

#pragma mark - scrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //注意：offset 向上拖是正值，向下拉是负值，如果有导航栏的话起始位置是-64

    switch ((NSInteger)scrollView.contentOffset.y) {
        case -70: [self.textView endEditing:YES];
            break;
        case -60: [self.textView becomeFirstResponder];
            break;
        default:
            break;
    }

}
-(void)dealloc{

    [WJNotificationCenter removeObserver:self];
}
@end
