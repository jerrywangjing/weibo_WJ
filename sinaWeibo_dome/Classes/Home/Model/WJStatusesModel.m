//
//  WJStatusesModel.m
//  sinaWeibo_dome
//
//  Created by JerryWang on 16/6/9.
//  Copyright © 2016年 JerryWang. All rights reserved.
//

#import "WJStatusesModel.h"
#import "WJPhotoModel.h"

@implementation WJStatusesModel

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [WJPhotoModel class]};
}

// 格式化创建时间
-(NSString *)created_at{

    // Thu Oct 16 17:06:25  +0800 2016
    // EEE MMM dd HH:mm:ss  Z     yyyy  对应的日期表述符号
    // 星期几 月份 几号  小时(24小时制) 分 秒  时区  年份
    NSDateFormatter * fmt = [[NSDateFormatter alloc] init];
    //如果是真机调试，转换这种欧美时间，需要设置 locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    // 声明字符串中每个数字的含义
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    // 微博的创建时间
    NSDate * createDate = [fmt dateFromString:_created_at];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 当前时间
    NSDate * now = [NSDate date];
    // 日历对象(方便比较两个日期直接的差距)
    NSCalendar * calendar = [NSCalendar currentCalendar];
    // 添加精确度
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 获得2个时间之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    // 获得某个时间的单个年月日时分秒的值
   // NSDateComponents * createDate = [calendar components:unit fromDate:createDate];

    if ([createDate isThisYear]) { // 今年
        if ([createDate isYestoday]) { // 昨天
            fmt.dateFormat = @"昨天 HH：mm";
            return [fmt stringFromDate:createDate];
        }else if ([createDate isToday]){ // 今天
            if (cmps.hour >= 1) { //1小时前
                return [NSString stringWithFormat:@"%ld小时前",cmps.hour];
            }else if (cmps.minute >= 1){
            
                return [NSString stringWithFormat:@"%ld分钟前",cmps.minute];
            }else{
            
                return @"刚刚";
            }
            
        }else{ // 今年的其他日子
        
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
        
    }else{ // 非今年
    
        fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [fmt stringFromDate:createDate];
    }
    
    return [fmt stringFromDate:createDate];
}
// 设置微博数据来源
-(void)setSource:(NSString *)source{
    // 通过字符串截取获取来源信息
    // <a href="http://app.weibo.com/t/feed/6vtZb0" rel="nofollow">微博 weibo.com</a>
    
    /**
     *  注意：由于每条返回的微博数据中有些来源数据是空的，所以要在这里做判断如果某条来源数据空(无来源信息)则直接返回。否则会运行时错误，range的值变为64位最大值。
     */
    if ([source isEqualToString:@""]) return;

    
    
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
}
@end
