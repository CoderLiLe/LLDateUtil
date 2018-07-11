//
//  CustomDateFormatter.m
//  Kecheng
//
//  Created by lvdongdong on 12/7/12.
//  Copyright (c) 2012 CreatingEV. All rights reserved.
//

#import "CustomDateFormatter.h"
#import "NSDate+NPExtension.h"
#import "JTDateHelper.h"

@implementation CustomDateFormatter

-(id)init {
    self = [super init];
    if(self) {
        [self setShortWeekdaySymbols:[NSArray arrayWithObjects:@"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil]];
        [self setAMSymbol:@"上午"];
        [self setPMSymbol:@"下午"];
    }
    return self;
}

- (void)setCombinedMode
{
    [self setDateFormat:@"yy年M月d号 a HH:mm"];
}

- (void)setDateAndWeekShow
{
    [self setDateFormat:@"yyyy年M月d日 eee"];
}

-(void)setWeekShow{
    [self setDateFormat:@"eee"];
}

- (void)setAMOrPMAndTimeShow
{
    [self setDateFormat:@"a HH:mm"];
}
-(void)setOnlyDateShow
{
    [self setDateFormat:@"yy:MM:dd"];
}

-(void)setonlyTimeShow{
    [self setDateFormat:@"HH:mm"];
}
- (void)setHourShow{
    [self setDateFormat:@"HH"];
}
- (void)setMinutesShow{
    [self setDateFormat:@"mm"];
}

-(void)setYYYY_MM_dd_show{
    [self setDateFormat:@"yyyy-MM-dd"];
}
- (void)setYY_MM_dd_Week_show{
    [self setDateFormat:@"yy年M月d日 eee"];
}
- (void)setYY_MM_dd_HH_mm_show{
    [self setDateFormat:@"yy年M月d日 HH:mm"];
}
-(void)setYYYY_MM_dd_HH_mm_show{
    [self setDateFormat:@"yyyy-MM-dd HH:mm"];
}

-(void)setYYYY_MM_dd_HH_mm_ss_show{
    [self setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

+(BOOL)containsSpecailTime:(NSDate *)date{
    NSString * str = [CustomDateFormatter stringFromDate:date format:@"M月d日 HH:mm:ss"];
    if ([str containsString:@"23:59:59"]) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)dateTimeStringWithDate:(NSDate *)date {
    CustomDateFormatter * customDateFormatter = [[CustomDateFormatter alloc] init];
    [customDateFormatter setYYYY_MM_dd_HH_mm_ss_show];
    return [customDateFormatter stringFromDate:date];
}

+(NSDate *)dateByRemoveSpecailTime:(NSDate *)date{
    NSString * str = [CustomDateFormatter stringFromDate:date format:@"M月d日 HH:mm:ss"];
    if ([str containsString:@"23:59:59"]) {
        str = [CustomDateFormatter stringFromDate:date format:yyyyMd];
        return [CustomDateFormatter dateFromString:str format:yyyyMd];
    }else{
        return date;
    }
}

+(NSDate *)getMidNightDateOfDate:(NSDate *)date{
    CustomDateFormatter * customDateFormatter = [[CustomDateFormatter alloc] init];
    [customDateFormatter setOnlyDateShow];
    NSString * dateStr = [customDateFormatter stringFromDate:date];
    return [customDateFormatter dateFromString:dateStr];
}

-(NSString *)dateTransformToStar:(NSDate *)date{
    NSString * star=@"无";
    NSInteger month =0;
    NSInteger day = 0;
    if (date) {
        NSCalendar*calendar = [NSCalendar currentCalendar];
        NSDateComponents*comps;
        comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                           fromDate:date];
        month = [comps month];
        day = [comps day];
    }
    switch (month) {
        case 1:
            if (day<=19) {
                star = @"摩羯座";
            }else{
                star = @"水瓶座";
            }
            break;
        case 2:
            if(day<=18){
                star = @"水瓶座";
            }else{
                star = @"双鱼座";
            }
            break;
        case 3:
            if (day<=20) {
                star = @"双鱼座";
            }else{
                star = @"白羊座";
            }
            break;
        case 4:
            if (day<=19) {
                star = @"白羊座";
            }else{
                star = @"金牛座";
            }
            break;
        case 5:
            if(day<=20){
                star = @"金牛座";
            }else{
                star = @"双子座";
            }
            break;
        case 6:
            if(day<=21){
                star = @"双子座";
            }else{
                star = @"巨蟹座";
            }
            break;
        case 7:
            if (day<=22) {
                star = @"巨蟹座";
            }else{
                star = @"狮子座";
            }
            break;
        case 8:
            if(day<=22){
                star = @"狮子座";
            }else{
                star = @"处女座";
            }
            break;
        case 9:
            if(day<=22){
                star = @"处女座";
            }else{
                star = @"天秤座";
            }
            break;
        case 10:
            if (day<=23) {
                star = @"天秤座";
            }else{
                star = @"天蝎座";
            }
            break;
        case 11:
            if (day<=22) {
                star = @"天蝎座";
            }else{
                star = @"射手座";
            }
            break;
        case 12:
            if (day<=21) {
                star = @"射手座";
            }else{
                star = @"摩羯座";
            }
            break;
        default:
            break;
    }
    return star;
}

- (NSString *)standardTimeFormatWithDate:(NSDate *)date joint:(NSString *)joint {
    
    NSDateComponents *startCom = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    if (joint) {
        
        return [NSString stringWithFormat:@"%@%@%02ld%@%02ld", @(startCom.year), joint, (long)startCom.month, joint, (long)startCom.day];
    } else {
        return [NSString stringWithFormat:@"%@年%@月%@日", @(startCom.year), @(startCom.month), @(startCom.day)];
    }
    
    return @"";
}

+ (NSString *)standardTimeFormatWithDate:(NSDate *)date joint:(NSString *)joint {
    NSDateComponents *startCom = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
    if (joint) {
        return [NSString stringWithFormat:@"%@%@%02ld%@%02ld", @(startCom.year), joint, (long)startCom.month, joint, (long)startCom.day];
    } else {
        return [NSString stringWithFormat:@"%@年%@月%@日", @(startCom.year), @(startCom.month), @(startCom.day)];
    }
    return @"";
}

+ (NSString *)dateListStringFromInterval:(NSTimeInterval)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    if ([date isToday]) {
        NSDateFormatter * timeDateFormatter = [NSDateFormatter new];
        [timeDateFormatter setDateFormat:@"HH:mm"];
        return [timeDateFormatter stringFromDate:date];
    } else if ([date isYesterday]) {
        return @"昨天";
    } else if ([date isDayBeforeYesterday]) {
        return @"前天";
    }
    
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    if ([date timeIntervalSinceDate:[self getFirstDayOfCurrentWeek:[NSDate date]]]>0) {
      [dateFormatter setWeekShow];
    }else{
      [dateFormatter setYYYY_MM_dd_show];
    }
    return [dateFormatter stringFromDate:date];

}

+(NSDate *)getFirstDayOfCurrentWeek:(NSDate *)date{
  NSCalendar *calendar = [NSCalendar currentCalendar];
  NSDateComponents *comp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |NSCalendarUnitEra  fromDate:date];
  // 获取今天是周几
  NSInteger weekDay = [comp weekday];
  // 获取几天是几号
  NSInteger day = [comp day];
  long firstDiff;
  //    weekDay = 1;
  if (weekDay == 1){
    firstDiff = -6;
  }else{
    firstDiff = [calendar firstWeekday] - weekDay + 1;
  }
  // 在当前日期(去掉时分秒)基础上加上差的天数
  NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay  fromDate:date];
  [firstDayComp setDay:day + firstDiff];
  NSDate *firstDayOfWeek = [calendar dateFromComponents:firstDayComp];
  return firstDayOfWeek;
}


