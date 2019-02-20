//
//  CHDatePickerView.h
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CHDatePickerViewDateComponent) {
    /// 年
    CHDatePickerViewDateComponentY,
    /// 月
    CHDatePickerViewDateComponentM,
    /// 日
    CHDatePickerViewDateComponentD,
    /// 时
    CHDatePickerViewDateComponentH,
    /// 分
    CHDatePickerViewDateComponentm,
    /// 秒
    CHDatePickerViewDateComponentS,
};

typedef void(^CHDatePickerViewDidSelectDateBlock)(NSDate *date ,NSDateComponents *dateComponents);

/// 1.年份从1-10000
/// 2.月份从1-12
/// 3.日从1-31(如果月份没有31(2月之类的)选中之后自动滚动到最近的一个日)
/// 4.时0-23
/// 5.分0-59
/// 6.秒0-59

@protocol CHDatePickerViewDelegate <NSObject>

- (void)datePickerViewDidSelectDate:(NSDate *)date dateComponents:(NSDateComponents *)dateComponents;

@end

@interface CHDatePickerView : UIView

/// 日期组成
@property (nonatomic ,strong) NSArray *dateComponents;

/// 确认按钮
@property (nonatomic ,strong) UIButton *buttonConfirm;

/// 取消按钮
@property (nonatomic ,strong) UIButton *buttonCancel;

@property (nonatomic ,strong) NSDateComponents *currentDateComponent;

/// 默认字体大小
@property (nonatomic ,strong) UIFont *textFont;

@property (nonatomic ,strong) UIColor *textColor;

@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode

@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

@property (nonatomic ,copy) CHDatePickerViewDidSelectDateBlock didSelectDateBlock;

@property (nonatomic ,weak) id <CHDatePickerViewDelegate> delegate;

- (void)reloadData;

- (void)show;

- (void)dismiss;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
