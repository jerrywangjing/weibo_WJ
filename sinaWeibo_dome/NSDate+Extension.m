//
//  NSDate+Extension.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/7/4.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

// 判断是否今年
-(BOOL)isThisYear{
    
    NSCalendar * calendar = [NSCalendar currentCalendar];//当前日期
    // 获取的某个时间的年月日时分秒
    NSDateComponents * dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents * nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]]; // 当前时间
    
    return dateCmps.year == nowCmps.year;
}
// 判断是否昨天
-(BOOL)isYestoday{
    
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [fmt stringFromDate:self];
    NSString * nowStr = [fmt stringFromDate:[NSDate date]];
    
    // 转为只有年月日的日期
    
    NSDate * creatDate = [fmt dateFromString:dateStr];
    NSDate * now = [fmt dateFromString:nowStr];
    
    NSCalendar * calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear|NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents * cmpts = [calendar components:unit fromDate:creatDate toDate:now options:0];
    
    return cmpts.year ==0 && cmpts.month == 0 && cmpts.day == 1 ;
}
// 判断是否今天
-(BOOL)isToday{
    
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString * dateStr = [fmt stringFromDate:self];
    NSString * nowStr = [fmt stringFromDate:[NSDate date]];
    
    return [dateStr isEqualToString:nowStr];
}

@end