+ (NSString *)dateDetailDateStringFromInterval:(NSTimeInterval)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter * timeDateFormatter = [NSDateFormatter new];
    [timeDateFormatter setDateFormat:@"HH:mm"];
    if ([date isToday]) {
        return [timeDateFormatter stringFromDate:date];
    } else if ([date isYesterday]) {
        return [NSString stringWithFormat:@"昨天 %@",[timeDateFormatter stringFromDate:date]];
    } else if ([date isDayBeforeYesterday]) {
        return [NSString stringWithFormat:@"前天 %@",[timeDateFormatter stringFromDate:date]];
    }
    
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    if ([date timeIntervalSinceDate:[self getFirstDayOfCurrentWeek:[NSDate date]]]>0) {
        [dateFormatter setWeekShow];
    }else{
        [dateFormatter setYYYY_MM_dd_show];
    }
    return [NSString stringWithFormat:@"%@ %@",[dateFormatter stringFromDate:date],[timeDateFormatter stringFromDate:date]];
}

+ (NSString *)relativeWholeDateStringFromDate:(NSDate *)date
{
    if ([date isToday]) {
        return @"今天";
    } else if ([date isYesterday]) {
        return @"昨天";
    }
    
    return [self stringOfDate:date];
}

+ (NSString *)relativeWholeDateStringFromInterval:(NSTimeInterval)interval
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [self relativeWholeDateStringFromDate:date];
}

+ (NSString *)stringOfDate:(NSDate *)theDate
{
    NSParameterAssert(theDate != nil);
    
    NSCalendar *calendar = [[self class] beijingCalendar];
    NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay
    | NSCalendarUnitHour | NSCalendarUnitMinute;
    NSDateComponents *nowComps = [calendar components:units fromDate:[NSDate date]];
    NSDateComponents *theDateComps = [calendar components:units fromDate:theDate];
    NSString *timeStr = nil;
    if (nowComps.year == theDateComps.year) {
        if (nowComps.month == theDateComps.month) {
            if (nowComps.day == theDateComps.day) {
                timeStr = [NSString stringWithFormat:@"%02" PRI_NSInteger ":%02" PRI_NSInteger,
                           theDateComps.hour, theDateComps.minute];
            } else {
                timeStr = [NSString stringWithFormat:@"%ld月%ld日",
                           (long)theDateComps.month, (long)theDateComps.day];
            }
        } else {
            timeStr = [NSString stringWithFormat:@"%ld月%ld日",
                       (long)theDateComps.month, (long)theDateComps.day];
        }
    } else {
        timeStr = [NSString stringWithFormat:@"%ld年%ld月%ld日",
                   (long)theDateComps.year, (long)theDateComps.month, (long)theDateComps.day];
    }
    
    NSAssert(timeStr != nil, @"formatted date string should not be nil");
    
    return timeStr ?: @"";
}

+ (NSString *)timeDisplayStringWithEndTime:(NSTimeInterval)endTime
{
    NSDate * endDate = [NSDate dateWithTimeIntervalSince1970:endTime];
    NSInteger timeInterval = [endDate timeIntervalSinceNow];
    NSInteger oneDayInterval = 60 * 60 * 24;
    NSInteger days = timeInterval / oneDayInterval;
    if (timeInterval % oneDayInterval) {
        days += 1;
    }
    return [NSString stringWithFormat:@"%ld",(long)days];
}


