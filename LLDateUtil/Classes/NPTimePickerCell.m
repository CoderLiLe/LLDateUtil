//
//  NPTimePickerCell.m
//  Alpha
//
//  Created by LiLe on 2018/4/9.
//  Copyright © 2018年 Alpha. All rights reserved.
//

#import "NPTimePickerCell.h"
#import "CustomDateFormatter.h"
#import "JTDateHelper.h"
#import "NSDate+NPExtension.h"

static CGFloat const kDayWeekViewWidth = 120;
static CGFloat const kHourOrMinuteViewWidth = 80;

static NSString *const YYYYMM = @"yyyy年M月";
static NSString *const DAYWEEK = @"d日 eee";

@interface NPTimePickerCell() <UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic, assign) NPTimePickerType timePickerType;
@property (nonatomic, strong) UIPickerView *datePickerView;
@property (nonatomic, strong) SelectedDateBlock selectedDateBlock;
@property (nonatomic, strong) JTDateHelper *dateHelper;
@property (nonatomic, strong) CustomDateFormatter *cusDateFormatter;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *selectedMinDate;
@property (nonatomic, strong) NSDate *selectedMaxDate;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSDate *originDate;

@property (nonatomic, assign) NSInteger selectedMinFirstComponent;
@property (nonatomic, assign) NSInteger selectedMinSecondComponent;
@property (nonatomic, assign) NSInteger selectedMaxFirstComponent;
@property (nonatomic, assign) NSInteger selectedMaxSecondComponent;

/******************** NPTimePickerTypeYearMonth_DayWeek ********************/
@property (nonatomic, strong) NSMutableArray *yearMonthArr;
@property (nonatomic, strong) NSMutableArray *dayWeekArr;
@property (nonatomic, copy) NSString *selectedYearMonth;
@property (nonatomic, copy) NSString *selectedDayWeek;

/******************** NPTimePickerTypeYearMonthDayWeek_Hour_Minute ********************/
@property (nonatomic, strong) NSMutableArray *yearMonthDayWeekArr;
@property (nonatomic, strong) NSMutableArray *HourArr;
@property (nonatomic, strong) NSMutableArray *minuteArr;
@property (nonatomic, copy) NSString *selectedYMDW;
@property (nonatomic, copy) NSString *selectedHour;
@property (nonatomic, copy) NSString *selectedMinute;
@end

@implementation NPTimePickerCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                   originDate:(NSDate *)date
                      minDate:(NSDate *)minDate
                      maxDate:(NSDate *)maxDate
              selectedMinDate:(NSDate *)selectedMinDate
              selectedMaxDate:(NSDate *)selectedMaxDate
               timePickerType:(NPTimePickerType)timePickerType
            selectedDateBlock:(SelectedDateBlock)selectedDateBlock
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _originDate = date;
        _minDate = minDate;
        _maxDate = maxDate;
        _selectedMinDate = selectedMinDate;
        _selectedMaxDate = selectedMaxDate;
        _timePickerType = timePickerType;
        _selectedDateBlock = selectedDateBlock;
        
        [self initDates];
        [self initSubviews];
        [self dataBinding];
    }
    return self;
}

- (void)initDates {
    if (!_minDate) {
        _minDate = [CustomDateFormatter dateFromString:@"2015-01-01" format:@"YYYY-MM-dd"];
    }
    if (!_maxDate) {
        _maxDate = [NSDate date];
    }
    if (!_originDate) {
        _originDate = [NSDate date];
    }
    
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.datePickerView.frame = self.bounds;
}

#pragma mark - init subviews
- (void)initSubviews
{
    _datePickerView = [[UIPickerView alloc] init];
    _datePickerView.backgroundColor = [UIColor whiteColor];
    _datePickerView.delegate = self;
    _datePickerView.dataSource = self;
    [self.contentView addSubview:_datePickerView];
}

#pragma mark - data bind
- (void)dataBinding {
    _dateHelper = [[JTDateHelper alloc] init];
    _cusDateFormatter = [[CustomDateFormatter alloc] init];
    
    if (_timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
        [self initYearMonth_DayWeekProperties];
    } else {
        [self initYearMonthDayWeek_Hour_MinuteProperties];
    }
}

