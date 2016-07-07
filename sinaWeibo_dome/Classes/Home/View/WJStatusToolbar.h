//
//  WJStatusToolbar.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/2.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WJStatusesModel;
@interface WJStatusToolbar : UIView

+(instancetype)toolbar;

@property (nonatomic,strong) WJStatusesModel * status;

@end