+ (NSDateComponents *)customCalendarDateComponentsOfDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unitFlags fromDate:date];
}

+ (NSString *)getStringMonthBeginDateOfDate:(NSDate *)date{
    NSInteger year,month;
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:date];
    year = [component year];
    month = [component month];
    CustomDateFormatter * dateFormater = [[CustomDateFormatter alloc] init];
    [dateFormater setYYYY_MM_dd_HH_mm_ss_show];
    return [NSString stringWithFormat:@"%ld-%ld-1 00:00:00",(long)year,(long)month];
}

+ (NSString *)getStringMonthEndDateOfDate:(NSDate *)date{
    NSInteger year,month;
    NSInteger endDay = 30;
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:date];
    year = [component year];
    month = [component month];
    
    if (month!=2) {
        if (month == 4 || month==6 || month ==9 || month ==11) {
            endDay = 30;
        }
        else {
            endDay = 31;
        }
    }
    else {
        if ((year%4==0 && year%100!=0) || year%400==0) {
            endDay = 29;
        }
        else {
            endDay = 28;
        }
    }
    return [NSString stringWithFormat:@"%ld-%ld-%ld 23:59:59",(long)year,(long)month,(long)endDay];
}

+ (NSDate *)getMonthBeginDateOfDate:(NSDate *)date {
    
    NSInteger year, month;
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:date];
    year = [component year];
    month = [component month];
    NSString * monthStr = @"";
    if (month>10) {
        monthStr = [NSString stringWithFormat:@"%ld",(long)month];
    }else{
        monthStr = [NSString stringWithFormat:@"0%ld",(long)month];
    }
    NSDate * resultDate = [self dateFromString:[NSString stringWithFormat:@"%ld-%@-01 00:00:00",(long)year,monthStr] format:@"yyyy-MM-dd HH:mm:ss"] ;
    return resultDate;
}

+ (NSString *)getStringDayBeginDateOfDate:(NSDate *)date
{
    NSInteger year, month, day;
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:date];
    year = [component year];
    month = [component month];
    day = [component day];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld 00:00:00",(long)year,(long)month, (long)day];
}
+ (NSDate *)getBeginDateOfDate:(NSDate *)date{
    NSString * beginDateStr = [self getStringDayBeginDateOfDate:date];
    return [self dateFormyMdString:beginDateStr];
}


+ (NSString *)getStringDayEndDateOfDate:(NSDate *)date
{
    NSInteger year, month, day;
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:date];
    year = [component year];
    month = [component month];
    day = [component day];
    return [NSString stringWithFormat:@"%ld-%02ld-%02ld 23:59:59",(long)year,(long)month, (long)day];
}

+ (NSString *)yMdByDate:(NSDate *)date
{
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
    [dateFormatter setYYYY_MM_dd_show];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)hsByDate:(NSDate *)date
{
    CustomDateFormatter *dateFormatter = [[CustomDateFormatter alloc] init];
    [dateFormatter setonlyTimeShow];
    return [dateFormatter stringFromDate:date];
}

+ (NSDate *)dateFormyMdString:(NSString *)s
{
    return [self dateFromString:s format:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)dateFromString:(NSString *)date format:(NSString *)fmt
{
    return [[[self class] dateFormatterWithFormat:fmt] dateFromString:date];
}

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)fmt
{
    static NSCache *cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [[NSCache alloc] init];
    });
    
    NSDateFormatter *instance = [cache objectForKey:fmt];
    if (instance == nil) {
        @synchronized(cache) {
            instance = [cache objectForKey:fmt];
            if (instance == nil) {
                instance = [[NSDateFormatter alloc] init];
                instance.dateFormat = fmt;
                instance.calendar = [self beijingCalendar];
                instance.timeZone = instance.calendar.timeZone;
                [cache setObject:instance forKey:fmt];
            }
        }
    }
    return instance;
}

+ (NSCalendar *)beijingCalendar
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    calendar.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8 * 60 * 60];
    return calendar;
}

+ (NSString *)stringFromDate:(NSDate *)date format:(NSString *)fmt
{
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
    [dateFormatter setDateFormat:fmt];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)stringFromInterval:(NSTimeInterval)interval format:(NSString *)fmt
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    return [CustomDateFormatter stringFromDate:date format:fmt];
}

+ (NSTimeInterval)timeIntervalFrom:(NSString *)dateString format:(NSString *)fmt
{
    NSDate *date = [CustomDateFormatter dateFromString:dateString format:fmt];
    return [date timeIntervalSince1970];
}

+ (NSString *)getCurrentDateFullTime
{
    NSDate *c = [NSDate date];
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:c];
    NSInteger hour = [component hour];
    if (hour < 24) {
        hour++;
    }
    NSString *time = [NSString stringWithFormat:@"%ld-%02ld-%02ld %02ld:%@",(long)[component year], (long)[component month], (long)[component day], (long)hour, @"00"];
    return time;
}

+ (NSString *)getCurrentDateNextFullTime
{
    NSString *c = [self getCurrentDateFullTime];
    CustomDateFormatter * dateFormater = [[CustomDateFormatter alloc] init];
    [dateFormater setYYYY_MM_dd_HH_mm_show];
    NSDate *date = [dateFormater dateFromString:c];
    date = [NSDate dateWithTimeInterval:60*60 sinceDate:date];
    return [dateFormater stringFromDate:date];
}

+ (NSString *)getNextHourTime:(NSDate *)date
{
    CustomDateFormatter * dateFormater = [[CustomDateFormatter alloc] init];
    [dateFormater setYYYY_MM_dd_HH_mm_show];
    date = [NSDate dateWithTimeInterval:60*60 sinceDate:date];
    return [dateFormater stringFromDate:date];
}

