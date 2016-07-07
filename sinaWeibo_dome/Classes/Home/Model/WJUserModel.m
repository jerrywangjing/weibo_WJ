//
//  WJUserModel.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/9.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJUserModel.h"

@implementation WJUserModel

//-(BOOL)isVip{
//
//    return self.mbrank > 2;
//}

-(void)setMbtype:(int)mbtype{

    _mbrank = mbtype;
    self.vip = mbtype > 2;
}
@end
