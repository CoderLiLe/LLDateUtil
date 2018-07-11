//
//  JTDateHelper.h
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import <Foundation/Foundation.h>

@interface JTDateHelper : NSObject

- (NSCalendar *)calendar;
- (NSDateFormatter *)createDateFormatter;

- (NSDate *)addToDate:(NSDate *)date years:(NSInteger)years;
- (NSDate *)addToDate:(NSDate *)date months:(NSInteger)months;
- (NSDate *)addToDate:(NSDate *)date weeks:(NSInteger)weeks;
- (NSDate *)addToDate:(NSDate *)date days:(NSInteger)days;

// Must be less or equal to 6
- (NSUInteger)numberOfWeeks:(NSDate *)date;

- (NSDate *)firstDayOfMonth:(NSDate *)date;
- (NSDate *)lastDayOfMonth:(NSDate *)date;
- (NSDate *)firstWeekDayOfMonth:(NSDate *)date;
- (NSDate *)firstWeekDayOfWeek:(NSDate *)date;
- (NSDate *)firstDayOfYear:(NSDate *)date;
- (NSDate *)lastDayOfYear:(NSDate *)date;

- (BOOL)date:(NSDate *)dateA isTheSameYearThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameMonthThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameWeekThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isTheSameDayThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isMoreInOneDaysThan:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isMoreInThreeDaysThan:(NSDate *)dateB;

- (BOOL)date:(NSDate *)dateA isEqualOrBefore:(NSDate *)dateB;
- (BOOL)date:(NSDate *)dateA isEqualOrAfter:(NSDate *)dateB;
- (BOOL)date:(NSDate *)date isEqualOrAfter:(NSDate *)startDate andEqualOrBefore:(NSDate *)endDate;

- (NSInteger)monthesBetween:(NSDate *)dateA and:(NSDate *)dateB;
- (NSInteger)yearsBetween:(NSDate *)dateA and:(NSDate *)dateB;
- (NSInteger)numberOfDaysWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;//两个日期之间相差的天数
@end