+ (NSString *)dayIntervalByCurrentDay:(NSDate *)date days:(NSInteger)days format:(NSString *)format
{
    JTDateHelper *dateHelper = [JTDateHelper new];
    NSDate *nextDate = [dateHelper addToDate:date days:days];
    return [self stringFromDate:nextDate format:format];
}

+ (NSDate *)curentDateLateDateWithYears:(NSUInteger)years {
    JTDateHelper *dateHelper = [JTDateHelper new];
    NSDate *nextDate = [dateHelper addToDate:[NSDate date] years:years];
    return nextDate;
}

+(NSInteger)getWeekNumberOfDate:(NSDate *)date{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents * comps = [calendar components:unitFlags fromDate:date];
    //  int year=[comps year];
    //  int week = [comps weekday];
    //  int month = [comps month];
    //  int day = [comps day];
    //  int hour = [comps hour];
    //  int min = [comps minute];
    //  int sec = [comps second];
    return [comps weekday];
}

+ (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB
{
    JTDateHelper *dateHelper = [JTDateHelper new];
    return [dateHelper date:dateA isTheSameDayThan:dateB];
}

+ (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB
{
    JTDateHelper *dateHelper = [JTDateHelper new];
    return [dateHelper date:dateA isTheSameWeekThan:dateB];
}

+ (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB {
    
    JTDateHelper *dateHelper = [JTDateHelper new];
    return [dateHelper date:dateA isTheSameMonthThan:dateB];
}

+ (BOOL)date:(NSDate *)dateA isMoreInOneDaysThan:(NSDate *)dateB{
    JTDateHelper *dateHelper = [JTDateHelper new];
    return [dateHelper date:dateA isMoreInOneDaysThan:dateB];
}

+ (BOOL)date:(NSDate *)dateA isMoreInThreeDaysThan:(NSDate *)dateB{
    JTDateHelper *dateHelper = [JTDateHelper new];
    return [dateHelper date:dateA isMoreInThreeDaysThan:dateB];
}

+ (NSString *)timeToMinuteStringBySeconds:(NSTimeInterval)seconds
{
    if (seconds <= 0) {
        return @"00:00";
    }
    
    if (seconds < 60) {
        return @"00:01";
    }
    
    int s = (int)((long long)seconds % MINUTE);
    if (s > 0) {
        seconds += MINUTE;
    }
    
    int h = (int)((long long)seconds / HOUR);
    int m = (int)((long long)seconds % HOUR / MINUTE);
    
    return [NSString stringWithFormat:@"%02d:%02d", h, m];
}

+ (NSString *)hoursMinutesStringWithSeconds:(NSTimeInterval)seconds maxHour:(NSInteger)maxHour
{
    if (seconds <= 0) {
        return @"00:00";
    }
    
    if (seconds < 60) {
        return @"00:01";
    }
    
    int s = (int)((long long)seconds % MINUTE);
    if (s > 0) {
        seconds += (MINUTE - s);
    }
    
    int h = (int)((long long)seconds / HOUR);
    int m = (int)((long long)seconds % HOUR / MINUTE);
    
    if (h < 1000) {
        return [NSString stringWithFormat:@"%02d:%02d", h, m];
    } else if (h >= 1000 && h <= maxHour) {
        return [NSString stringWithFormat:@"%d", h];
    } else {
        return [NSString stringWithFormat:@"%ld+", (long)maxHour];
    }
}

+ (NSString *)getHHMMSSWithSeconds:(NSTimeInterval)seconds
{
    if (seconds <= 0) {
        return @"00:00:00";
    }
    
    int h = (int)((long long)seconds / HOUR);
    int m = (int)((long long)seconds % HOUR / MINUTE);
    int s = (int)((long long)seconds % MINUTE);
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m, s];
}

// 32:4 ==> 32:04
+ (NSString *)getHHMMStringWithTime:(NSTimeInterval)timeInterval
{
    NSTimeInterval seconds = timeInterval/1000;
    if (seconds <= 0) {
        return @"00:00";
    }
    
    if (seconds < 60) {
        return @"00:01";
    }
    int h = (int)((long long)seconds / HOUR);
    int m = (int)((long long)seconds % HOUR / MINUTE);
    int s = (int)((long long)seconds % MINUTE);
    if (s > 0) {
        m += 1;
    }
    return [NSString stringWithFormat:@"%02d:%02d", h, m];
}

+ (NSString *)timeToSecondStringBySeconds:(NSTimeInterval)seconds
{
    if (seconds <= 0) {
        return @"00:00:00";
    }
    int h = (int)((long long)seconds / HOUR);
    int m = (int)((long long)seconds % HOUR / MINUTE);
    int s = (int)((long long)seconds%MINUTE);
    return [NSString stringWithFormat:@"%02d:%02d:%02d", h, m,s];
}

+ (NSInteger)minsByTimeString:(NSString *)timeStr
{
    NSArray *arr = [timeStr componentsSeparatedByString:@":"];
    NSInteger h = [arr[0] integerValue];
    NSInteger m = [arr[1] integerValue];
    return h * 60 + m;
}

+ (NSInteger)secondsByTimeString:(NSString *)timeStr
{
    NSArray *arr = [timeStr componentsSeparatedByString:@":"];
    NSInteger h = [arr[0] integerValue];
    NSInteger m = [arr[1] integerValue];
    NSInteger s = [arr[2] integerValue];
    return h * 60 * 60 + m * 60 + s;
}

+ (NSString *)dateToStringWithDateStr:(NSString *)dateStr
{
    NSString *returnStr;
    NSString *todayStr = [CustomDateFormatter yMdByDate:[NSDate date]];
    NSString *yestodayStr = [CustomDateFormatter yMdByDate:[NSDate dateWithTimeInterval:-24*60*60 sinceDate:[NSDate date]]];
    NSString *tommowStr = [CustomDateFormatter yMdByDate:[NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]]];
    if ([todayStr isEqualToString:dateStr]) {
        returnStr = @"今天";
    } else if ([yestodayStr isEqualToString:dateStr]) {
        returnStr = @"昨天";
    } else if ([tommowStr isEqualToString:dateStr]) {
        returnStr = @"明天";
    } else {
        NSArray *dateArr = [dateStr componentsSeparatedByString:@"-"];
        if (dateArr.count<3) {
            return dateStr;
            //防止闪退
        }
        if ([CustomDateFormatter isCurrentYearWithYYYYMMDD:dateStr]) {
            returnStr = [NSString stringWithFormat:@"%@月%@日", [dateArr[1] formatMonth], [dateArr[2] formatDay]];
        } else {
            returnStr = [NSString stringWithFormat:@"%@年%@月%@日", dateArr[0], [dateArr[1] formatMonth], [dateArr[2] formatDay]];
        }
    }
    return returnStr;
}

+ (BOOL)isCurrentYearWithYYYYMMDD:(NSString *)yyyymmdd
{
    NSString *todayStr = [CustomDateFormatter yMdByDate:[NSDate date]];
    NSArray *dateArr = [yyyymmdd componentsSeparatedByString:@"-"];
    NSArray *todayArr = [todayStr componentsSeparatedByString:@"-"];
    return [dateArr[0] isEqualToString:todayArr[0]];
}

+ (BOOL)isCurrentYearWithDate:(NSDate *)date
{
    NSParameterAssert(date != nil);
    
    NSCalendar *calendar = [[self class] beijingCalendar];
    NSCalendarUnit units = NSCalendarUnitYear;
    NSDateComponents *nowComps = [calendar components:units fromDate:[NSDate date]];
    NSDateComponents *dateComps = [calendar components:units fromDate:date];
    return nowComps.year == dateComps.year;
}

+ (NSDate *)today
{
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    return [CustomDateFormatter todayWithFormat:unitFlags];
}

+ (BOOL)isTodayWithDate:(NSDate *)date
{
    NSString *todayStr = [CustomDateFormatter yMdByDate:[NSDate date]];
    NSString *dateStr = [CustomDateFormatter yMdByDate:date];
    return [todayStr isEqualToString:dateStr];
}

+ (NSDate *)todayWithFormatYYMMDDHH
{
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | kCFCalendarUnitHour;
    return [CustomDateFormatter todayWithFormat:unitFlags];
}

+ (NSDate *)todayWithFormat:(NSCalendarUnit)calendarUnit
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps =  [calendar components:calendarUnit fromDate:[NSDate date]];
    NSDate *date = [calendar dateFromComponents:comps];
    return date;
}

