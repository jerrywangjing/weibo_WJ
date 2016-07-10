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

// 设置配图尺寸
-(CGSize)photosSizeWithCount:(NSInteger)count{

    NSInteger maxCols = HwStatusMaxCol(count); // 最大列数
    // 宽度
    NSInteger cols = count >= maxCols ? maxCols : count; //列数
    CGFloat photoW = cols * HWStatusPhotoWH + (cols-1) * HWStatusPhotoMargin;
    // 高度
    NSInteger rows;
//        //方法一：
//    if (count % 3 == 0) { // count 等于 3，6，9的情况
//        rows = count/3;
//    }else { // count 等于 1，2，4，5，7，8
//    
//        rows = count/3 + 1;
//    }
//        // 方法二：
//    rows = count/3;
//    if (count % 3 != 0) {
//        rows += 1;
//    }
        // 方法三：
    /**
     *  @param 3 最大行数
     */
    rows = (count + maxCols -1) / maxCols; // 固定公式
    /**
     这个公式也可以计算多条数据可以显示多少页
     pages = (count + pageSize -1) / pageSize;
     */
    
    CGFloat photoH = rows * HWStatusPhotoWH + (rows -1)* HWStatusPhotoMargin;
    
    
    return CGSizeMake(photoW, photoH);
}

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
        //CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + HWStatusCellBorderW;
        CGSize photoSize = [self photosSizeWithCount:status.pic_urls.count];
        self.photosViewF = CGRectMake(photoX, photoY, photoSize.width,photoSize.height);
        originalH = CGRectGetMaxY(self.photosViewF) + HWStatusCellBorderW;
        
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
            //CGFloat retweetPhotoWH = 100;
            CGFloat retweetPhotoX = retweetContentX;
            CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + HWStatusCellBorderW;
            
            CGSize retweetPhotosSize = [self photosSizeWithCount:retweeted_status.pic_urls.count];
            
            self.retweetPhotoViewF = CGRectMake(retweetPhotoX, retweetPhotoY, retweetPhotosSize.width, retweetPhotosSize.height);
            
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
