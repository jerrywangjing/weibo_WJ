//
//  WJComposeToolbar.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/24.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WJComposeToolbarButtonTypeCamera, //拍照
    WJComposeToolbarButtonTypePicture, // 相册
    WJComposeToolbarButtonTypeMention, //@
    WJComposeToolbarButtonTypeTrend, // #
    WJComposeToolbarButtonTypeEmotion, // 表情
    
}WJComposeToolbarButtonType;

@class  WJComposeToolbar;
@protocol WJComposeToolbarDelegate <NSObject>
@optional
-(void)composeToolbar:(WJComposeToolbar *) toolbar didClickButton:(WJComposeToolbarButtonType)btnType;

@end
@interface WJComposeToolbar : UIView

@property (nonatomic,weak) id<WJComposeToolbarDelegate> delegate;

@end
