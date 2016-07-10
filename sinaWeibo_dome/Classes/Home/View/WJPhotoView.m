//
//  WJPhotoView.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/10.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJPhotoView.h"
#import "WJPhotoModel.h"

@interface WJPhotoView ()
@property (nonatomic,weak) UIImageView * gifView;

@end
@implementation WJPhotoView

-(UIImageView *)gifView{

    if (!_gifView) {
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        _gifView = gifView;
        [self addSubview:gifView];
    }
    return _gifView;
}

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        /**经验规律：
        1.凡是带有Scale单词的，图片都会拉伸
        2.凡是带有Aspect单词的，图片都会保持原来的宽高比，图片不会变形
        3.fill 填充整个imageView
        4.fit  图片调整到适当的位置
        */
        
        
        // 内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        // 超出边框的内容剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)setPhoto:(WJPhotoModel *)photo{

    _photo = photo;
    // 设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    // 判断是否以gif或者GIF结尾
    // lowercaseString 忽略大小写
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
    
}
@end
