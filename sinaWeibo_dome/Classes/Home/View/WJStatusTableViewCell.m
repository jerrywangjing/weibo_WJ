//
//  WJStatusTableViewCell.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/25.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJStatusTableViewCell.h"
#import "WJStatusFrame.h"
#import "WJStatusesModel.h"
#import "UIImageView+WebCache.h"
#import "WJUserModel.h"
#import "WJPhotoModel.h"
#import "WJStatusToolbar.h"
#import "WJStatusPhotosView.h"

#define TimeAndSourseColor WJRGBColor(172, 172, 172)

@interface WJStatusTableViewCell ()

/* 原创微博子控件 */

/** 原创微博整体 */
@property (nonatomic,weak) UIView * originalView;
/** 头像 */
@property (nonatomic,weak) UIImageView * iconView;
/** 会员图标 */
@property (nonatomic,weak) UIImageView * vipView;
/** 配图 */
@property (nonatomic,weak) WJStatusPhotosView * photosView;
/** 会员名称 */
@property (nonatomic,weak) UILabel * nameLabel;
/** 时间 */
@property (nonatomic,weak) UILabel * timeLabel;
/** 来源 */
@property (nonatomic,weak) UILabel * sourceLabel;
/** 正文 */
@property (nonatomic,weak) UILabel * contentLabel;

/* 转发微博 */

/** 转发微博整体*/
@property (nonatomic,weak)  UIView * retweetView;
/** 转发微博正文和昵称*/
@property (nonatomic,strong) UILabel * retweetContentLabel;
/** 转发配图 */
@property (nonatomic,weak) WJStatusPhotosView * retweetPhotosView;
/** 工具条 */
@property (nonatomic,weak) WJStatusToolbar * toolbar;

@end
@implementation WJStatusTableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView{

     static NSString * ID = @"status";
    WJStatusTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WJStatusTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}
/**
 *  cell 的初始化方法，一个cell只会调用一次
 一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        // 点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        // 初始化原创微博
        [self setupOriginal];
        // 初始化转发微博
        [self setupRetweet];
        // 初始化工具条
        [self setupToolbar];
    }
    
    return self;
}

/**
 *  初始化原创微博
 */

-(void)setupOriginal{

    // 1.原创微博的整体
    UIView * originalView = [[UIView alloc] init];
    originalView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    /** 头像 */
    UIImageView * iconView = [[UIImageView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    // 给头像添加圆角
    self.iconView.layer.cornerRadius = 18;
    self.iconView.layer.masksToBounds = YES;
    
    /** 会员图标 */
    UIImageView * vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    /** 配图 */
    WJStatusPhotosView * photosView = [[WJStatusPhotosView alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    /** 会员名称 */
    UILabel * nameLabel = [[UILabel alloc] init];
    [originalView addSubview:nameLabel];
    nameLabel.font = HWStatusCellNameFont;
    self.nameLabel = nameLabel;
    /** 时间 */
    UILabel * timeLabel = [[UILabel alloc] init];
    [originalView addSubview:timeLabel];
    timeLabel.font = HWStatusCellTimeFont;
    timeLabel.textColor = TimeAndSourseColor;
    self.timeLabel = timeLabel;
    /** 来源 */
    UILabel * sourceLabel = [[UILabel alloc] init];
    [originalView addSubview:sourceLabel];
    sourceLabel.font = HWStatusCellSourceFont;
    sourceLabel.textColor = TimeAndSourseColor;
    self.sourceLabel = sourceLabel;
    /** 正文 */
    UILabel * contentLabel = [[UILabel alloc] init];
    [originalView addSubview:contentLabel];
    contentLabel.font = HWStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    self.contentLabel = contentLabel;

}

/**
 *  初始化转发微博
 */

-(void)setupRetweet{

    //转发微博整体
    UIView * retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = WJRGBColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    //转发微博正文
    
    UILabel * retweetContentLabel = [[UILabel alloc] init];
    [retweetView addSubview:retweetContentLabel];
    retweetContentLabel.font = HWStatusCellRetweetContentFont;
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.textColor = WJRGBColor(99, 99, 99);
    self.retweetContentLabel = retweetContentLabel;
    // 转发微博配图
    
    WJStatusPhotosView * iconView = [[WJStatusPhotosView alloc] init];
    [retweetView addSubview:iconView];
    self.retweetPhotosView = iconView;
    
}

/**
 *  初始化toolbar
 */

-(void)setupToolbar{

    WJStatusToolbar * toolbar = [WJStatusToolbar toolbar];
    self.toolbar = toolbar;
    [self.contentView addSubview:toolbar];
}
// 设置cell子控件frame
-(void)setStatusFrame:(WJStatusFrame *)statusFrame{

    _statusFrame = statusFrame;
    
    WJStatusesModel * status = statusFrame.status;

    WJUserModel * user = status.user;
    
    // 1.原创微博的整体
    self.originalView.frame = statusFrame.originalViewF;
    /** 头像 */
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    /** 会员图标 */
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString * vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
        //self.vipView.image = [UIImage imageNamed:@"common_icon_membership_expired"];
    }
   
    /** 配图 */
    if (status.pic_urls.count) { // 有配图
        
        self.photosView.frame = statusFrame.photosViewF;
        
        self.photosView.photos = status.pic_urls;

        self.photosView.hidden = NO;
    }else{ // 无配图
        self.photosView.hidden = YES;
        
    }
    
    
    /** 会员名称 */
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;
    
    // 当cell滚动时重新计算时间和来源frame
    
    /** 时间 */
    NSString * time = status.created_at; // 为了先获取一次时间
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + 2;
    CGSize timeSize = [statusFrame.status.created_at sizeWithFont:HWStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HWStatusCellBorderW/2;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    
    /** 正文 */
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    self.contentLabel.text = status.text;
    
    /** 被转发的微博*/
    
    if (status.retweeted_status) { // 有转发微博
        WJStatusesModel * retweet_status = status.retweeted_status;
        WJUserModel * retweet_user = retweet_status.user;
        
        self.retweetView.hidden = NO;
        // 转发微博整体
        self.retweetView.frame = statusFrame.retweetViewF;
        // 转发微博名称
        
        NSString * retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweet_user.name,retweet_status.text];
        
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        self.retweetContentLabel.text = retweetContent;
        
        // 转发微博配图
    if (retweet_status.pic_urls.count) { // 有配图
        self.retweetPhotosView.frame = statusFrame.retweetPhotoViewF;
        self.retweetPhotosView.photos = retweet_status.pic_urls;
        self.retweetPhotosView.hidden = NO;
    }else{
    
        self.retweetPhotosView.hidden = YES;
    }
    
    }else{
    
        self.retweetView.hidden = YES;
    }
    
    //toolbar frame
    
    self.toolbar.frame = statusFrame.toolbarF;
    // 给toolbar数据模型赋值
    self.toolbar.status = status;
}

@end
