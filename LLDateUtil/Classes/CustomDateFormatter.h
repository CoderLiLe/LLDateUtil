//
//  CustomDateFormatter.h
//  Kecheng
//
//  Created by lvdongdong on 12/7/12.
//  Copyright (c) 2012 CreatingEV. All rights reserved.
//

#import <Foundation/Foundation.h>

//中文年月日
#define yyyyMd @"yyyy年M月d日"

@interface CustomDateFormatter : NSDateFormatter
- (void)setCombinedMode;
- (void)setDateAndWeekShow;//样式为 2012年12月6号 星期五
- (void)setWeekShow;//样式为 星期五
- (void)setAMOrPMAndTimeShow;//样式为 上午 11：08
- (void)setOnlyDateShow;//样式为：13:01:02
- (void)setonlyTimeShow;//样式为：11:52
- (void)setHourShow;
- (void)setMinutesShow;
- (void)setYYYY_MM_dd_show;//样式为：2013-01-27
- (void)setYY_MM_dd_Week_show;//样式为：13年1月27日 星期二
- (void)setYY_MM_dd_HH_mm_show;//样式为：13年1月27日 星期二 23:11
- (void)setYYYY_MM_dd_HH_mm_show; //样式为：2013-07-16 10：54
- (void)setYYYY_MM_dd_HH_mm_ss_show;//样式为：2013-07-16 10:54:23
+(BOOL)containsSpecailTime:(NSDate *)date;
+(NSDate *)dateByRemoveSpecailTime:(NSDate *)date;
- (NSString *)dateTransformToStar:(NSDate *)date;//根据日期得到星座


/**
 标准日期显示格式

 @param date 要被格式化的日期
 @param joint 连接符，"-"或"/" 如果为nil则是汉字“日月年”
 @return 格式化后的字符串
 */
- (NSString *)standardTimeFormatWithDate:(NSDate *)date joint:(NSString *)joint;
+ (NSString *)standardTimeFormatWithDate:(NSDate *)date joint:(NSString *)joint;

+ (NSString *)dateListStringFromInterval:(NSTimeInterval)interval;
+ (NSString *)dateDetailDateStringFromInterval:(NSTimeInterval)interval;

+ (NSString *)relativeWholeDateStringFromDate:(NSDate *)date;
+ (NSString *)relativeWholeDateStringFromInterval:(NSTimeInterval)interval;


+ (NSTimeInterval)timeIntervalFrom:(NSString *)dateString format:(NSString *)fmt;

+ (NSDate *)getMidNightDateOfDate:(NSDate *)date;

+ (NSString *)getStringMonthBeginDateOfDate:(NSDate *)date;
+ (NSString *)getStringMonthEndDateOfDate:(NSDate *)date;

+ (NSDate *)getMonthBeginDateOfDate:(NSDate *)date;

+ (NSString *)getStringDayBeginDateOfDate:(NSDate *)date;
+ (NSDate *)getBeginDateOfDate:(NSDate *)date;
+ (NSString *)getStringDayEndDateOfDate:(NSDate *)date;

+ (NSString *)timeDisplayStringWithEndTime:(NSTimeInterval)endTime;

+ (NSString *)dateTimeStringWithDate:(NSDate *)date;

+ (NSString *)getCurrentDateFullTime;
+ (NSString *)getCurrentDateNextFullTime;
+ (NSString *)getNextHourTime:(NSDate *)date;

+ (NSString *)yMdByDate:(NSDate *)date;
+ (NSString *)hsByDate:(NSDate *)date;
+ (NSDate *)dateFormyMdString:(NSString *)s;
+ (NSDate *)dateFromString:(NSString *)date format:(NSString *)fmt;

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)fmt;
+ (NSString *)stringFromInterval:(NSTimeInterval)interval format:(NSString *)fmt;

+ (NSString *)dayIntervalByCurrentDay:(NSDate *)date days:(NSInteger)days format:(NSString *)format;

+ (NSInteger)getWeekNumberOfDate:(NSDate *)date;
//当前时间往后多少年的时间
+ (NSDate *)curentDateLateDateWithYears:(NSUInteger)years;

