//
//  WJHomeTableViewController.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/5/19.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJHomeTableViewController.h"
#import "WJDropDownMenu.h"
#import "WJAccount.h"
#import "WJAccountTools.h"
#import "WJTitleButton.h"
#import "WJStatusesModel.h"
#import "WJUserModel.h"
#import "WJLoadMoreFooter.h"
#import "WJStatusTableViewCell.h"
#import "WJStatusFrame.h"
#import "WJTitleBtnTableViewController.h"

#define TimeLine_api  @"https://api.weibo.com/2/statuses/friends_timeline.json"

@interface WJHomeTableViewController ()<WJDropDownMenuDelegate>

@property (nonatomic,strong) WJDropDownMenu * menuCover;
@property (nonatomic,weak) UIButton * titleBtn;
// 微博数据模型数组(里面放的是frame模型，一个statusFrame 模型代表一条微博)
@property (nonatomic,strong) NSMutableArray * statusFrames;

@end

@implementation WJHomeTableViewController

-(NSMutableArray *)statusFrames{

    if (!_statusFrames) {
        _statusFrames = [[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏按钮
    [self setupNavBarBtns];
    // 添加首页下拉菜单
    [self addDropMenu];
    // 获取用户信息(昵称)
    [self getUserName];
    // 加载最新微博数据
    [self loadNewStatus];
    // 下拉刷新
    [self setupUpRefresh];
    // 下拉刷新
    [self setupDownRefresh];
    
    // 获取未读数
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    // 主线程也会抽时间处理一下timer（mode:不管主线程是否正在处理其他事情，都会执行此timer）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

}

//  获得未读数
-(void)setupUnreadCount{

    // 1.请求管理者
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    
    // 2.拼接请求参数
    WJAccount *account = [WJAccountTools unarchiverAccount];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3.发送请求
    NSString * api = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    
    
    [mgr GET:api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        // 设置提醒数字(微博的未读数)
        // 注意： 任何NSNumber对象，可以调用description方法转为字符串对象
            // 例如：@20 --> @"20"
        NSString *status = [responseObject[@"status"] description];
        
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }

        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败-%@",error);
    }];

}
// 下拉刷新
-(void)setupUpRefresh{

    UIRefreshControl * refreshCtl = [[UIRefreshControl alloc] init];
    [refreshCtl addTarget:self action:@selector(refreshStateChange:) forControlEvents:UIControlEventValueChanged];//当菊花旋转闭合后会触发target方法
    [self.tableView addSubview:refreshCtl];
    [refreshCtl beginRefreshing];// 立即刷新，不会触发valueChange
    // 手动调用刷新方法
    [self refreshStateChange:refreshCtl];
    
}

// 上拉刷新
-(void)setupDownRefresh{

    WJLoadMoreFooter * footer = [WJLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
    
}
// 下拉刷新触发方法
-(void)refreshStateChange:(UIRefreshControl *)refresh{

    // 刷新完毕后要清除bageValue
    self.tabBarItem.badgeValue = nil;
    // 网络获取最新数据
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    // 拼接参数
    WJAccount * account = [WJAccountTools unarchiverAccount];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    //取出最前面的微博(最新微博，since_id 最大的微博)
    WJStatusFrame * firstStatusF = [self.statusFrames firstObject];
    if (firstStatusF) {
            // 若指定此参数，则返回ID比since_id 大的微博 (即since_id时间晚的微博)
         params[@"since_id"] = firstStatusF.status.idstr;

    }
   
    
    // 发送请求
    [manager GET:TimeLine_api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        // 将返回的字典微博数据，转为微信模型数组
        NSArray * newStatuses = [WJStatusesModel mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将status 数组转为statusFrame数组
        NSArray * newFrames = [self statusFrameWithStatuses:newStatuses];
        // 将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newStatuses.count);
        NSIndexSet * set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        // 结束刷新
        [refresh endRefreshing];

        // 显示最新微博的数量
        [self showNewStatusCount:newStatuses.count];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败-%@",error);
        [refresh endRefreshing];
    }];
}

// 显示最新微博的数量
-(void)showNewStatusCount:(NSUInteger)count{

    // 1.创建label
    UILabel * label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    // 2.设置显示内容
    if (count == 0) {
        label.text = @"没有新的微博数据";
    }else{
        label.text = [NSString stringWithFormat:@"共有%ld条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    // 3. 添加
    label.y = 64- label.height;
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    // 4. 添加动画
    [UIView animateWithDuration:1.0 animations:^{
        //label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height); // 平移label的高度
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:1.0 options:UIViewAnimationOptionCurveLinear animations:^{
            //label.y -= label.height;
            label.transform = CGAffineTransformIdentity;//回到以前的状态
        } completion:^(BOOL finished) {
            // 销毁label
            [label removeFromSuperview];
        }];
    }];
}
// 加载最新微博数据
-(void)loadNewStatus{

     // 用户信息及其关注的好友信息 API:https://api.weibo.com/2/statuses/friends_timeline.json
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSString * access_token = @"2.00CAkcBD79dgoC798bd67e01qoaJ9E";
    
    //NSString * api = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    param[@"access_token"] = access_token;
    //param[@"count"] = @2; //设置获取到的微博数量
    
    [manager GET:TimeLine_api parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        //NSLog(@"data--%@",responseObject);
        // 获取返回数据
//        NSArray * dicArr = responseObject[@"statuses"];
//        for (NSDictionary * dic in dicArr) {
//            
//            // 使用MJExtension 字典转模型
//            WJStatusesModel * status = [WJStatusesModel mj_objectWithKeyValues:dic];
//            
//            [self.statuses addObject:status];
//        }
        // 直接通过字典数组转模型
        NSArray * statuses = [WJStatusesModel mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        // status 转frame 模型
        [self statusFrameWithStatuses:statuses];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"用户微博信息获取失败-%@",error);
        }
    }];
}

// 加载更多数据(上拉刷新)
-(void)loadMoreStatus{

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    WJAccount * account = [WJAccountTools unarchiverAccount];
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    // 取出最后的微博
    WJStatusFrame * lastStatusF = [self.statusFrames lastObject];
    if (lastStatusF) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    // 发送请求
    [manager GET:TimeLine_api parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseObject) {
        // 转模型
        NSArray * newStatuses = [WJStatusesModel mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

        //转frame模型
        NSArray * newFrame = [self statusFrameWithStatuses:newStatuses];
        if (newFrame.count > 0) {
            // 将更多的微博数据，添加到总数组的最后面
            [self.statusFrames addObjectsFromArray:newFrame];
            // 刷新表格
            [self.tableView reloadData];

        }else{
        
            [MBProgressHUD showLabel:@"没有更多微博数据"];
        }
        
        // 结束刷新（隐藏footerview）
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"加载更多请求失败-%@",error);
    }];
    
}
-(void)getUserName{
    // 获取用户信息 API：https://api.weibo.com/2/users/show.json
   
    
    NSString * userInfoApi = @"https://api.weibo.com/2/users/show.json";
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    /**
     参数： access_token: 2.00CAkcBD79dgoC798bd67e01qoaJ9E
            uid : 2772408122
     */
    WJAccount * account = [WJAccountTools unarchiverAccount];
    NSMutableDictionary * param = [NSMutableDictionary dictionary];
    [param setObject:account.access_token forKey:@"access_token"];
    [param setObject:account.uid forKey:@"uid"];
    
    [manager GET:userInfoApi parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary * userInfo = responseObject;
        NSString * userName = userInfo[@"name"];
        // 先取出标题按钮
        UIButton * titleBtn = (UIButton *)self.navigationItem.titleView;
        [titleBtn setTitle:userName forState:UIControlStateNormal];
        //存储昵称到沙盒
        account.name = userName;
        [WJAccountTools saveAccount:account];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"用户信息获取失败");
    }];
}
-(void)addDropMenu{

    WJTitleButton * titleBtn = [[WJTitleButton alloc] init];
    
    _titleBtn = titleBtn;
        // 获取上一次昵称
    NSString * name = [WJAccountTools unarchiverAccount].name;
    [_titleBtn setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [_titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = _titleBtn;
}
-(void)titleBtnClick:(UIButton *)titleBtn{

    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    //1、 创建下拉菜单
    _menuCover = [WJDropDownMenu dropDownMenu];
    _menuCover.delegate = self;
    
    // 2. 设置内容视图
    WJTitleBtnTableViewController * menuVc = [[WJTitleBtnTableViewController alloc] initWithStyle:UITableViewStylePlain];
    menuVc.view.width = 130;
    menuVc.view.height = 170;
    menuVc.view.backgroundColor = WJRGBAColor(96, 96, 96, 0.4);
    menuVc.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _menuCover.contentController = menuVc;
    
    // 3. 显示视图
   [_menuCover showMenuFrom:titleBtn];
}

-(void)setupNavBarBtns{

    // 添加导航栏按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(addFriendsBtnThouch) image:[UIImage imageNamed:@"navigationbar_friendsearch"] highImage:[UIImage imageNamed:@"navigationbar_friendsearch_highlighted"]];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(searchBtn) image:[UIImage imageNamed:@"navigationbar_pop"] highImage:[UIImage imageNamed:@"navigationbar_pop_highlighted"]];

}
-(void)searchBtn{

    NSLog(@"searchBtn");
}
-(void)addFriendsBtnThouch{

    NSLog(@"click");
}

// status模型转frame模型抽取方法
-(NSArray *)statusFrameWithStatuses:(NSArray *)statuses{

    NSMutableArray * newFrames = [NSMutableArray array];
    for (WJStatusesModel * status in statuses) {
        
        WJStatusFrame * frame = [[WJStatusFrame alloc] init];
        frame.status = status;
        [newFrames addObject:frame];
    }
    return newFrames;
}
#pragma mark - dropDownDelegate
-(void)dropdownMenuDidShow:(WJDropDownMenu *)dropMenu{

    
    NSLog(@"显示成功");
}
-(void)dropdownMenuDidDismiss:(WJDropDownMenu *)dropMenu{

//     //复原标题按钮箭头状态
    [self.titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    NSLog(@"关闭成功");
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statusFrames.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WJStatusTableViewCell * cell = [WJStatusTableViewCell cellWithTableView:tableView];
        // 字典转模型
    cell.statusFrame = self.statusFrames[indexPath.row];
    return cell;
}

// 当tableview滚动到最底部的时候显示tableFooterView 并加载更多数据
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    // 如何tableview 还没有数据的是， 就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell 完全显示在眼前是，conentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) {// 最后一个cell 完成进入视野内
        self.tableView.tableFooterView.hidden = NO;
        // 加载更多微博数据
        [self loadMoreStatus];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    WJStatusFrame * frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}
@end
