//
//  NSDate+NPExtension.h
//  Alpha
//
//  Created by LiLe on 2017/8/1.
//  Copyright © 2017年 Alpha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (NPExtension)

/**
 * 是否为今年
 */
- (BOOL)isThisYear;

/**
 * 是否为今天
 */
- (BOOL)isToday;

/**
 * 是否为昨天
 */
- (BOOL)isYesterday;

/**
 * 是否为前天
 */
- (BOOL)isDayBeforeYesterday;

/**
 * 是否为明天
 */
- (BOOL)isTomorrow;

/**
 * 是否为一星期内
 */
- (BOOL)isWithinOneWeek;

/**
 * 是否为某一天
 * daysInterval : 距离今天的间隔数
 */
- (BOOL)isDayDaysInterval:(NSInteger)daysInterval;

/**
 判断某一天是否在某一星期中

 @param date 某一星期的开始时间
 @return 在为真，否则为假
 */
- (BOOL)isSameWeekWithWeekBeginDate:(NSDate *)date;
/**
 获取某个日期的整点 2018年10月 4日 11：00
 @param date 需要处理的时间
 */
- (NSDate *)hourlyDate;
/**
 获取某一天特殊的时间点

 @param hour 特殊的小时
 @param minute 特殊的分钟
 @param second 特殊的秒
 */
- (NSDate *)specialDateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/**
 获取间隔时间的时间：传入负数表示之前，正数表示之后，0表示不加不减

 @param year 间隔的年
 @param month 间隔的月
 @param day 间隔的天
 @param hour 间隔的小时
 @param minute 间隔的分钟
 @param second 间隔的秒
 */
- (NSDate *)marginDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

- (NSDate *)nextMonthDate;
- (NSDate *)gapMonthDate:(NSInteger)gapMonthCount;
- (BOOL)isEndOfTheMonth:(NSDate *)date;
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month;
- (NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day;
- (NSInteger)getNumberOfDaysInMonth;


- (NSInteger)year;
- (NSInteger)month;
- (NSInteger)day;
- (NSInteger)hour;
- (NSInteger)minute;
@end