+ (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isMoreInOneDaysThan:(NSDate *)dateB;
+ (BOOL)date:(NSDate *)dateA isMoreInThreeDaysThan:(NSDate *)dateB;

//00:00 
+ (NSString *)timeToMinuteStringBySeconds:(NSTimeInterval)seconds;

/**
 显示小时和分钟数，格式如 00:00，123:23

 @param seconds 待转化时间的总秒数
 @param maxHour 最大显示的小时数，如果超过该值，则显示 maxHour+，如 9999+
 @note  1、0 <= h < 1000 ===> h:s
        2、1000 <= h <= maxHour ===> h
        3、h > maxHour ===> maxHour+
 @return 格式化后的时分字符串
 */
+ (NSString *)hoursMinutesStringWithSeconds:(NSTimeInterval)seconds maxHour:(NSInteger)maxHour;

// 00:00:00
+ (NSString *)getHHMMSSWithSeconds:(NSTimeInterval)seconds;
// 32:4 ==> 32:04
+ (NSString *)getHHMMStringWithTime:(NSTimeInterval)timeInterval;
//00:00:00
+ (NSString *)timeToSecondStringBySeconds:(NSTimeInterval)seconds;

//00:00
+ (NSInteger)minsByTimeString:(NSString *)timeStr;

//00:00:00
+ (NSInteger)secondsByTimeString:(NSString *)timeStr;

// 返回类似“今天”，“明天”， “昨天”， “XX月XX日”， “XXXX年XX月XX日”
+ (NSString *)dateToStringWithDateStr:(NSString *)dateStr;
/// 判断是否是今年
+ (BOOL)isCurrentYearWithYYYYMMDD:(NSString *)yyyymmdd;
/// 判断是否是今年
+ (BOOL)isCurrentYearWithDate:(NSDate *)date;

+ (NSDate *)today;
/// 判断是否是今天
+ (BOOL)isTodayWithDate:(NSDate *)date;
+ (NSDate *)todayWithFormatYYMMDDHH;

+ (BOOL)rangeNowWithTime:(NSTimeInterval)interval within:(NSTimeInterval)distance;

+ (NSDate *)getTodayNineTime;

+ (NSDate *)getNineOClockWithDate:(NSDate *)date;

//23:59:59
+ (NSDate *)getFullToday:(NSDate *)date;

// 获取当日特定时间的date
+ (NSDate *)getTodaySpecialHour:(NSInteger)hour minute:(NSInteger)minute;

/// 获取某年某月的第一天凌晨零点零时零分零秒的NSDate
+ (NSDate *)getDateWithYear:(NSInteger)year month:(NSInteger)month;

/// 获取特定时间那一天凌晨零点零时零分零秒的时间戳
+ (NSTimeInterval)getBeginIntervalWithDate:(NSDate *)date;

// 将东八区的时间转为格林尼治时间
+ (NSDate *)transformDateToGMDate:(NSDate *)date;

+ (NSString *)beginAndEndDateStrWithBeginDate:(NSDate *)beginDate;

/// 获取以北京时间为标准的日历
+ (NSCalendar *)beijingCalendar;

/// 返回几天前：1天前-5天前显示x天前，5天之前的显示具体日期
+ (NSString *)daysIntervalStringWithStr:(NSString *)str foratter:(NSString *)formatter;
/// 返回几天前：1天前-5天前显示x天前，5天之前的显示具体日期
+ (NSString *)daysIntervalStringWithDate:(NSDate *)date foratter:(NSString *)formatter;

/// 返回具体的时间，只显示具体时间或者昨天
+ (NSString *)preciousTimePointStringWithData:(NSDate *)date formatter:(NSString *)formatter;

/// 获取某月的天数
+ (NSInteger)getDaysOfMonthWithDate:(NSDate *)date;

/// 获取某月的天数
+ (NSInteger)getDaysOfYearWithDate:(NSDate *)date;

/**
 计算两个时间戳之间相差的天数，比如"2017年10月11日08:00"比"2017年10月10日19:00"多一天，并不是按照是否差距24小时的倍数来计算的
 
 @param startTime 开始时间的时间戳
 @param endTime 结束时间的时间戳
 @return 相差的天数
 */
+ (NSInteger)daysWithStartTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;

/**
 获取每个月的前或者后的某个月

 @param date 原来月份
 @param monthMargin 和原来月份的间隔
 @return 新月份
 */
+ (NSDate *)monthFirstDayWithDate:(NSDate *)date monthMargin:(NSInteger)monthMargin;

/**
 获取某天的0时0分0秒的date

 @param date 待转化日期
 @return 转化为0时0分0秒的日期
 */
+ (NSDate *)getDayZeroDate:(NSDate *)date;

/// 获取年份
+ (NSInteger)getYearWithDate:(NSDate *)date;
/// 获取月份
+ (NSInteger)getMonthWithDate:(NSDate *)date;
/// 计时列表中按照日选择日期是判断日期是否合法，2015年1月1日到当前时间为合法时间
+ (BOOL)timingListDayIsValidWithDate:(NSDate *)date;

///产品wiki上的时间格式1.对近期时间点敏感、显示区域有限 场景举例：资讯类、社交类 feed 文件/文件夹列表
+(NSString *)getStyle1ByDate:(NSDate *)date;
///产品wiki上的时间格式2.对近期时间点敏感、对具体时间点要求高、显示区域充裕 场景举例：资料库等修改历史 任务评论/操作日志 偏重人为因素的操作日志
+(NSString *)getStyle2ByDate:(NSDate *)date;
///产品wiki上的时间格式3.对准确时间要求极高、显示区域充裕 较为枯燥的内容、非社交场景 某些原因导致 t 出错时（如果用户更改设备端的时间导致 t 为负数），用此格式替换其他格式显示.场景举例：文件历史版本  偏重系统因素的操作日志
+(NSString *)getStyle3ByDate:(NSDate *)date;
///产品wiki上的时间格式4.对准确时间要求不高，显示区域不丰富 对时效性要求不高，无需准确标示今天 昨天 前天 .场景举例：收藏夹添加收藏时间
+(NSString *)getStyle4ByDate:(NSDate *)date;
///产品wiki上的时间格式5.场景举例：享聊，阿尔法小助手，审批小助手
+(NSString *)getStyle5ByDate:(NSDate *)date;

/**
 产品wiki上的时间格式6.场景举例：日期时间功能设置

 @param date 日期
 @param isThroughoutDay 是否跨天
 @return 格式化后的日期字符串
 */
+ (NSString *)getStyle6ByDate:(NSDate *)date isThroughoutDay:(BOOL)isThroughoutDay;

///产品wiki上的时间格式8.场景举例：审批人头像
+(NSString *)getStyle8ByDate:(NSDate *)date;

///对格式1的扩展，格式1绿线部分
+ (NSString *)getStyle10ByDate:(NSDate *)date;

@end
