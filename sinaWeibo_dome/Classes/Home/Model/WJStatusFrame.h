//
//  WJStatusFrame.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/25.
//  Copyright © 2016年 JerryWang. All rights reserved.
//****************************************
// 一个statusFrame模型里面包含的信息
/**
 1.存放着一个cell内部所有子控件的frame 数据
 2. 存放一个cell 的高度
 3.存放着一个数据模型WJStatus
 */

#import <Foundation/Foundation.h>

//昵称字体
#define HWStatusCellNameFont [UIFont systemFontOfSize:13]
// 时间字体
#define HWStatusCellTimeFont [UIFont systemFontOfSize:10]
// 来源字体
#define HWStatusCellSourceFont HWStatusCellTimeFont
// 正文字体
#define HWStatusCellContentFont [UIFont systemFontOfSize:14]
// 被转发微博的正文字体
#define HWStatusCellRetweetContentFont [UIFont systemFontOfSize:13]
// 工具栏高度
#define ToolbarHeight 30
#define HWStatusCellBorderW 10 //  cell 的边框宽高

@class WJStatusesModel;
@interface WJStatusFrame : NSObject

@property (nonatomic,strong) WJStatusesModel * status;
/** 原创微博整体 */

@property (nonatomic,assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic,assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic,assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic,assign) CGRect photosViewF;
/** 会员名称 */
@property (nonatomic,assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic,assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic,assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign) CGRect contentLabelF;


/** 转发微博整体 */

/** 转发微博整体*/
@property (nonatomic,assign)  CGRect retweetViewF;
/** 转发微博正文和昵称*/
@property (nonatomic,assign) CGRect retweetContentLabelF;
/** 转发配图 */
@property (nonatomic,assign) CGRect retweetPhotoViewF;
/** 工具条 */
@property (nonatomic,assign) CGRect toolbarF;

/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

@end
