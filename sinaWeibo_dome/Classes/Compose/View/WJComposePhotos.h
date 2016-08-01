//
//  WJComposePhotos.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/30.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJComposePhotos : UIView

-(void)addPhoto:(UIImage *)image;
@property (nonatomic,strong,readonly) NSMutableArray * photos;

@end
