//
//  WJStatusFrame.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/25.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJStatusFrame.h"
#import "WJUserModel.h"
#import "WJStatusesModel.h"

@implementation WJStatusFrame

-(void)setStatus:(WJStatusesModel *)status{
    _status = status;
    // cell 的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolbarY;

    /** 原创微博frame计算 */
    // 头像frame
    CGFloat iconWH = 35;
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    // 昵称
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HWStatusCellBorderW;
    CGFloat nameY = iconY +5;
    CGSize nameSize = [status.user.name sizeWithFont:HWStatusCellNameFont];
    self.nameLabelF = CGRectMake(nameX, nameY, nameSize.width, nameSize.height);
    // 会员图标
    if (status.user.isVip) {
        
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + HWStatusCellBorderW/2;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
        
    }
    
    /** 时间 */
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + 2;
    CGSize timeSize = [status.created_at sizeWithFont:HWStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HWStatusCellBorderW/2;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    /** 正文 */
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [status.text sizeWithFont:HWStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图 */
    CGFloat originalH = 0;
    if (status.pic_urls.count) { // 有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        originalH = CGRectGetMaxY(self.photoViewF) + HWStatusCellBorderW;
        
    }else{ // 无配图
    
        originalH = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
    }
   
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = 0;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    toolbarY = originalH; // 无转发时的Y值
    
    
    /* 被转发微博frame计算 */
    
    if (status.retweeted_status) {
        WJStatusesModel *retweeted_status = status.retweeted_status;
        WJUserModel *retweeted_status_user = retweeted_status.user;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = HWStatusCellBorderW;
        CGFloat retweetContentY = HWStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithFont:HWStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) { // 转发微博有配图
            CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotoWH, retweetPhotoWH);
            
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) + HWStatusCellBorderW;
        } else { // 转发微博没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
        }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    }
    // toolbar Frame
    self.toolbarF = CGRectMake(0, toolbarY, cellW, ToolbarHeight);
    // cell 的高度
    self.cellHeight = CGRectGetMaxY(self.toolbarF) +HWStatusCellBorderW;
}

@end