- (void)initYearMonth_DayWeekProperties
{
    self.yearMonthArr = [NSMutableArray array];
    self.dayWeekArr = [NSMutableArray array];
    
    NSDate * beginDate = _minDate;
    
    [_cusDateFormatter setDateFormat:YYYYMM];
    NSString * selectDate = [_cusDateFormatter stringFromDate:_originDate];
    NSInteger rangeMonth = [_dateHelper monthesBetween:_minDate and:_maxDate];
    for (int i = 0; i < rangeMonth; i++) {
        NSDate * nextMonthDate = nil;
        if (i == 0) {
            nextMonthDate = beginDate;
        } else {
            nextMonthDate = [beginDate getPriousorLaterDateFromDate:beginDate withMonth:1];
        }
        beginDate = nextMonthDate;
        NSString *nextMontStr = [_cusDateFormatter stringFromDate:nextMonthDate];
        [self.yearMonthArr addObject:nextMontStr];
        
        if ([nextMontStr isEqualToString:selectDate]) {
            self.selectedYearMonth = nextMontStr;
            [self configDayWeekDateArrWithDate:_originDate];
            [self.datePickerView selectRow:i inComponent:0 animated:YES];
        }
        
        if (self.selectedMinDate) {
            NSString *selectedMinDateStr = [_cusDateFormatter stringFromDate:self.selectedMinDate];
            if ([nextMontStr isEqualToString:selectedMinDateStr]) {
                self.selectedMinFirstComponent = i;
            }
        }
        
        if (self.selectedMaxDate) {
            NSString *selectedMaxDateStr = [_cusDateFormatter stringFromDate:self.selectedMaxDate];
            if ([nextMontStr isEqualToString:selectedMaxDateStr]) {
                self.selectedMaxFirstComponent = i;
            }
        }
    }
    
    CustomDateFormatter *dateFor = [CustomDateFormatter new];
    [dateFor setDateFormat:@"d日 eee"];
    for (int i = 0; i < self.dayWeekArr.count; i++) {
        NSString *dayWeekStr = self.dayWeekArr[i];
        if ([dayWeekStr isEqualToString:[dateFor stringFromDate:self.originDate]]) {
            self.selectedDayWeek = dayWeekStr;
            [self.datePickerView selectRow:i inComponent:1 animated:YES];
            break;
        }
    }
}

- (void)initYearMonthDayWeek_Hour_MinuteProperties
{
    self.yearMonthDayWeekArr = [NSMutableArray array];
    self.HourArr = [NSMutableArray arrayWithCapacity:24];
    self.minuteArr = [NSMutableArray arrayWithCapacity:60];
    
    NSDate *beginDate = [CustomDateFormatter dateFromString:@"2015-01-01" format:@"YYYY-MM-dd"];
    NSDate *currentDate = [NSDate date];
    
    [_cusDateFormatter setYY_MM_dd_Week_show];
    NSInteger rangeDay = [_dateHelper numberOfDaysWithFromDate:beginDate toDate:currentDate];
    for(int i = 0 ; i < rangeDay+365; i ++){
        NSDate *nextDayDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:beginDate];
        beginDate = nextDayDate;
        NSString *YMDWStr = [_cusDateFormatter stringFromDate:nextDayDate];
        [self.yearMonthDayWeekArr addObject:YMDWStr];
        
        if ([nextDayDate isToday]) {
            self.selectedYMDW = YMDWStr;
            [self.datePickerView selectRow:i inComponent:0 animated:YES];
        }
    }
    
    for(int i = 0 ; i < 60 ; i++){
        if(i<24) {
            [self.HourArr addObject:[@(i) stringValue]];
        }
        [self.minuteArr addObject:[@(i) stringValue]];
    }
    
    [self.datePickerView reloadAllComponents];
    CustomDateFormatter *dateFor = [[CustomDateFormatter alloc] init];
    [dateFor setDateFormat:@"HH:mm"];
    NSString *hourMinute = [dateFor stringFromDate:self.originDate];
    NSArray *hourMinuteArr = [hourMinute componentsSeparatedByString:@":"];
    self.selectedHour = [hourMinuteArr firstObject];
    self.selectedMinute = [hourMinuteArr lastObject];
    [self.datePickerView selectRow:[self.selectedHour integerValue] inComponent:1 animated:YES];
    [self.datePickerView selectRow:[self.selectedMinute integerValue] inComponent:2 animated:YES];
}

