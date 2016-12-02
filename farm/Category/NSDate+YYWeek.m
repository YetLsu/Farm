//
//  NSDate+YYWeek.m
//  lcjfarm
//
//  Created by wyy on 2016/10/26.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import "NSDate+YYWeek.h"
#import <objc/runtime.h>  



static char dateCalendar;

@implementation NSDate (YYWeek)
- (NSCalendar *)calendar{
    
    NSCalendar *calendar = objc_getAssociatedObject(self, &dateCalendar);
    if (!calendar) {
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
        calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    }
    return calendar;
}
/**
 获取当前准确的时间
 */
- (NSDate *)nowDate{
    NSDate *date = [NSDate date]; // 获得时间对象
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone]; // 获得系统的时区
//    YYLog(@"%@", zone);
    
    NSTimeInterval time = [zone secondsFromGMTForDate:date];// 以秒为单位返回当前时间与系统格林尼治时间的差
    
    NSDate *dateNow = [date dateByAddingTimeInterval:time];// 然后把差的时间加上,就是当前系统准确的时间
    return dateNow;
}
/**
 *  返回几月几号
 *  格式08-08
 */
- (NSString *)monthDayWithDate:(NSDate *)date{
    NSString *dayStr = [self weekDayWithDate:date];
    NSDateComponents *dateComponents = [self dateComponentsWithDate:date];
    if ([dayStr isEqualToString:@"今天"] || [dayStr isEqualToString:@"昨天"]) {
        return [NSString stringWithFormat:@"%02ld:%02ld", [dateComponents hour], [dateComponents minute]];
    }
    
    NSInteger month = [dateComponents month];
    NSInteger day = [dateComponents day];

//    YYLog(@"%@\n时区：%@\n month:%ld\nday:%ld hour:%ld\n min:%ld",date, [dateComponents timeZone], [dateComponents month], [dateComponents day], [dateComponents hour], [dateComponents minute]);
    
    return [NSString stringWithFormat:@"%02ld-%02ld",(long)month, (long)day];
}

- (NSDateComponents *)dateComponentsWithDate:(NSDate *)date{
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitTimeZone;
    
    return [[self calendar] components:unitFlags fromDate:date];
    
/**
 days 距离今天的天数， 正数表示以后，负数表示以前
 @return 返回关于基于现在几天前或者几天后的日期类
 */
}
- (NSDateComponents *)dateComponentsWithDays:(NSInteger)days{
 
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:days*60*60*24];
    
    return [self dateComponentsWithDate:date];
}
/**
 *  返回是今天，昨天或者周几的
 */
- (NSString *)weekDayWithDate:(NSDate *)date{
    //先判断是否是昨天的或者今天的
    NSDate *nowDate = [NSDate date];
    //今天
    NSDateComponents *todayComps = [self dateComponentsWithDate:nowDate];
    //昨天
    NSDateComponents *yesterdayComps = [self dateComponentsWithDays:-1];
//    YYLog(@"%@\n时区：%@\n month:%ld\nday:%ld hour:%ld\n min:%ld",nowDate, [yesterdayComps timeZone], [yesterdayComps month], [yesterdayComps day], [yesterdayComps hour], [yesterdayComps minute]);
    
    NSDateComponents *comps = [self dateComponentsWithDate:date];
    
    
    if ([todayComps month] == [comps month] && [todayComps day] == [comps day]) {
        return @"今天";
    }
    else if ([yesterdayComps month] == [comps month] && [yesterdayComps day] == [comps day]){
        return @"昨天";
    }
    
    
    NSInteger week = [comps weekday];
    switch (week) {
        case 1:
            return @"周日";
            break;
        case 2:
            return @"周一";
            break;
        case 3:
            return @"周二";
            break;
        case 4:
            return @"周三";
            break;
        case 5:
            return @"周四";
            break;
        case 6:
            return @"周五";
            break;
        case 7:
            return @"周六";
            break;
            
        default:
            break;
    }
    return nil;
}

// 获取当前是星期几
- (NSInteger)getNowWeekday {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDate *now = [self nowDate];
    // 话说在真机上需要设置区域，才能正确获取本地日期，天朝代码:zh_CN
    calendar.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    comps = [calendar components:unitFlags fromDate:now];
    return [comps weekday];
}

/**
 返回某天是周几／几月／几日等值
 
 @param key month/hour/day/等
 
 @return 具体的值
 */
- (NSString *)todayValueStrWithKeyStr:(NSString *)key andDay:(NSDate *)date{
    NSDateComponents *dateComponents = [self dateComponentsWithDate:date];
//    NSInteger day = [dateComponents day];
//    NSInteger month = [dateComponents month];
//    NSInteger hour = [dateComponents hour];
//    NSInteger minute = [dateComponents minute];
//    YYLog(@"day:%ld\n month:%ld\n hour:%ld\n minute:%ld\n", day, month, hour, minute);
    
    return [dateComponents valueForKeyPath:key];
    
}
@end
