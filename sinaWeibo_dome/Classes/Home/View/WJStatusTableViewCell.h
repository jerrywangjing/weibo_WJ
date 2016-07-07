//
//  WJStatusTableViewCell.h
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/25.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WJStatusFrame;

@interface WJStatusTableViewCell : UITableViewCell

@property (nonatomic,strong) WJStatusFrame * statusFrame;

+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
