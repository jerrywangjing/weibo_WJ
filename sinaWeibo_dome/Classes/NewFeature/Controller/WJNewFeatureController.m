//
//  WJNewFeatureController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/29.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJNewFeatureController.h"
#import "WJTabBarViewController.h"
#define pageNumber 4

@interface WJNewFeatureController ()
@property (nonatomic,weak) UIPageControl * pageCtrl;

@end
@implementation WJNewFeatureController
-(void)viewDidLoad{

    [super viewDidLoad];
    // 1.创建一个scrollView
    UIScrollView * scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(scrollView.width *pageNumber, scrollView.height);//这里的高度也可以设为0
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;// 重要属性
    scrollView.bounces = NO;// 关闭弹球效果
    [self.view addSubview:scrollView];
    
    UIPageControl * pageCtl = [[UIPageControl alloc] init];
    _pageCtrl = pageCtl;
    _pageCtrl.centerX = self.view.centerX;
    _pageCtrl.y = SCREEN_HEIGHT -50;
    _pageCtrl.numberOfPages = pageNumber;
    _pageCtrl.currentPageIndicatorTintColor = [UIColor orangeColor];
    _pageCtrl.pageIndicatorTintColor = [UIColor grayColor];
    [self.view addSubview:_pageCtrl];
    [self.view bringSubviewToFront:_pageCtrl];
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;

    for (int i = 0; i<pageNumber; i++) {
        UIImageView * imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        imgView.width = scrollW;
        imgView.height = scrollH;
        
        imgView.x = i  * imgView.width;
        imgView.image = [UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d",i+1]];
        [scrollView addSubview:imgView];
        
        // 添加最后一个图片上的控制器切换按钮
        if (i == pageNumber - 1) {
            [self setupLastImageView:imgView];
        }
    }
}
-(void)setupLastImageView:(UIImageView *)imgView{
    
    // 添加checkBox 按钮
    UIButton * shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    shareBtn.width = 100;
    shareBtn.height = 30;
    shareBtn.centerX = imgView.width /2;
    shareBtn.centerY = imgView.height * 0.65;//根据屏幕大小决定

    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0); // 调整按钮内容控件的整体缩进
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [imgView addSubview:shareBtn];
    
    // 添加开启微博按钮
    UIButton * startBtn = [[UIButton alloc] init];

    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开启微博" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    startBtn.size = startBtn.currentBackgroundImage.size;
    /**
     *  这里注意： 要先设置starBtn的宽高才能设置它的centerX位置
     */
    startBtn.centerX = imgView.width/2;
    startBtn.centerY = imgView.height * 0.75;
    [startBtn addTarget:self action:@selector(startBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [imgView addSubview:startBtn];
    
}

-(void)startBtnClick:(UIButton *)btn{

    // 切换到WJTabBarViewController（这种方式可以销毁新特性控制器，被强指针指向的对象，如果引用者不再指向它时，它会立即销毁）
    WJTabBarViewController * tabBarVc = [[WJTabBarViewController alloc] init];
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVc;
}
-(void)shareBtnClick:(UIButton * )btn{

    /**
     *  知识点：(状态取反)根据当前状态判断是否normal还是selected
     */
    btn.selected = !btn.selected;
}
#pragma mark - scrollView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int currentNum = (scrollView.contentOffset.x + scrollView.frame.size.width /2) /scrollView.frame.size.width;
    self.pageCtrl.currentPage = currentNum;
    
}
@end
