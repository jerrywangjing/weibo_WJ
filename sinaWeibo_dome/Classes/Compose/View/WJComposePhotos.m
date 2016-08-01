//
//  WJComposePhotos.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/30.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJComposePhotos.h"

@implementation WJComposePhotos

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;
}

-(void)addPhoto:(UIImage *)image{

    UIImageView * photoView = [[UIImageView alloc] initWithImage:image];
    [self.photos addObject:photoView];
    [self addSubview:photoView];

}
// 布局图片位置
-(void)layoutSubviews{

    [super layoutSubviews];
    NSUInteger count = self.subviews.count;
    NSInteger maxCol = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 5;
    
    for (int i = 0; i<count; i++) {
        UIImageView * photoView = self.subviews[i];
        NSInteger col = i % maxCol;
        NSInteger row = i / maxCol;
        photoView.x = col * (imageWH + imageMargin);
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;
        
    }
}

@end