+ (BOOL)rangeNowWithTime:(NSTimeInterval)interval within:(NSTimeInterval)distance
{
    NSDate *now = [NSDate date];
    NSTimeInterval inter = [now timeIntervalSince1970];
    return fabs(inter - interval) < distance;
}

+ (NSDate *)getTodayNineTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour = 9;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

+ (NSDate *)getNineOClockWithDate:(NSDate *)date {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 9;
    components.minute = 0;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

+ (NSDate *)getFullToday:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 23;
    components.minute = 59;
    components.second = 59;
    components.nanosecond = 0;
    return [calendar dateFromComponents:components];
}

+ (NSDate *)getTodaySpecialHour:(NSInteger)hour minute:(NSInteger)minute {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:[NSDate date]];
    components.hour = hour;
    components.minute = minute;
    components.second = 0;
    return [calendar dateFromComponents:components];
}

/// 获取某年某月的第一天凌晨零点零时零分零秒的NSDate
+ (NSDate *)getDateWithYear:(NSInteger)year month:(NSInteger)month
{
    NSCalendar *calendar = [self beijingCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setValue:year forComponent:NSCalendarUnitYear];
    [components setValue:month forComponent:NSCalendarUnitMonth];
    [components setValue:1 forComponent:NSCalendarUnitDay];
    [components setValue:8 forComponent:NSCalendarUnitHour];
    [components setValue:0 forComponent:NSCalendarUnitMinute];
    [components setValue:0 forComponent:NSCalendarUnitSecond];
    [components setValue:0 forComponent:NSCalendarUnitNanosecond];
    return [calendar dateFromComponents:components];
}

+ (NSTimeInterval)getBeginIntervalWithDate:(NSDate *)date
{
    NSCalendar *calendar = [self beijingCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    components.nanosecond = 0;
    NSDate *zeroDate = [calendar dateFromComponents:components];
    return [zeroDate timeIntervalSince1970];
}

// 将东八区的时间转为格林尼治时间
+ (NSDate *)transformDateToGMDate:(NSDate *)date
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.locale = [NSLocale currentLocale];
    NSString *dateStr =[dateFormatter stringFromDate:date];
    return [dateFormatter dateFromString:dateStr];
}