#pragma mark - pick view delege
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
        return 2;
    } else if (self.timePickerType == NPTimePickerTypeYearMonthDayWeek_Hour_Minute) {
        return 3;
    } else {
        NSAssert(NO, @"有新的日期选择类型需要处理");
    }
    return 0;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
        if (0 == component) {
            return self.yearMonthArr.count;
        } else {
            NSInteger selectedRow = [self.datePickerView selectedRowInComponent:component];
            NSString *selectedDateStr = self.yearMonthArr[selectedRow];
            [_cusDateFormatter setDateFormat:YYYYMM];
            NSDate *selectedDate = [_cusDateFormatter dateFromString:selectedDateStr];
            return [selectedDate getNumberOfDaysInMonth];
        }
    } else if (self.timePickerType == NPTimePickerTypeYearMonthDayWeek_Hour_Minute) {
        if (0 == component) {
            return self.yearMonthDayWeekArr.count;
        } else if (1 == component) {
            return self.HourArr.count;
        } else {
            return self.minuteArr.count;
        }
    }  else {
        NSAssert(NO, @"有新的日期选择类型需要处理");
    }
    return 0;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 30.0f;
}

- (CGFloat) pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
        if (0 == component) {
            return self.contentView.frame.size.width - kDayWeekViewWidth*2;
        } else {
            return kDayWeekViewWidth;
        }
    } else if (self.timePickerType == NPTimePickerTypeYearMonthDayWeek_Hour_Minute) {
        if (0 == component) {
            return self.contentView.frame.size.width - kHourOrMinuteViewWidth*2;
        }
        return kHourOrMinuteViewWidth;
    } else {
        NSAssert(NO, @"有新的日期选择类型需要处理");
    }
    return 0.0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (!view){
        view = [[UIView alloc]init];
    }
    
    if (self.timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
        return [self yearMonth_DayWeekViewForRow:row forComponent:component reusingView:view];
    } else if (self.timePickerType == NPTimePickerTypeYearMonthDayWeek_Hour_Minute) {
        return [self yearMonthDayWeek_Hour_MinuteViewForRow:row forComponent:component reusingView:view];
    } else {
        NSAssert(NO, @"有新的日期选择类型需要处理");
    }
    return [UIView new];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
        
        switch (component) {
            case 0:
            {
                self.selectedYearMonth = self.yearMonthArr[row];
                [_cusDateFormatter setDateFormat:YYYYMM];
                NSDate *yearMonthDate = [_cusDateFormatter dateFromString:self.selectedYearMonth];
                [self configDayWeekDateArrWithDate:yearMonthDate];
                [pickerView reloadAllComponents];
                self.currentDate = yearMonthDate;
                [self handleSelectedMinMaxDate];
            }
                break;
            case 1:
            {
                self.selectedDayWeek = self.dayWeekArr[row];
                NSString *yearMonthDayWeekStr = [NSString stringWithFormat:@"%@ %@", self.selectedYearMonth, self.selectedDayWeek];
                [_cusDateFormatter setDateFormat:[NSString stringWithFormat:@"%@ %@", YYYYMM, DAYWEEK]];
                self.currentDate = [_cusDateFormatter dateFromString:yearMonthDayWeekStr];
                [self handleSelectedMinMaxDate];
            }
                break;
            default:
                break;
        }
        
        [_cusDateFormatter setYY_MM_dd_HH_mm_show];
    } else if (self.timePickerType == NPTimePickerTypeYearMonthDayWeek_Hour_Minute) {
        switch (component) {
            case 0:
            {
                self.selectedYMDW = self.yearMonthDayWeekArr[row];
            }
                break;
            case 1:
            {
                self.selectedHour = self.HourArr[row];
            }
                break;
            case 2:
            {
                self.selectedMinute = self.minuteArr[row];
            }
                break;
            default:
                break;
        }
    } else {
        NSAssert(NO, @"有新的日期选择类型需要处理");
    }
    
    [self setSelectedDate];
}

- (UIView *)yearMonth_DayWeekViewForRow:(NSInteger)row forComponent:(NSInteger)component  reusingView:(UIView *)view
{
    double cellWidth =component == 0 ? self.contentView.frame.size.width - kDayWeekViewWidth*2 : kDayWeekViewWidth;
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cellWidth, 30)];
    text.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
        {
            text.text = self.yearMonthArr[row];
        }
            break;
        case 1:
        {
            text.text = self.dayWeekArr[row];
        }
            break;
        default:
            break;
    }
    [view addSubview:text];
    return view;
}

- (UIView *)yearMonthDayWeek_Hour_MinuteViewForRow:(NSInteger)row forComponent:(NSInteger)component  reusingView:(UIView *)view
{
    double cellWidth =component == 0? self.contentView.frame.size.width - kHourOrMinuteViewWidth*2 : kHourOrMinuteViewWidth;
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, cellWidth, 30)];
    text.textAlignment = NSTextAlignmentCenter;
    switch (component) {
        case 0:
        {
            text.text = self.yearMonthDayWeekArr[row];
        }
            break;
        case 1:
        {
            text.text = self.HourArr[row];
        }
            break;
        case 2:
        {
            text.text = self.minuteArr[row];
        }
            break;
        default:
            break;
    }
    [view addSubview:text];
    return view;
}

