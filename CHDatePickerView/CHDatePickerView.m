//
//  CHDatePickerView.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "CHDatePickerView.h"
#import "Masonry.h"
#import "NSDate+CHCategory.h"
#import "NSBundle+CHDatePicker.h"
#import "CHPickerView.h"

@interface CHDatePickerView () <UIPickerViewDataSource ,UIPickerViewDelegate>

@property (nonatomic ,strong) UIView *viewShade;

@property (nonatomic ,strong) UITapGestureRecognizer *viewShadeTap;

/// 白色背景板
@property (nonatomic ,strong) UIView *viewBottom;

@property (nonatomic ,strong) CHPickerView *pickerView;

/// 当前选中日期
@property (nonatomic ,strong) NSDate *selectDate;

/// MARK: DataSource

/// 年 1 - 10000
@property (nonatomic ,strong) NSArray <NSNumber *> *years;

/// 月 1 - 12
@property (nonatomic ,strong) NSArray <NSNumber *> *months;

/// 日 1 - 31(月份不足31的选中之后自动返回)
@property (nonatomic ,strong) NSArray <NSNumber *> *days;

/// 时 0 - 23
@property (nonatomic ,strong) NSArray <NSNumber *> *hours;

/// 分 0 - 59
@property (nonatomic ,strong) NSArray <NSNumber *> *minutes;

/// 秒 0 -59
@property (nonatomic ,strong) NSArray <NSNumber *> *seconds;

/// shortHours 0 - 11
@property (nonatomic ,strong) NSArray <NSNumber *> *hoursShorts;

/// AM/PM 0 - 1
@property (nonatomic ,strong) NSArray <NSNumber *> *AMPMs;

@end

@implementation CHDatePickerView {
    NSDate *_date;
}

// MARK: getter

- (UIFont *)textFont {
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:14];
    }
    return _textFont;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor darkTextColor];
    }
    return _textColor;
}

- (NSDate *)date {
    if (!_date) {
        _date = [NSDate date];
    }
    return _date;
}

- (BOOL)isPickerViewSeparatorHidden {
    return self.pickerView.pickerViewSeparatorHidden;
}

// MARK: setter

- (void)setDateStyle:(CHDatePickerViewDateStyle)dateStyle {
    _dateStyle = dateStyle;
    switch (dateStyle) {
        case CHDatePickerViewDateStyleYMDHms:/// 年月日时分秒
            self.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
            break;
        case CHDatePickerViewDateStyleYMDHm:/// 年月日时分
            self.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm)];
            break;
        case CHDatePickerViewDateStyleYMDH:/// 年月日时
            self.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH)];
            break;
        case CHDatePickerViewDateStyleYMD: /// 年月日
            self.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD)];
            break;
        case CHDatePickerViewDateStyleYM:/// 年月
            self.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM)];
            break;
        case CHDatePickerViewDateStyleY:/// 年
            self.dateComponents = @[@(CHDatePickerViewDateComponentY)];
            break;
        case CHDatePickerViewDateStyleMDHms:/// 月日时分秒
            self.dateComponents = @[@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
            break;
        case CHDatePickerViewDateStyleMDHm:/// 月日时分
            self.dateComponents = @[@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm)];
            break;
        case CHDatePickerViewDateStyleMDH:/// 月日时
            self.dateComponents = @[@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH)];
            break;
        case CHDatePickerViewDateStyleMD:/// 月日
            self.dateComponents = @[@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD)];
            break;
        case CHDatePickerViewDateStyleM:/// 月日
            self.dateComponents = @[@(CHDatePickerViewDateComponentM)];
            break;
        case CHDatePickerViewDateStyleDHms:/// 日时分秒
            self.dateComponents = @[@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
            break;
        case CHDatePickerViewDateStyleDHm:/// 日时分
            self.dateComponents = @[@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm)];
            break;
        case CHDatePickerViewDateStyleDH:/// 日时
            self.dateComponents = @[@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH)];
            break;
        case CHDatePickerViewDateStyleD:/// 日
            self.dateComponents = @[@(CHDatePickerViewDateComponentD)];
            break;
        case CHDatePickerViewDateStyleHms:/// 时分秒
            self.dateComponents = @[@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
            break;
        case CHDatePickerViewDateStyleHm:/// 时分
            self.dateComponents = @[@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm)];
            break;
        case CHDatePickerViewDateStyleH:/// 时
            self.dateComponents = @[@(CHDatePickerViewDateComponentH)];
            break;
        case CHDatePickerViewDateStylems:/// 分秒
            self.dateComponents = @[@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
            break;
        case CHDatePickerViewDateStylem:/// 分
            self.dateComponents = @[@(CHDatePickerViewDateComponentm)];
            break;
        case CHDatePickerViewDateStyles:/// 秒
            self.dateComponents = @[@(CHDatePickerViewDateComponents)];
            break;
        default:
            break;
    }
}