+ (NSString *)beginAndEndDateStrWithBeginDate:(NSDate *)beginDate
{
    NSString *beginTime = [self yMdByDate:beginDate];
    NSArray *beginDateArr = [beginTime componentsSeparatedByString:@"-"];
    NSString *beginTimeFromat = [NSString formatDateWithMonthStr:beginDateArr[1] dayStr:beginDateArr[2]];
    
    NSDate *endDate = [NSDate dateWithTimeInterval:6*DAY sinceDate:beginDate];
    NSString *endTime = [CustomDateFormatter yMdByDate:endDate];
    NSArray *endDateArr = [endTime componentsSeparatedByString:@"-"];
    NSString *endTimeFromat = [NSString formatDateWithMonthStr:endDateArr[1] dayStr:endDateArr[2]];
    return [NSString stringWithFormat:@"%@ - %@", beginTimeFromat, endTimeFromat];
}

+ (NSString *)daysIntervalStringWithStr:(NSString *)str foratter:(NSString *)formatter
{
    NSDate *date = [CustomDateFormatter dateFromString:str format:@"yyyy-MM-dd HH:mm:ss"];
    return [CustomDateFormatter daysIntervalStringWithDate:date foratter:formatter];
}

+ (NSString *)daysIntervalStringWithDate:(NSDate *)date foratter:(NSString *)formatter
{
    if ([date isToday]) {
        return [self __processTodayDateWithDate:date];
    } else if ([date isYesterday]) {
        return @"昨天";
    } else if ([date isDayBeforeYesterday]) {
        return @"2天前";
    } else if ([date isDayDaysInterval:3]) {
        return @"3天前";
    } else if ([date isDayDaysInterval:4]) {
        return @"4天前";
    } else if ([date isDayDaysInterval:5]) {
        return @"5天前";
    } else {
        CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatter];
        return [dateFormatter stringFromDate:date];
    }
}

+ (NSString *)preciousTimePointStringWithData:(NSDate *)date formatter:(NSString *)formatter {
    
    if ([date isToday]) {
        return [self __processTodayDateWithDate:date];
    } else if ([date isYesterday]) {
        CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
        return [NSString stringWithFormat:@"昨天 %@", [dateFormatter stringFromDate:date]];
    } else {
        CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
        [dateFormatter setDateFormat:formatter];
        return [dateFormatter stringFromDate:date];
    }
}

/// 获取某月的天数
+ (NSInteger)getDaysOfMonthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [self beijingCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}

/// 获取某月的天数
+ (NSInteger)getDaysOfYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [self beijingCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitYear forDate:date];
    return range.length;
}

+ (NSInteger)daysWithStartTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime
{
    if (startTime >= endTime) {
        return 0;
    }
    
    NSCalendar *calendar = [self beijingCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *startComp = [calendar components:unit fromDate:[NSDate dateWithTimeIntervalSince1970:startTime]];
    NSDateComponents *endComp = [calendar components:unit fromDate:[NSDate dateWithTimeIntervalSince1970:endTime]];
    
    NSInteger startYear = startComp.year;
    NSInteger endYear = endComp.year;
    
    NSInteger startDay = startComp.day;
    NSInteger endDay = endComp.day;
    
    if (startYear == endYear) { // 同一年
        NSInteger startMonth = startComp.month;
        NSInteger endMonth = endComp.month;
        if (startMonth == endMonth) { // 同一个月
            return endDay - startDay;
        } else {
            NSInteger dayDistance = endDay;
            NSArray *bigMonths = @[@(1), @(3), @(5), @(7), @(8), @(10), @(12)];
            
            NSInteger startMonthTotalDay = 30;
            if ([bigMonths containsObject:@(startMonth)]) {
                startMonthTotalDay = 31;
            } else if (2 == startMonth) {
                startMonthTotalDay = ((0 == startYear % 4) ? 29 : 28);
            }
            dayDistance += (startMonthTotalDay - startDay);
            
            for (NSInteger i = startMonth+1; i < endMonth; i++) {
                if ([bigMonths containsObject:@(i)]) {
                    dayDistance += 31;
                } else if (2 == i) {
                    NSInteger februaryDays = ((0 == startYear % 4) ? 29 : 28);
                    dayDistance += februaryDays;
                } else {
                    dayDistance += 30;
                }
            }
            return dayDistance;
        }
    } else { // 不同年
        NSInteger dayDistance = 0;
        // 判断闰年的标准是：1、能整除4且不能整除100 2、能整除400
        for (NSInteger i = startYear; i < endYear; i++) {
            if ((0 == i % 4 && i % 100 != 0) || 0 == i % 400) {
                dayDistance += 366;
            } else {
                dayDistance += 365;
            }
        }
        return dayDistance + (endDay - startDay);
    }
}

+ (NSDate *)monthFirstDayWithDate:(NSDate *)date monthMargin:(NSInteger)monthMargin
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *monthCom = [[NSDateComponents alloc] init];
    [monthCom setMonth:monthMargin];
    NSDate *nextMonthDate = [calendar dateByAddingComponents:monthCom toDate:date options:0];
    
    NSDate *firstDayDate;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDayDate interval:nil forDate:nextMonthDate];
    return [self getDayZeroDate:firstDayDate];
}

+ (NSDate *)getDayZeroDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSUIntegerMax fromDate:date];
    components.hour = 8;
    components.minute = 0;
    components.second = 0;
    components.nanosecond = 0;
    return [calendar dateFromComponents:components];
}

/// 获取年份
+ (NSInteger)getYearWithDate:(NSDate *)date
{
    NSCalendar *calendar = [self beijingCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear
                                          fromDate:date];
    return comp.year;
}

/// 获取月份
+ (NSInteger)getMonthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [self beijingCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitMonth
                                         fromDate:date];
    return comp.month;
}

