//
//  WJPhotoView.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/10.
//  Copyright © 2016年 JerryWang. All rights reserved.
//   代表一张配图

#import <UIKit/UIKit.h>
@class WJPhotoModel;
@interface WJPhotoView : UIImageView
@property (nonatomic,strong) WJPhotoModel * photo;

@end
