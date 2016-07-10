//
//  WJStatusPhotosView.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/9.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJStatusPhotosView.h"
#import "WJPhotoModel.h"
#import "WJPhotoView.h"

@implementation WJStatusPhotosView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

-(void)setPhotos:(NSArray *)photos{

    _photos = photos;
    
    NSInteger photosCount = photos.count;
    // 先判断重用的cell中view是否少于所需的view，差几个view创建几个
    while (self.subviews.count < photosCount) {
        WJPhotoView * photoView = [[WJPhotoView alloc] init];
        
        [self addSubview:photoView];
    }
    
    // 重用cell 中的子控件个数大于所需要的个数时，遍历图片设置值
    for (int i = 0; i<self.subviews.count; i++) {
        WJPhotoView * photoView = self.subviews[i];
        photoView.backgroundColor = [UIColor orangeColor];
        if (i < photosCount) { // 需要显示的图片
            // 图片字典转图片模型
            WJPhotoModel * photoData = [WJPhotoModel mj_objectWithKeyValues:photos[i]];
            photoView.photo = photoData;
            photoView.hidden = NO;
        }else{ // 需要隐藏的图片
        
            photoView.hidden = YES;
        }
    }
    
    
    
}
// 设置子控件frame
-(void)layoutSubviews{

    [super layoutSubviews];
    
    // 设置图片发frame
    
    NSInteger maxCol = HwStatusMaxCol(self.subviews.count);
    NSInteger photoCount = self.photos.count;
    
    for (int i = 0; i<photoCount; i++) {
        WJPhotoView * photo = self.subviews[i];
        NSInteger col  = i % maxCol; // 列号
        NSInteger row = i / maxCol;
        
        photo.x = col * (HWStatusPhotoWH + HWStatusPhotoMargin/2);
        photo.y = row * (HWStatusPhotoWH + HWStatusPhotoMargin/2);
        photo.width = HWStatusPhotoWH;
        photo.height = HWStatusPhotoWH;
    }
    
    
}
@end