#pragma mark - private method
- (void)configDayWeekDateArrWithDate:(NSDate *)date
{
    [self.dayWeekArr removeAllObjects];
    NSDate *dayWeekDate = [self.dateHelper firstDayOfMonth:date];
    [_cusDateFormatter setDateFormat:DAYWEEK];
    [self.dayWeekArr addObject:[_cusDateFormatter stringFromDate:dayWeekDate]];
    
    NSInteger daysOfMonth = [dayWeekDate getNumberOfDaysInMonth];
    for (int i = 0; i < daysOfMonth-1; i++) {
        NSDate *nextDate = [dayWeekDate getPriousorLaterDateFromDate:dayWeekDate withDay:1];
        [self.dayWeekArr addObject:[_cusDateFormatter stringFromDate:nextDate]];
        dayWeekDate = nextDate;
        
        if (self.selectedMinDate) {
            NSString *dayWeekStr = [_cusDateFormatter stringFromDate:nextDate];
            NSString *selectedMinDayWeekStr = [_cusDateFormatter stringFromDate:self.selectedMinDate];
            if ([dayWeekStr isEqualToString:selectedMinDayWeekStr]) {
                self.selectedMinSecondComponent = i;
            }
        }
        
        if (self.selectedMaxDate) {
            NSString *dayWeekStr = [_cusDateFormatter stringFromDate:nextDate];
            NSString *selectedMinDayWeekStr = [_cusDateFormatter stringFromDate:self.selectedMaxDate];
            if ([dayWeekStr isEqualToString:selectedMinDayWeekStr]) {
                self.selectedMaxSecondComponent = i;
            }
        }
    }
}

- (void)setSelectedDate
{
    if (self.selectedDateBlock) {
        NSString *selectedDateStr, *dateFormat;
        if (_timePickerType == NPTimePickerTypeYearMonth_DayWeek) {
            NSArray * tmpArray = [self.selectedDayWeek componentsSeparatedByString:@" "];
            if (tmpArray.count > 0) {
                selectedDateStr = [NSString stringWithFormat:@"%@%@", self.selectedYearMonth, [tmpArray firstObject]];
                dateFormat = [NSString stringWithFormat:@"%@d日", YYYYMM];
            }
        } else if (_timePickerType == NPTimePickerTypeYearMonthDayWeek_Hour_Minute) {
            selectedDateStr = [NSString stringWithFormat:@"%@ %@:%@", self.selectedYMDW, self.selectedHour, self.selectedMinute];
            dateFormat = @"yy年M月d日 eee HH:mm";
        } else {
            NSAssert(NO, @"有新的日期选择类型需要处理");
        }
        
        if (selectedDateStr) {
            NSDate *selectedDate = [CustomDateFormatter dateFromString:selectedDateStr format:dateFormat];
            self.selectedDateBlock(selectedDate);
        }
    }
}

- (void)handleSelectedMinMaxDate
{
    if (self.selectedMinDate &&  [self.dateHelper date:_currentDate isEqualOrBefore:self.selectedMinDate]) {
        [self rollPickerRowToDate:self.selectedMinDate];
    }
    
    if (self.selectedMaxDate && [self.dateHelper date:_currentDate isEqualOrAfter:self.selectedMaxDate]) {
        [self rollPickerRowToDate:self.selectedMaxDate];
    }
}

/// pickerview选择当前时间
- (void)rollPickerRowToDate:(NSDate *)date {
    _currentDate = date;
    [_datePickerView selectRow:[self rowOfDate:date] inComponent:0 animated:YES];
    [self configDayWeekDateArrWithDate:date];
    if (self.selectedMinDate) {
        [_datePickerView selectRow:(self.selectedMinSecondComponent+1) inComponent:1 animated:YES];
    }
}

/// 根据日期返回Com为0的row
- (NSInteger)rowOfDate:(NSDate *)date{
    [_cusDateFormatter setDateFormat:YYYYMM];
    NSString *valueStr = [_cusDateFormatter stringFromDate:date];
    
    for(int i = 0 ; i < self.yearMonthArr.count ; i++){
        NSString *dateStr = self.yearMonthArr[i];
        if ([valueStr isEqualToString:dateStr])
        {
            return i;
        }
    }
    return (self.yearMonthArr.count - 1);
}

@end