- (void)setDateComponents:(NSArray *)dateComponents {
    _dateComponents = dateComponents;
    [self reloadData];
}

- (void)setPickerViewSeparatorHidden:(BOOL)pickerViewSeparatorHidden {
    self.pickerView.pickerViewSeparatorHidden = pickerViewSeparatorHidden;
}

- (void)setPickerViewSeparatorColor:(UIColor *)pickerViewSeparatorColor {
    self.pickerView.pickerViewSeparatorColor = pickerViewSeparatorColor;
}

- (void)setDate:(NSDate *)date {
    _date = date;
    [self setDate:date animated:YES];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupConfig];
        [self setupUI];
    }
    return self;
}

- (void)setupConfig {

    /// 设置默认日期选择器模式
    self.dateStyle = CHDatePickerViewDateStyleYMD;
    self.allowTapToDissmiss = YES;
    /// 年
    NSMutableArray *arrayYearsM = [NSMutableArray array];
    for (int i = 1; i < 10001; i++) {
        [arrayYearsM addObject:[NSNumber numberWithInteger:i]];
    }
    self.years = arrayYearsM.copy;
    /// 月
    NSMutableArray *arrayMonthsM = [NSMutableArray array];
    for (int i = 1; i < 13; i++) {
        [arrayMonthsM addObject:[NSNumber numberWithInteger:i]];
    }
    self.months = arrayMonthsM.copy;
    /// 日
    NSMutableArray *arrayDaysM = [NSMutableArray array];
    for (int i = 1; i < 32; i++) {
        [arrayDaysM addObject:[NSNumber numberWithInteger:i]];
    }
    self.days = arrayDaysM.copy;
    /// 时
    NSMutableArray *arrayHoursM = [NSMutableArray array];
    for (int i = 0; i < 24; i++) {
        [arrayHoursM addObject:[NSNumber numberWithInteger:i]];
    }
    self.hours = arrayHoursM.copy;
    /// 分
    NSMutableArray *arrayMinutesM = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        [arrayMinutesM addObject:[NSNumber numberWithInteger:i]];
    }
    self.minutes = arrayMinutesM.copy;
    /// 秒
    NSMutableArray *arraySecondsM = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        [arraySecondsM addObject:[NSNumber numberWithInteger:i]];
    }
    self.seconds = arraySecondsM.copy;
    /// 12小时制
    NSMutableArray *arrayHoursShortsM = [NSMutableArray array];
    for (int i = 0; i < 12; i++) {
        [arrayHoursShortsM addObject:[NSNumber numberWithInt:i]];
    }
    self.hoursShorts = arrayHoursShortsM.copy;
    NSMutableArray *arrayAMPMsM = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        [arrayAMPMsM addObject:[NSNumber numberWithInt:i]];
    }
    self.AMPMs = arrayAMPMsM.copy;

}

