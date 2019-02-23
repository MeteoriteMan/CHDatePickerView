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
    CHDatePickerViewDateComponents,
};

typedef NS_ENUM(NSUInteger, CHDatePickerViewDateStyle) {
    /// 年月日时分秒
    CHDatePickerViewDateStyleYMDHms,
    /// 年月日时分
    CHDatePickerViewDateStyleYMDHm,
    /// 年月日时
    CHDatePickerViewDateStyleYMDH,
    /// 年月日
    CHDatePickerViewDateStyleYMD,
    /// 年月
    CHDatePickerViewDateStyleYM,
    /// 年
    CHDatePickerViewDateStyleY,
    /// 月日时分秒
    CHDatePickerViewDateStyleMDHms,
    /// 月日时分
    CHDatePickerViewDateStyleMDHm,
    /// 月日时分
    CHDatePickerViewDateStyleMDH,
    /// 月日
    CHDatePickerViewDateStyleMD,
    /// 月
    CHDatePickerViewDateStyleM,
    /// 日时分秒
    CHDatePickerViewDateStyleDHms,
    /// 日时分
    CHDatePickerViewDateStyleDHm,
    /// 日时
    CHDatePickerViewDateStyleDH,
    /// 日
    CHDatePickerViewDateStyleD,
    /// 时分秒
    CHDatePickerViewDateStyleHms,
    /// 时分
    CHDatePickerViewDateStyleHm,
    /// 时
    CHDatePickerViewDateStyleH,
    /// 分秒
    CHDatePickerViewDateStylems,
    /// 分
    CHDatePickerViewDateStylem,
    /// 秒
    CHDatePickerViewDateStyles,
};

typedef void(^CHDatePickerViewDidSelectDateBlock)(NSDate *date ,NSDateComponents *dateComponents);

/// 1.年份从1-10000
/// 2.月份从1-12
/// 3.日从1-31(如果月份没有31(2月之类的)选中之后自动滚动到最近的一个日,仿苹果UIDatePicker效果)
/// 4.时0-23
/// 5.分0-59
/// 6.秒0-59

@protocol CHDatePickerViewDelegate <NSObject>

@optional
- (void)datePickerViewDidSelectDate:(NSDate *)date dateComponents:(NSDateComponents *)dateComponents;

@end

@interface CHDatePickerView : UIView

/// 手动设置排列方式
@property (nonatomic ,strong) NSArray *dateComponents;

/// 快速设置排列方式(内置年月日)
@property (nonatomic ,assign) CHDatePickerViewDateStyle dateStyle;

@property (nonatomic ,weak) id <CHDatePickerViewDelegate> delegate;

@property (nonatomic ,copy) CHDatePickerViewDidSelectDateBlock didSelectDateBlock;

/// 按钮背景板
@property (nonatomic ,strong) UIView *viewButtonBackground;

/// 按钮背景板底部线 default color is nil
@property (nonatomic ,strong) UIView *viewButtonBackgroundBottomLine;

/// 确认按钮
@property (nonatomic ,strong) UIButton *buttonConfirm;

/// 取消按钮
@property (nonatomic ,strong) UIButton *buttonCancel;

/// 字体大小
@property (nonatomic ,strong) UIFont *textFont;

/// 文字颜色
@property (nonatomic ,strong) UIColor *textColor;

// 默认的选中时间.默认为当前时间[NSDate date]
@property (nonatomic, strong) NSDate *date;

/// 允许选中的最小时间
@property (nullable, nonatomic, strong) NSDate *minimumDate; // default is nil

/// 允许选中的最大时间
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

/// 是否datePickerView显示分割线
@property (nonatomic ,assign) BOOL pickerViewSeparatorHidden;

/// datePickerView分割线颜色
@property (nonatomic ,strong) UIColor *pickerViewSeparatorColor;

/// 允许tap手势使pickerView隐藏
@property (nonatomic ,assign) BOOL allowTapToDissmiss;

- (void)show;

- (void)dismiss;

- (void)setDate:(NSDate *)date animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
