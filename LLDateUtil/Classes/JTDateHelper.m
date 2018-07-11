//
//  JTDateHelper.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTDateHelper.h"

@interface JTDateHelper (){
    NSCalendar *_calendar;
}

@end

@implementation JTDateHelper

- (NSCalendar *)calendar
{
    if (!_calendar) {
        @synchronized(self) {
            if (!_calendar) {
                _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                _calendar.timeZone = [NSTimeZone localTimeZone];
                _calendar.locale = [NSLocale currentLocale];
                _calendar.firstWeekday = 2; // 周一
            }
        }
    }
    return _calendar;
}


- (NSDateFormatter *)createDateFormatter
{
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    dateFormatter.timeZone = self.calendar.timeZone;
    dateFormatter.locale = self.calendar.locale;
    
    return dateFormatter;
}

#pragma mark - Operations

- (NSDate *)addToDate:(NSDate *)date years:(NSInteger)years {
    
    NSDateComponents *components = [NSDateComponents new];
    components.year = years;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

- (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months
{
    NSDateComponents *components = [NSDateComponents new];
    components.month = months;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

- (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks
{
    NSDateComponents *components = [NSDateComponents new];
    components.day = 7 * weeks;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

- (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days
{
    NSDateComponents *components = [NSDateComponents new];
    components.day = days;
    return [self.calendar dateByAddingComponents:components toDate:date options:0];
}

#pragma mark - Helpers

- (NSUInteger)numberOfWeeks:(NSDate *)date
{
    NSDate *firstDay = [self firstDayOfMonth:date];
    NSDate *lastDay = [self lastDayOfMonth:date];
    
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitWeekOfYear fromDate:firstDay];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitWeekOfYear fromDate:lastDay];
    
    // weekOfYear may return 53 for the first week of the year
    return (componentsB.weekOfYear - componentsA.weekOfYear + 52 + 1) % 52;
}

- (NSDate *)firstDayOfMonth:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.day = 1;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

- (NSDate *)lastDayOfMonth:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month + 1;
    componentsNewDate.day = 0;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

- (NSDate *)firstWeekDayOfMonth:(NSDate *)date
{
    NSDate *firstDayOfMonth = [self firstDayOfMonth:date];
    return [self firstWeekDayOfWeek:firstDayOfMonth];
}

- (NSDate *)firstWeekDayOfWeek:(NSDate *)date
{
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.weekOfMonth = componentsCurrentDate.weekOfMonth;
    componentsNewDate.weekday = self.calendar.firstWeekday;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] componentsInTimeZone:self.calendar.timeZone fromDate:date];
    components.weekday = self.calendar.firstWeekday;
    if (components.weekday == 1) {
        componentsNewDate.weekOfMonth = componentsCurrentDate.weekOfMonth - 1;
    }
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

- (NSDate *)firstDayOfYear:(NSDate *)date {
    
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year;
    componentsNewDate.month = 1;
//    componentsNewDate.weekOfMonth = 1;
    componentsNewDate.day = 1;
    componentsNewDate.hour = 10;
    return [self.calendar dateFromComponents:componentsNewDate];
}

- (NSDate *)lastDayOfYear:(NSDate *)date {
    
    NSDateComponents *componentsCurrentDate = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday|NSCalendarUnitWeekOfMonth fromDate:date];
    
    NSDateComponents *componentsNewDate = [NSDateComponents new];
    
    componentsNewDate.year = componentsCurrentDate.year + 1;
    componentsNewDate.month = componentsCurrentDate.month;
    componentsNewDate.day = 0;
    
    return [self.calendar dateFromComponents:componentsNewDate];
}

#pragma mark - Comparaison

- (BOOL)date:(NSDate *)dateA isTheSameYearThan:(NSDate *)dateB {
    
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateB];
    return componentsA.year == componentsB.year;
}

- (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:dateB];

    return componentsA.year == componentsB.year && componentsA.month == componentsB.month;
}

- (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB
{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitWeekOfYear fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.weekOfYear == componentsB.weekOfYear;
}

- (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB
{
    if ([dateA isKindOfClass:[NSDate class]] == NO || [dateB isKindOfClass:[NSDate class]] == NO) {
        return NO;
    }
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month && componentsA.day == componentsB.day;
}

- (BOOL)date:(NSDate *)dateA isMoreInOneDaysThan:(NSDate *)dateB{
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    
    return componentsA.year == componentsB.year && componentsA.month == componentsB.month &&(componentsA.day-componentsB.day)<=1;
}

- (BOOL)date:(NSDate *)dateA isMoreInThreeDaysThan:(NSDate *)dateB{
  NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
  NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
  
  return componentsA.year == componentsB.year && componentsA.month == componentsB.month &&(componentsA.day-componentsB.day)<=3;
}

- (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB
{
    
    if([dateA compare:dateB] == NSOrderedAscending){
        return YES;
    }
    
    return NO;
}

- (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB
{
    if([dateA compare:dateB] == NSOrderedDescending){
        return YES;
    }
    
    return NO;
}

- (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate
{
    if([self date:date isEqualOrAfter:startDate] && [self date:date isEqualOrBefore:endDate]){
        return YES;
    }
    
    return NO;
}

- (NSInteger)monthesBetween:(NSDate *)dateA and:(NSDate *)dateB {
    
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    return componentsB.month - componentsA.month + 12 * (componentsB.year - componentsA.year);
}

- (NSInteger)yearsBetween:(NSDate *)dateA and:(NSDate *)dateB {
    NSDateComponents *componentsA = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateA];
    NSDateComponents *componentsB = [self.calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:dateB];
    return componentsB.year - componentsA.year;
}

- (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents    * comp = [calendar components:NSCalendarUnitDay  fromDate:fromDate  toDate:toDate options:NSCalendarWrapComponents];
    return comp.day;
}

@end

