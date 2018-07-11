//
//  NSDate+NPExtension.m
//  Alpha
//
//  Created by LiLe on 2017/8/1.
//  Copyright © 2017年 Alpha. All rights reserved.
//

#import "NSDate+NPExtension.h"
#import "CustomDateFormatter.h"

#define SECOND 1
#define MINUTE (60 * SECOND)
#define HOUR (60 * MINUTE)
#define DAY (24 * HOUR)
#define WEEK (7 * DAY)

/// 一天的总秒数
static NSTimeInterval secondsPerDay = 24*3600;

@implementation NSDate (NPExtension)

- (BOOL)isThisYear
{
    NSCalendar *calendar = [CustomDateFormatter beijingCalendar];
    
    // 获得年
    NSInteger nowYear = [calendar component:NSCalendarUnitYear fromDate:[NSDate date]];
    NSInteger selfYear = [calendar component:NSCalendarUnitYear fromDate:self];
    
    return nowYear == selfYear;
}

- (BOOL)isToday
{
    return [self __isSpecialDayWithSpecialDate:[NSDate date]];
}

- (BOOL)isYesterday
{
    return [self __isSpecialDayWithSpecialDate:[NSDate dateWithTimeInterval:-secondsPerDay sinceDate:[NSDate date]]];
}

- (BOOL)isDayBeforeYesterday
{
    return [self __isSpecialDayWithSpecialDate:[NSDate dateWithTimeInterval:-secondsPerDay*2 sinceDate:[NSDate date]]];
}

- (BOOL)isTomorrow
{
    return [self __isSpecialDayWithSpecialDate:[NSDate dateWithTimeInterval:secondsPerDay sinceDate:[NSDate date]]];
}

- (BOOL)isWithinOneWeek
{
    NSDate *nowDate = [NSDate date];
    return [nowDate timeIntervalSinceDate:self] < 7 * secondsPerDay;
}

/**
 * 是否为某一天
 * daysInterval : 距离今天的间隔数
 */
- (BOOL)isDayDaysInterval:(NSInteger)daysInterval
{
    return [self __isSpecialDayWithSpecialDate:[NSDate dateWithTimeInterval:-secondsPerDay*daysInterval sinceDate:[NSDate date]]];
}

- (BOOL)isSameWeekWithWeekBeginDate:(NSDate *)date
{
    NSTimeInterval beginInterval = [date timeIntervalSince1970];
    NSTimeInterval endInterval = beginInterval+WEEK;
    NSTimeInterval dateInterval = [self timeIntervalSince1970];
    if (beginInterval <= dateInterval && dateInterval < endInterval) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDate *)hourlyDate {
    //获取当年的月份，当月的总天数
    NSCalendar * calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents * components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:self];
    
    NSDateComponents * newcomponents = [[NSDateComponents alloc] init];
    
    newcomponents.year = components.year;
    
    newcomponents.month = components.month;
    
    newcomponents.day = components.day;
    
    newcomponents.hour = components.hour;
    
    NSDate * newdate = [calendar dateFromComponents:newcomponents];
    
    return newdate;
}

- (NSDate *)specialDateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:self];
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    return [calendar dateFromComponents:components];
}

- (NSDate *)marginDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second
{
    NSCalendar *calender = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *adcomps = [[NSDateComponents alloc] init];
    [adcomps setYear:year];
    [adcomps setMonth:month];
    [adcomps setDay:day];
    [adcomps setHour:hour];
    [adcomps setMinute:minute];
    [adcomps setSecond:second];
    
    NSDate *newdate = [calender dateByAddingComponents:adcomps toDate:self options:0];
    return newdate;
}

- (NSDate *)nextMonthDate
{
    return [self gapMonthDate:1];
}

- (NSDate *)gapMonthDate:(NSInteger)gapMonthCount {
    //获取当年的月份，当月的总天数
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitCalendar fromDate:self];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    //    [formatter setTimeZone:[NSTimeZone localTimeZone]];
    //    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    
    NSString *dateStr = @"";
    NSInteger endDay = 0;//天
    NSDate *newDate = [NSDate date];//新的年&月
    //判断是否是下一年
    if (components.month+gapMonthCount > 12) {
        //是下一年
        dateStr = [NSString stringWithFormat:@"%zd-%zd-01",components.year+(components.month+gapMonthCount)/12,(components.month+gapMonthCount)%12];
        newDate = [formatter dateFromString:dateStr];
        //新月份的天数
        NSInteger newDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
        if ([self isEndOfTheMonth:self]) {//当前日期处于月末
            endDay = newDays;
        } else {
            endDay = newDays < components.day?newDays:components.day;
        }
        dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",components.year+(components.month+gapMonthCount)/12,(components.month+gapMonthCount)%12,endDay];
    } else {
        //依然是当前年份
        dateStr = [NSString stringWithFormat:@"%zd-%zd-01",components.year,components.month+gapMonthCount];
        newDate = [formatter dateFromString:dateStr];
        //新月份的天数
        NSInteger newDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
        if ([self isEndOfTheMonth:self]) {//当前日期处于月末
            endDay = newDays;
        } else {
            endDay = newDays < components.day?newDays:components.day;
        }
        
        dateStr = [NSString stringWithFormat:@"%zd-%zd-%zd",components.year,components.month+gapMonthCount,endDay];
    }
    
    newDate = [formatter dateFromString:dateStr];
    return newDate;
}

//判断是否是月末
- (BOOL)isEndOfTheMonth:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger daysInMonth = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
    NSDateComponents *componets = [calendar components:NSCalendarUnitDay fromDate:date];
    if (componets.day >= daysInMonth) {
        return YES;
    }
    return NO;
}

-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withMonth:(int)month
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setMonth:month];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];    
    return mDate;
}

-(NSDate *)getPriousorLaterDateFromDate:(NSDate *)date withDay:(int)day
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:day];
    
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDate *mDate = [calender dateByAddingComponents:comps toDate:date options:0];
    return mDate;
}

// 获取当月的天数
- (NSInteger)getNumberOfDaysInMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay
                                   inUnit: NSCalendarUnitMonth
                                  forDate:self];
    return range.length;
}

#pragma mark -- private method
/**
 是否是同一年中特殊的某一天
 
 @param specialDate 特殊日期的date
 @return 是返回YES，不是返回NO
 */
- (BOOL)__isSpecialDayWithSpecialDate:(NSDate *)specialDate
{
    NSCalendar *calendar = [CustomDateFormatter beijingCalendar];
    NSCalendarUnit unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *specialCmp = [calendar components:unit fromDate:specialDate];
    NSDateComponents *dateCmp = [calendar components:unit fromDate:self];
    return specialCmp.year == dateCmp.year && specialCmp.month == dateCmp.month && specialCmp.day == dateCmp.day;
}

- (NSInteger)year {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [components year];
}
- (NSInteger)month {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [components month];
}
- (NSInteger)day {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [components day];
    
}
- (NSInteger)hour {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:self];
    return [components hour];
    
}
- (NSInteger)minute {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self];
    return [components minute];
}

@end
