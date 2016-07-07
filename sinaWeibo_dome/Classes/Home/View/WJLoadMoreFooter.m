//
//  WJLoadMoreFooter.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/19.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJLoadMoreFooter.h"

@implementation WJLoadMoreFooter

+(instancetype)footer{

    return [[[NSBundle mainBundle] loadNibNamed:@"WJLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