- (void)setupUI {
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.hidden = YES;
    self.viewShade = [UIView new];
    self.viewShade.backgroundColor = [UIColor clearColor];
    [self addSubview:self.viewShade];
    [self.viewShade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.viewShadeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewShadeTap:)];
    [self.viewShade addGestureRecognizer:self.viewShadeTap];
    self.viewBottom = [UIView new];
    self.viewBottom.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBottom];
    [self.viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.right.offset(0);
    }];
    self.viewButtonBackground = [UIView new];
    self.viewButtonBackground.backgroundColor = [UIColor whiteColor];
    [self.viewBottom addSubview:self.viewButtonBackground];
    [self.viewButtonBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(44);
    }];
    self.buttonConfirm = [UIButton new];
    [self.buttonConfirm setTitle:[NSBundle ch_localizedStringForKey:@"Confirm"] forState:UIControlStateNormal];
    self.buttonConfirm.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.buttonConfirm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.viewButtonBackground addSubview:self.buttonConfirm];
    [self.buttonConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.right.equalTo(self.viewButtonBackground.mas_safeAreaLayoutGuideRight).offset(-13);
        } else {
            make.right.offset(-13);
        }
        make.top.bottom.offset(0);
    }];
    self.buttonCancel = [UIButton new];
    [self.buttonCancel setTitle:[NSBundle ch_localizedStringForKey:@"Cancel"] forState:UIControlStateNormal];
    self.buttonCancel.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.buttonCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.viewButtonBackground addSubview:self.buttonCancel];
    [self.buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.viewButtonBackground.mas_safeAreaLayoutGuideLeft).offset(13);
        } else {
            make.left.offset(13);
        }
        make.top.bottom.offset(0);
    }];
    self.viewButtonBackgroundBottomLine = [UIView new];
    [self.viewButtonBackground addSubview:self.viewButtonBackgroundBottomLine];
    [self.viewButtonBackgroundBottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.mas_equalTo([NSNumber numberWithFloat:.5]);
    }];
    self.pickerView = [[CHPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.viewBottom addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewButtonBackground.mas_bottom);
        make.height.offset(220);
        if (@available(iOS 11.0, *)) {
            make.left.equalTo(self.viewBottom.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.viewBottom.mas_safeAreaLayoutGuideRight);
            make.bottom.equalTo(self.viewBottom.mas_safeAreaLayoutGuideBottom);
        } else {
            make.left.right.offset(0);
            make.bottom.offset(0);
        }
    }];
    [self.buttonConfirm addTarget:self action:@selector(buttonConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonCancel addTarget:self action:@selector(buttonCancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self layoutIfNeeded];
}

- (void)reloadData {
    [self.pickerView reloadAllComponents];
    [self refreshPickerViewWithDateComponents:[self.date ch_getComponents] animated:NO];
    [self refreshSelectDate];
}

// MARK: UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.dateComponents.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSNumber *dateComponent = self.dateComponents[component];
    CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
    switch (ch_component) {
        case CHDatePickerViewDateComponentY:
            return self.years.count;
            break;
        case CHDatePickerViewDateComponentM:
            return self.months.count;
            break;
        case CHDatePickerViewDateComponentD:
            return self.days.count;
            break;
        case CHDatePickerViewDateComponentH:
            return self.hours.count;
            break;
        case CHDatePickerViewDateComponentm:
            return self.minutes.count;
            break;
        case CHDatePickerViewDateComponents:
            return self.seconds.count;
            break;
        case CHDatePickerViewDateComponentHShort:
            return self.hoursShorts.count;
            break;
        case CHDatePickerViewDateComponentAMPMS:
            return self.AMPMs.count;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *label = [[UILabel alloc] init];
    label.font = self.textFont;
    label.textColor = self.textColor;
    label.textAlignment = NSTextAlignmentCenter;
    NSString *text = @"";
    NSNumber *dateComponent = self.dateComponents[component];
    CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
    switch (ch_component) {
        case CHDatePickerViewDateComponentY:
            text = [NSString stringWithFormat:@"%@%@",self.years[row], [NSBundle ch_localizedStringForKey:@"YearStr"]];
            break;
        case CHDatePickerViewDateComponentM:
            text = [NSString stringWithFormat:@"%@%@",self.months[row], [NSBundle ch_localizedStringForKey:@"MonthStr"]];
            break;
        case CHDatePickerViewDateComponentD:
            text = [NSString stringWithFormat:@"%@%@",self.days[row], [NSBundle ch_localizedStringForKey:@"DayStr"]];
            break;
        case CHDatePickerViewDateComponentH:
            text = [NSString stringWithFormat:@"%@%@",self.hours[row], [NSBundle ch_localizedStringForKey:@"HourStr"]];
            break;
        case CHDatePickerViewDateComponentm:
            text = [NSString stringWithFormat:@"%@%@",self.minutes[row], [NSBundle ch_localizedStringForKey:@"MinuteStr"]];
            break;
        case CHDatePickerViewDateComponents:
            text = [NSString stringWithFormat:@"%@%@",self.seconds[row], [NSBundle ch_localizedStringForKey:@"SecondStr"]];
            break;
        case CHDatePickerViewDateComponentHShort:
            text = [NSString stringWithFormat:@"%@%@",self.hoursShorts[row], [NSBundle ch_localizedStringForKey:@"HourStr"]];
            break;
        case CHDatePickerViewDateComponentAMPMS:
            text = [self.AMPMs[row] integerValue]==1?[NSBundle ch_localizedStringForKey:@"PM"]:[NSBundle ch_localizedStringForKey:@"AM"];
            break;
        default:
            text = @"";
            break;
    }
    label.text = text;
    return label;
}

// MARK: UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [self refreshSelectDate];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

// MARK: Action
- (void)buttonConfirmClick:(UIButton *)sender {
    [self refreshSelectDate];
    /// Block
    if (self.didSelectDateBlock) {
        self.didSelectDateBlock(self.selectDate ,[self.selectDate ch_getComponents]);
    }
    /// Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(datePickerViewDidSelectDate:dateComponents:)]) {
        [self.delegate datePickerViewDidSelectDate:self.selectDate dateComponents:[self.selectDate ch_getComponents]];
    }
    [self dismiss];
}

