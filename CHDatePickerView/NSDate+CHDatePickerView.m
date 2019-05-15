//
//  NSDate+CHDatePickerView.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "NSDate+CHDatePickerView.h"

@implementation NSDate (CHDatePickerView)

static const NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;

/// 年
+ (NSDate *)ch_setYear:(NSInteger)year {
    return [self ch_setYear:year month:1];
}

/// 年/月
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month {
    return [self ch_setYear:year month:month day:1];
}

/// 年/月/日
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self ch_setYear:year month:month day:day hour:0];
}

/// 年/月/日/时
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour {
    return [self ch_setYear:year month:month day:day hour:hour minute:0];
}

/// 年/月/日/时/分
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self ch_setYear:year month:month day:day hour:hour minute:minute second:0];
}

/// 年/月/日/时/分/秒
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    /// 通过日历类获取compoents
    NSDate *date = [NSDate date];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *compoents = [currentCalendar components:units fromDate:date];
    [compoents setYear:year];
    [compoents setMonth:month];
    [compoents setDay:day];
    [compoents setHour:hour];
    [compoents setMinute:minute];
    [compoents setSecond:second];
    return [currentCalendar dateFromComponents:compoents];
}

- (NSDateComponents *)ch_getComponents {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:units fromDate:self];
    return dateComponents;
}

- (NSInteger)ch_getDays {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSRange range = [currentCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return range.length;
}

@end
