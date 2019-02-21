//
//  NSDate+CHCategory.h
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CHCategory)

/// 年
+ (NSDate *)ch_setYear:(NSInteger)year;

/// 年/月
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month;

/// 年/月/日
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/// 年/月/日/时
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour;

/// 年/月/日/时/分
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;

/// 年/月/日/时/分/秒
+ (NSDate *)ch_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/// 获取当前的年月日时分秒
- (NSDateComponents *)ch_getComponents;

/// 获取当前月份多少天
- (NSInteger)ch_getDays;

@end