- (void)buttonCancelClick:(UIButton *)sender {
    [self dismiss];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
    _date = date;
    BOOL minDate = NO;
    BOOL maxDate = NO;
    if (!self.minimumDate || date.timeIntervalSince1970 > self.minimumDate.timeIntervalSince1970) {
        minDate = YES;
    }
    if (!self.maximumDate || date.timeIntervalSince1970 < self.maximumDate.timeIntervalSince1970) {
        maxDate = YES;
    }
    if (minDate && maxDate) {
        NSDateComponents *dateComponents = [date ch_getComponents];
        [self refreshPickerViewWithDateComponents:dateComponents animated:animated];
        [self refreshSelectDate];
    }
}

/// 刷新当前选中日期
- (void)refreshSelectDate {
    NSInteger year = 0;
    NSInteger month = 0;
    NSInteger day = 0;
    NSInteger hour = 0;
    NSInteger minute = 0;
    NSInteger second = 0;
    NSInteger hourShort = 0;
    BOOL hasAMMP = NO;
    NSInteger AMPM = 0;
    for (int i = 0; i < self.dateComponents.count; i++) {
        NSNumber *dateComponent = self.dateComponents[i];
        CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
        switch (ch_component) {
            case CHDatePickerViewDateComponentY:
                year = [self.pickerView selectedRowInComponent:i] + 1 >= 1?[self.pickerView selectedRowInComponent:i] + 1:0;
                break;
            case CHDatePickerViewDateComponentM:
                month = [self.pickerView selectedRowInComponent:i] + 1 >= 1?[self.pickerView selectedRowInComponent:i] + 1:0;
                break;
            case CHDatePickerViewDateComponentD:
                day = [self.pickerView selectedRowInComponent:i] + 1 >= 1?[self.pickerView selectedRowInComponent:i] + 1:0;
                break;
            case CHDatePickerViewDateComponentH:
                hour = [self.pickerView selectedRowInComponent:i] >=0?[self.pickerView selectedRowInComponent:i]:0;
                break;
            case CHDatePickerViewDateComponentm:
                minute = [self.pickerView selectedRowInComponent:i] >=0?[self.pickerView selectedRowInComponent:i]:0;
                break;
            case CHDatePickerViewDateComponents:
                second = [self.pickerView selectedRowInComponent:i] >=0?[self.pickerView selectedRowInComponent:i]:0;
                break;
            case CHDatePickerViewDateComponentHShort:
                hourShort = [self.pickerView selectedRowInComponent:i] >=0?[self.pickerView selectedRowInComponent:i]:0;
                hasAMMP = YES;
                break;
            case CHDatePickerViewDateComponentAMPMS:
                AMPM = [self.pickerView selectedRowInComponent:i] >=0?[self.pickerView selectedRowInComponent:i]:0;
                hasAMMP = YES;
                break;
            default:
                break;
        }
    }
    if (hasAMMP) {//如果是12小时制
        hour = hourShort + AMPM * 12;
    }
    NSDate *date = [NSDate ch_setYear:year month:month];
    NSInteger days = [date ch_getDays];
    if (day > days) {
        for (int i = 0; i < self.dateComponents.count; i++) {
            NSNumber *dateComponent = self.dateComponents[i];
            CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
            switch (ch_component) {
                case CHDatePickerViewDateComponentY:
                    break;
                case CHDatePickerViewDateComponentM:
                    break;
                case CHDatePickerViewDateComponentD:
                    [self.pickerView selectRow:days - 1 inComponent:i animated:YES];
                    day = days;
                    break;
                case CHDatePickerViewDateComponentH:
                    break;
                case CHDatePickerViewDateComponentm:
                    break;
                case CHDatePickerViewDateComponents:
                    break;
                case CHDatePickerViewDateComponentHShort:
                    break;
                case CHDatePickerViewDateComponentAMPMS:
                    break;
                default:
                    break;
            }
        }
    }
    /// 判断最大最小日期
    if (self.maximumDate) {
        NSDateComponents *maximumDateComponents = [self.maximumDate ch_getComponents];
        if (maximumDateComponents.year < year ||
            (maximumDateComponents.year == year && maximumDateComponents.month < month) ||
            (maximumDateComponents.year == year && maximumDateComponents.month == month && maximumDateComponents.day < day) ||
            (maximumDateComponents.year == year && maximumDateComponents.month == month && maximumDateComponents.day == day && maximumDateComponents.hour < hour) ||
            (maximumDateComponents.year == year && maximumDateComponents.month == month && maximumDateComponents.day == day && maximumDateComponents.hour == hour && maximumDateComponents.minute < minute) ||
            (maximumDateComponents.year == year && maximumDateComponents.month == month && maximumDateComponents.day == day && maximumDateComponents.hour == hour && maximumDateComponents.minute == minute && maximumDateComponents.second < second)) {///滚动到最大的年月日
            year = maximumDateComponents.year;
            month = maximumDateComponents.month;
            day = maximumDateComponents.day;
            hour = maximumDateComponents.hour;
            minute = maximumDateComponents.minute;
            second = maximumDateComponents.second;
            [self refreshPickerViewWithDateComponents:maximumDateComponents animated:YES];
        }
    }
    if (self.minimumDate) {
        NSDateComponents *minimuDateComponents = [self.minimumDate ch_getComponents];
        if (minimuDateComponents.year > year ||
            (minimuDateComponents.year == year && minimuDateComponents.month > month) ||
            (minimuDateComponents.year == year && minimuDateComponents.month == month && minimuDateComponents.day > day) ||
            (minimuDateComponents.year == year && minimuDateComponents.month == month && minimuDateComponents.day == day && minimuDateComponents.hour > hour) ||
            (minimuDateComponents.year == year && minimuDateComponents.month == month && minimuDateComponents.day == day && minimuDateComponents.hour == hour && minimuDateComponents.minute > minute) ||
            (minimuDateComponents.year == year && minimuDateComponents.month == month && minimuDateComponents.day == day && minimuDateComponents.hour == hour && minimuDateComponents.minute == minute && minimuDateComponents.second > second)) {///滚动到最小的年月日
            year = minimuDateComponents.year;
            month = minimuDateComponents.month;
            day = minimuDateComponents.day;
            hour = minimuDateComponents.hour;
            year = minimuDateComponents.minute;
            year = minimuDateComponents.second;
            [self refreshPickerViewWithDateComponents:minimuDateComponents animated:YES];
        }
    }
    if (month == 0) {
        month = 1;
    }
    if (day == 0) {
        day = 1;
    }
    self.selectDate = [NSDate ch_setYear:year month:month day:day hour:hour minute:minute second:second];
}

