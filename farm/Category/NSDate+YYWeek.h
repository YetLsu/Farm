//
//  NSDate+YYWeek.h
//  lcjfarm
//
//  Created by wyy on 2016/10/26.
//  Copyright © 2016年 WYY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YYWeek)

/**
 *  返回是今天，昨天或者周几的
 */
- (NSString *)weekDayWithDate:(NSDate *)date;
/**
 *  返回几月几号
 *  格式08-08
 */
- (NSString *)monthDayWithDate:(NSDate *)date;

/**
 返回某天是周几／几月／几日等值

 @param key month/hour/day/等

 @return 具体的值
 */
- (NSString *)todayValueStrWithKeyStr:(NSString *)key andDay:(NSDate *)date;


@end