+ (BOOL)timingListDayIsValidWithDate:(NSDate *)date
{
    NSInteger year;
    NSDateComponents * component = [self customCalendarDateComponentsOfDate:date];
    year = [component year];
    
    if (year>2014 && [date timeIntervalSinceNow] < 0) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark - private method

+ (NSString *)__processTodayDateWithDate:(NSDate *)date
{
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    if (timeInterval < -10) {
        CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm"];
        return [dateFormatter stringFromDate:date];
    } else if (timeInterval >= -10 && timeInterval < MINUTE) {
        return @"刚刚";
    } else if (timeInterval >= MINUTE && timeInterval < HOUR) {
        return [NSString stringWithFormat:@"%.0f分钟前", floor(timeInterval/60)];
    } else {
        return [NSString stringWithFormat:@"%.0f小时前", floor(timeInterval/3600)];
    }
}

///产品wiki上的时间格式1.对近期时间点敏感、显示区域有限 场景举例：资讯类、社交类 feed 文件/文件夹列表
+(NSString *)getStyle1ByDate:(NSDate *)date{
    NSTimeInterval currentInterVal = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval dateInterVal = [date timeIntervalSince1970];
    NSTimeInterval distance = currentInterVal - dateInterVal;
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    if (distance<-10) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:date];
    }else if (distance>=-10&&distance<MINUTE){
        return @"刚刚";
    }else if (distance>=MINUTE&&distance<HOUR){
        return [NSString stringWithFormat:@"%.0f分钟前", floor(distance/60)];
    }else if (distance>=MINUTE&&distance<24*HOUR){
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([date isToday]) {
            return [NSString stringWithFormat:@"%.0f小时前", floor(distance/3600)];
        }else{
            return @"昨天";
        }
        
    }else{//disntace>=24*HOUR
        if ([date isYesterday]) {
            return @"昨天";
        }else{
            NSDate * before4DayBegin = [self getBeginDateOfDate:[NSDate dateWithTimeIntervalSinceNow:-4*DAY]];
            if ([date timeIntervalSinceDate:before4DayBegin]>=0) {
                NSString * dayStr = @"";
                if ([date isDayBeforeYesterday]) {
                    dayStr = @"2天前";
                } else if ([date isDayDaysInterval:3]) {
                    dayStr = @"3天前";
                } else if ([date isDayDaysInterval:4]) {
                    dayStr = @"4天前";
                } else if ([date isDayDaysInterval:5]) {
                    dayStr = @"5天前";
                }else{
                    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                    return [dateFormatter stringFromDate:date];
                }
                return dayStr;
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd"];
                return [dateFormatter stringFromDate:date];
            }
        }
    }
}
///产品wiki上的时间格式2.对近期时间点敏感、对具体时间点要求高、显示区域充裕 场景举例：资料库等修改历史 任务评论/操作日志 偏重人为因素的操作日志
+(NSString *)getStyle2ByDate:(NSDate *)date{
    NSTimeInterval currentInterVal = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval dateInterVal = [date timeIntervalSince1970];
    NSTimeInterval distance = currentInterVal - dateInterVal;
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    if (distance<-10) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:date];
    }else if (distance>=-10&&distance<MINUTE){
        return @"刚刚";
    }else if (distance>=MINUTE&&distance<HOUR){
        return [NSString stringWithFormat:@"%.0f分钟前", floor(distance/60)];
    }else if (distance>=MINUTE&&distance<24*HOUR){
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([date isToday]) {
            return [NSString stringWithFormat:@"%.0f小时前", floor(distance/3600)];
        }else{
            return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
        }
        
    }else{//disntace>=24*HOUR
        if ([date isYesterday]) {
            [dateFormatter setDateFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
        }else{
            NSDate * before4DayBegin = [self getBeginDateOfDate:[NSDate dateWithTimeIntervalSinceNow:-4*DAY]];
            if ([date timeIntervalSinceDate:before4DayBegin]>=0) {
                NSString * dayStr = @"";
                if ([date isDayBeforeYesterday]) {
                    dayStr = @"2天前";
                } else if ([date isDayDaysInterval:3]) {
                    dayStr = @"3天前";
                } else if ([date isDayDaysInterval:4]) {
                    dayStr = @"4天前";
                } else if ([date isDayDaysInterval:5]) {
                    dayStr = @"5天前";
                }else{
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                    return [dateFormatter stringFromDate:date];
                }
                [dateFormatter setDateFormat:@"HH:mm"];
                return [NSString stringWithFormat:@"%@ %@",dayStr,[dateFormatter stringFromDate:date]];
            }else{
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                return [dateFormatter stringFromDate:date];
            }
        }
    }
    
}
///产品wiki上的时间格式3.对准确时间要求极高、显示区域充裕 较为枯燥的内容、非社交场景 某些原因导致 t 出错时（如果用户更改设备端的时间导致 t 为负数），用此格式替换其他格式显示.场景举例：文件历史版本  偏重系统因素的操作日志
+(NSString *)getStyle3ByDate:(NSDate *)date{
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    return [dateFormatter stringFromDate:date];
}
///产品wiki上的时间格式4.对准确时间要求不高，显示区域不丰富 对时效性要求不高，无需准确标示今天 昨天 前天 .场景举例：收藏夹添加收藏时间
+(NSString *)getStyle4ByDate:(NSDate *)date{
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    if ([date isToday]) {
        return @"今天";
    }else{
        return [dateFormatter stringFromDate:date];
    }
}