- (void)refreshPickerViewWithDateComponents:(NSDateComponents *)dateComponents animated:(BOOL)animated {
    for (int i = 0; i < self.dateComponents.count; i++) {
        NSNumber *dateComponent = self.dateComponents[i];
        CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
        switch (ch_component) {
            case CHDatePickerViewDateComponentY:
                [self.pickerView selectRow:dateComponents.year - 1 inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponentM:
                [self.pickerView selectRow:dateComponents.month - 1 inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponentD:
                [self.pickerView selectRow:dateComponents.day - 1 inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponentH:
                [self.pickerView selectRow:dateComponents.hour inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponentm:
                [self.pickerView selectRow:dateComponents.minute inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponents:
                [self.pickerView selectRow:dateComponents.second inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponentHShort:
                [self.pickerView selectRow:dateComponents.hour - (dateComponents.hour>=12?12:0) inComponent:i animated:animated];
                break;
            case CHDatePickerViewDateComponentAMPMS:
                [self.pickerView selectRow:dateComponents.hour>=12?1:0 inComponent:i animated:animated];
                break;
            default:
                break;
        }
    }
}

- (void)viewShadeTap:(UITapGestureRecognizer *)sender {
    if (self.allowTapToDissmiss) {
        [self dismiss];
    }
}

- (void)show {
    self.hidden = NO;
    [self.viewBottom mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
    }];
    [UIView animateWithDuration:.25 animations:^{
        self.viewShade.backgroundColor = [UIColor colorWithWhite:.25 alpha:.5];
        [self layoutIfNeeded];
    }];
    [self reloadData];
}

- (void)dismiss {
    [self.viewBottom mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_bottom);
        make.left.right.offset(0);
    }];
    [UIView animateWithDuration:.25 animations:^{
        self.viewShade.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}

@end
