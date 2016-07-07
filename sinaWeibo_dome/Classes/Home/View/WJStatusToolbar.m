//
//  WJStatusToolbar.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/2.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJStatusToolbar.h"
#import "WJStatusesModel.h"

@interface WJStatusToolbar ()

//这里放置所有按钮
@property (nonatomic,strong) NSMutableArray * btns;
// 这里放置所有的分割线
@property (nonatomic,strong) NSMutableArray * dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;

@end
@implementation WJStatusToolbar

-(NSMutableArray *)btns{

    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
-(NSMutableArray *)dividers{

    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}

+(instancetype)toolbar{

    return [[self alloc] init];
}

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
       self.attitudeBtn = [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        //添加分割线
        
        [self setupLines];
        [self setupLines];
    }
    return self;
}

// 创建分割线

-(void)setupLines{

    //添加分割线
    UIImageView * line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
    [self.dividers addObject:line];
    [self addSubview:line];
}

// 创建按钮封装
-(UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon{

    // 添加按钮
    UIButton * btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [self.btns addObject:btn];
    [self addSubview:btn];
    return btn;
    
}

// 设置按钮frame
-(void)layoutSubviews{

    [super layoutSubviews];
    NSInteger count = self.btns.count;
    CGFloat btnW = self.frame.size.width/count;
    CGFloat btnH = self.height;
    
    for (int i= 0; i<self.subviews.count; i++) {
        UIButton * btn  = self.subviews[i];
        btn.frame = CGRectMake(i*btnW, 0, btnW, btnH);
       
    }
    
    for (int i = 0; i < self.dividers.count; i++) {
        
        UIImageView * line = self.dividers[i];
        
        line.frame = CGRectMake((i+1)*btnW, 0, 1, btnH);
    }
}

// 给控件赋值

-(void)setStatus:(WJStatusesModel *)status{

    _status = status;
    // 转发
        // 这里注意：定义方法的时候尽量吧有代码提示的参数放到前面，把文字字符串放到后面，这样才会有代码提示。
    [self setupBtnCount:status.reposts_count btn:self.repostBtn Title:@"转发"];
    // 评论
    
    [self setupBtnCount:status.comments_count btn:self.commentBtn Title:@"评论"];
    // 赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn Title:@"赞"];
    
    
}
// 按钮赋值方法封装
-(void)setupBtnCount:(NSInteger)count btn:(UIButton *)btn Title:(NSString *)title{

    if (count) {
        
        if (count < 10000) {//数字小于1万时直接显示数字
            NSString * titleCount = [NSString stringWithFormat:@"%ld",count];
            [btn setTitle:titleCount forState:UIControlStateNormal];
        }else{ // 大于一万的情况下，显示以万为单位的数字
        
            double countByWan = count/ 10000.0;
            NSString * titleCount = [NSString stringWithFormat:@"%.1f万",countByWan];
            // 如果是小数点后面是0时，直接去掉
            titleCount = [titleCount stringByReplacingOccurrencesOfString:@".0" withString:@""];
            [btn setTitle:titleCount forState:UIControlStateNormal];
        }
       
    }else{
        
        [btn setTitle:title forState:UIControlStateNormal];
    }

}
@end