///产品wiki上的时间格式5.场景举例：享聊，阿尔法小助手，审批小助手
+(NSString *)getStyle5ByDate:(NSDate *)date{
    NSCalendarUnit components = (NSCalendarUnit)(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitHour | NSCalendarUnitMinute);
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:components fromDate:date];
    NSString *weekDay = [self __weekdayStr:dateComponents.weekday];

    
    NSTimeInterval currentInterVal = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval dateInterVal = [date timeIntervalSince1970];
    NSTimeInterval distance = currentInterVal - dateInterVal;
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc]init];
    if (distance<-10) {
        [dateFormatter setDateFormat:@"yyyy年M月d日 HH:mm"];
        return [dateFormatter stringFromDate:date];
    }else if (distance>=-10&&distance<24*HOUR){
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([date isToday]) {
            return [dateFormatter stringFromDate:date];
        }else{//昨天
            return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
        }
    }else if (distance>=24*HOUR&&distance<48*HOUR){
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([date isYesterday]) {
            return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:date]];
        }else{
            return [NSString stringWithFormat:@"%@ %@",weekDay,[dateFormatter stringFromDate:date]];
        }
    }else{//>=48hour
        NSDate * before7DayBegin = [self getBeginDateOfDate:[NSDate dateWithTimeIntervalSinceNow:-7*DAY]];
        if ([date timeIntervalSinceDate:before7DayBegin]>=0) {
            [dateFormatter setDateFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"%@ %@",weekDay,[dateFormatter stringFromDate:date]];
        }else{
            [dateFormatter setDateFormat:@"yyyy年M月d日 HH:mm"];
            return [dateFormatter stringFromDate:date];
        }
    }
}

/// 产品wiki上的时间格式6.场景举例：日期时间功能设置
+ (NSString *)getStyle6ByDate:(NSDate *)date isThroughoutDay:(BOOL)isThroughoutDay {
    NSString *dateFormat;
    if ([date isThisYear]) {
        dateFormat = isThroughoutDay ? @"M月d日 (eee)" : @"M月d日 (eee) HH:mm";
    } else {
        dateFormat = isThroughoutDay ? @"yyyy年M月d日 (eee)" : @"yyyy年M月d日 (eee) HH:mm";
    }
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    return [dateFormatter stringFromDate:date];
}

///产品wiki上的时间格式8.场景举例：审批人头像
+ (NSString *)getStyle8ByDate:(NSDate *)date {
    NSTimeInterval currentInterVal = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval dateInterVal = [date timeIntervalSince1970];
    NSTimeInterval distance = currentInterVal - dateInterVal;
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
    if (distance < - 10) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        return [dateFormatter stringFromDate:date];
    } else if ([date isToday]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        return [dateFormatter stringFromDate:date];
    } else if ([date isThisYear]) {
        [dateFormatter setDateFormat:@"M月d日"];
        return [dateFormatter stringFromDate:date];
    } else {
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        return [dateFormatter stringFromDate:date];
    }
}

///对格式1的扩展，格式1绿线部分
+ (NSString *)getStyle10ByDate:(NSDate *)date {
    NSTimeInterval currentInterVal = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval dateInterVal = [date timeIntervalSince1970];
    NSTimeInterval distance = currentInterVal - dateInterVal;
    CustomDateFormatter * dateFormatter = [[CustomDateFormatter alloc] init];
    if (distance<-10) {
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateFormatter stringFromDate:date];
    }else if (distance>=-10&&distance<MINUTE){
        return @"刚刚";
    }else if (distance>=MINUTE&&distance<HOUR){
        return [NSString stringWithFormat:@"%.0f分钟前", floor(distance/60)];
    }else if (distance>=MINUTE&&distance<24*HOUR){
        [dateFormatter setDateFormat:@"HH:mm"];
        if ([date isToday]) {
            return [NSString stringWithFormat:@"%.0f小时前", floor(distance/3600)];
        }else{
            return @"昨天";
        }
        
    }else{//disntace>=24*HOUR
        if ([date isThisYear]) {
            if ([date isYesterday]) {
                return @"昨天";
            } else if (![date isThisYear]) {
                [dateFormatter setDateFormat:@"yyyy.MM.dd"];
                return [dateFormatter stringFromDate:date];
            } else{
                NSDate * before4DayBegin = [self getBeginDateOfDate:[NSDate dateWithTimeIntervalSinceNow:-4*DAY]];
                if ([date timeIntervalSinceDate:before4DayBegin]>=0) {
                    NSString * dayStr = @"";
                    if ([date isDayBeforeYesterday]) {
                        dayStr = @"2天前";
                    } else if ([date isDayDaysInterval:3]) {
                        dayStr = @"3天前";
                    } else if ([date isDayDaysInterval:4]) {
                        dayStr = @"4天前";
                    } else if ([date isDayDaysInterval:5]) {
                        dayStr = @"5天前";
                    }else{
                        [dateFormatter setDateFormat:@"M月d日"];
                        return [dateFormatter stringFromDate:date];
                    }
                    return dayStr;
                }else{
                    [dateFormatter setDateFormat:@"M月d日"];
                    return [dateFormatter stringFromDate:date];
                }
            }
        } else {
            [dateFormatter setDateFormat:@"yyyy.MM.dd"];
            return [dateFormatter stringFromDate:date];
        }
    }
}

+ (NSString*)__weekdayStr:(NSInteger)dayOfWeek
{
    static NSDictionary *daysOfWeekDict = nil;
    daysOfWeekDict = @{@(1):@"星期日",
                       @(2):@"星期一",
                       @(3):@"星期二",
                       @(4):@"星期三",
                       @(5):@"星期四",
                       @(6):@"星期五",
                       @(7):@"星期六",};
    return [daysOfWeekDict objectForKey:@(dayOfWeek)];
}

@end
