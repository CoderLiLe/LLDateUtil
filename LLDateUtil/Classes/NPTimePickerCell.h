//
//  NPYearMonth_DayWeekCell.h
//  Alpha
//
//  Created by LiLe on 2018/4/9.
//  Copyright © 2018年 Alpha. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NPTimePickerType) {
    NPTimePickerTypeYearMonth_DayWeek, // 2018年4月   2日 周一
    NPTimePickerTypeYearMonthDayWeek_Hour_Minute // 18年4月2日 周一   11   32
};

typedef void(^SelectedDateBlock)(NSDate *date);

@interface NPTimePickerCell : UITableViewCell

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier NS_UNAVAILABLE;

/**
 初始化时间选择cell
 
 @param style cell的样式
 @param reuseIdentifier cell重用的标志符
 @param date 原始时间
 @param minDate 选择器的最小时间
 @param maxDate 选择器的最大时间
 @param selectedMinDate 可以选择的最小时间
 @param selectedMaxDate 可以选择的最大时间
 @param timePickerType 时间类型，详见枚举示例
 @param selectedDateBlock 所选择的时间回调
 @return 实例对象
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                   originDate:(NSDate *)date
                      minDate:(NSDate *)minDate
                      maxDate:(NSDate *)maxDate
              selectedMinDate:(NSDate *)selectedMinDate
              selectedMaxDate:(NSDate *)selectedMaxDate
               timePickerType:(NPTimePickerType)timePickerType
            selectedDateBlock:(SelectedDateBlock)selectedDateBlock;

@end
