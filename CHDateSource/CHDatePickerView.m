//
//  CHDatePickerView.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "CHDatePickerView.h"
#import "NSDate+CHCategory.h"
#import "Masonry.h"

@interface CHDatePickerView () <UIPickerViewDataSource ,UIPickerViewDelegate>

@property (nonatomic ,strong) UIView *viewShade;

@property (nonatomic ,strong) UITapGestureRecognizer *viewShadeTap;

/// 白色背景板
@property (nonatomic ,strong) UIView *viewBottom;

@property (nonatomic ,strong) UIPickerView *pickerView;

/// 按钮背景板
@property (nonatomic ,strong) UIView *viewButtonBackground;

/// 确认按钮
@property (nonatomic ,strong) UIButton *buttonConfirm;

/// 取消按钮
@property (nonatomic ,strong) UIButton *buttonCancel;

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

@end

@implementation CHDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

// MARK: getter

- (UIFont *)textFont {
    if (!_textFont) {
        _textFont = [UIFont systemFontOfSize:12];
    }
    return _textFont;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor darkTextColor];
    }
    return _textColor;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupConfig];
        [self setupUI];
    }
    return self;
}

- (void)setupConfig {
    NSDate *date = [NSDate date];
    self.currentDateComponent = [date ch_getComponents];
    /// 设置默认日期选择器模式
    self.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD)];
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
    NSMutableArray *minutesM = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        [minutesM addObject:[NSNumber numberWithInteger:i]];
    }
    self.minutes = minutesM.copy;
    /// 秒
    NSMutableArray *arraySecondsM = [NSMutableArray array];
    for (int i = 0; i < 60; i++) {
        [arraySecondsM addObject:[NSNumber numberWithInteger:i]];
    }
    self.seconds = arraySecondsM.copy;
}

- (void)setupUI {

    [[UIApplication sharedApplication].delegate.window addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    self.hidden = YES;

    self.viewShade = [UIView new];
    self.viewShade.backgroundColor = [UIColor colorWithWhite:.25 alpha:.5];
    [self addSubview:self.viewShade];
    [self.viewShade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];

    self.viewShadeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.viewShade addGestureRecognizer:self.viewShadeTap];

    self.viewBottom = [UIView new];
    self.viewBottom.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.viewBottom];
    [self.viewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(240);
    }];

    self.viewButtonBackground = [UIView new];
    self.viewButtonBackground.backgroundColor = [UIColor whiteColor];
    [self.viewBottom addSubview:self.viewButtonBackground];
    [self.viewButtonBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.offset(0);
        make.height.offset(38);
    }];

    self.buttonConfirm = [UIButton new];
    [self.buttonConfirm setTitle:@"确认" forState:UIControlStateNormal];
    [self.buttonConfirm setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.viewButtonBackground addSubview:self.buttonConfirm];
    [self.buttonConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-13);
        make.top.bottom.offset(0);
    }];

    self.buttonCancel = [UIButton new];
    [self.buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.buttonCancel setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.viewButtonBackground addSubview:self.buttonCancel];
    [self.buttonCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(13);
        make.top.bottom.offset(0);
    }];

    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
//    self.pickerView.showsSelectionIndicator = YES;
    [self.viewBottom addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.viewButtonBackground.mas_bottom);
        make.left.right.offset(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.viewBottom.mas_safeAreaLayoutGuideBottom);
        } else {
            // Fallback on earlier versions
            make.bottom.offset(0);
        }
    }];

    [self.buttonConfirm addTarget:self action:@selector(buttonConfirmClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.buttonCancel addTarget:self action:@selector(buttonCancelClick:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)reloadData {

    [self.pickerView reloadAllComponents];
//    [self.pickerView layoutIfNeeded];
    for (int i = 0; i < self.dateComponents.count; i++) {
        NSNumber *dateComponent = self.dateComponents[i];
        CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
        switch (ch_component) {
            case CHDatePickerViewDateComponentY:
                [self.pickerView selectRow:self.currentDateComponent.year - 1 inComponent:i animated:YES];
                break;
            case CHDatePickerViewDateComponentM:
                [self.pickerView selectRow:self.currentDateComponent.month - 1 inComponent:i animated:YES];
                break;
            case CHDatePickerViewDateComponentD:
                [self.pickerView selectRow:self.currentDateComponent.day - 1 inComponent:i animated:YES];
                break;
            case CHDatePickerViewDateComponentH:
                [self.pickerView selectRow:self.currentDateComponent.hour inComponent:i animated:YES];
                break;
            case CHDatePickerViewDateComponentm:
                [self.pickerView selectRow:self.currentDateComponent.minute inComponent:i animated:YES];
                break;
            case CHDatePickerViewDateComponentS:
                [self.pickerView selectRow:self.currentDateComponent.second inComponent:i animated:YES];
                break;
            default:
                break;
        }

////#error 取不到值.明天改
//        UILabel *label = (UILabel *)[self.pickerView viewForRow:[self.pickerView selectedRowInComponent:i] forComponent:i];
//        label.font = self.fontSelect;
    }
    [self refreshSelectDate];
}

- (void)show {
    self.hidden = NO;
    [self reloadData];
}

- (void)dismiss {
    self.hidden = YES;
    [self removeFromSuperview];
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
        case CHDatePickerViewDateComponentM:
            return self.months.count;
        case CHDatePickerViewDateComponentD:
            return self.days.count;
        case CHDatePickerViewDateComponentH:
            return self.hours.count;
        case CHDatePickerViewDateComponentm:
            return self.minutes.count;
        case CHDatePickerViewDateComponentS:
            return self.seconds.count;
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
            text = [NSString stringWithFormat:@"%@年",self.years[row]];
            break;
        case CHDatePickerViewDateComponentM:
            text = [NSString stringWithFormat:@"%@月",self.months[row]];
            break;
        case CHDatePickerViewDateComponentD:
            text = [NSString stringWithFormat:@"%@日",self.days[row]];
            break;
        case CHDatePickerViewDateComponentH:
            text = [NSString stringWithFormat:@"%@时",self.hours[row]];
            break;
        case CHDatePickerViewDateComponentm:
            text = [NSString stringWithFormat:@"%@分",self.minutes[row]];
            break;
        case CHDatePickerViewDateComponentS:
            text = [NSString stringWithFormat:@"%@秒",self.seconds[row]];
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
//    UILabel *label = (UILabel *)[self.pickerView viewForRow:row forComponent:component];
//    label.font = self.fontSelect;
    NSNumber *dateComponent = self.dateComponents[component];
    CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
    switch (ch_component) {
        case CHDatePickerViewDateComponentY:/// 滚动年

            break;
        case CHDatePickerViewDateComponentM:/// 滚动月

            break;
        case CHDatePickerViewDateComponentD:/// 滚动日

            break;
        case CHDatePickerViewDateComponentH:

            break;
        case CHDatePickerViewDateComponentm:

            break;
        case CHDatePickerViewDateComponentS:

            break;
        default:

            break;
    }
    [self refreshSelectDate];
}

// MARK: Action
- (void)buttonConfirmClick:(UIButton *)sender {
    if (self.didSelectDateBlock) {
        self.didSelectDateBlock(self.selectDate ,[self.selectDate ch_getComponents]);
    }
    [self dismiss];
}

- (void)buttonCancelClick:(UIButton *)sender {
    [self dismiss];
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
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
        for (int i = 0; i < self.dateComponents.count; i++) {
            NSNumber *dateComponent = self.dateComponents[i];
            CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
            switch (ch_component) {
                case CHDatePickerViewDateComponentY:
                    [self.pickerView selectRow:dateComponents.year - 1 inComponent:i animated:YES];
                    break;
                case CHDatePickerViewDateComponentM:
                    [self.pickerView selectRow:dateComponents.month - 1 inComponent:i animated:YES];
                    break;
                case CHDatePickerViewDateComponentD:
                    [self.pickerView selectRow:dateComponents.day - 1 inComponent:i animated:YES];
                    break;
                case CHDatePickerViewDateComponentH:
                    [self.pickerView selectRow:dateComponents.hour inComponent:i animated:YES];
                    break;
                case CHDatePickerViewDateComponentm:
                    [self.pickerView selectRow:dateComponents.minute inComponent:i animated:YES];
                    break;
                case CHDatePickerViewDateComponentS:
                    [self.pickerView selectRow:dateComponents.second inComponent:i animated:YES];
                    break;
                default:

                    break;
            }
        }
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
            case CHDatePickerViewDateComponentS:
                second = [self.pickerView selectedRowInComponent:i] >=0?[self.pickerView selectedRowInComponent:i]:0;
                break;
            default:

                break;
        }
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
                case CHDatePickerViewDateComponentS:
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
            for (int i = 0; i < self.dateComponents.count; i++) {
                NSNumber *dateComponent = self.dateComponents[i];
                CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
                switch (ch_component) {
                    case CHDatePickerViewDateComponentY:
                        [self.pickerView selectRow:maximumDateComponents.year - 1 inComponent:i animated:YES];
                        year = maximumDateComponents.year;
                        break;
                    case CHDatePickerViewDateComponentM:
                        [self.pickerView selectRow:maximumDateComponents.month - 1 inComponent:i animated:YES];
                        month = maximumDateComponents.month;
                        break;
                    case CHDatePickerViewDateComponentD:
                        [self.pickerView selectRow:maximumDateComponents.day - 1 inComponent:i animated:YES];
                        day = maximumDateComponents.day;
                        break;
                    case CHDatePickerViewDateComponentH:
                        [self.pickerView selectRow:maximumDateComponents.hour inComponent:i animated:YES];
                        hour = maximumDateComponents.hour;
                        break;
                    case CHDatePickerViewDateComponentm:
                        [self.pickerView selectRow:maximumDateComponents.minute inComponent:i animated:YES];
                        year = maximumDateComponents.minute;
                        break;
                    case CHDatePickerViewDateComponentS:
                        [self.pickerView selectRow:maximumDateComponents.second inComponent:i animated:YES];
                        year = maximumDateComponents.second;
                        break;
                    default:

                        break;
                }
            }
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
            for (int i = 0; i < self.dateComponents.count; i++) {
                NSNumber *dateComponent = self.dateComponents[i];
                CHDatePickerViewDateComponent ch_component = [dateComponent integerValue];
                switch (ch_component) {
                    case CHDatePickerViewDateComponentY:
                        [self.pickerView selectRow:minimuDateComponents.year - 1 inComponent:i animated:YES];
                        year = minimuDateComponents.year;
                        break;
                    case CHDatePickerViewDateComponentM:
                        [self.pickerView selectRow:minimuDateComponents.month - 1 inComponent:i animated:YES];
                        month = minimuDateComponents.month;
                        break;
                    case CHDatePickerViewDateComponentD:
                        [self.pickerView selectRow:minimuDateComponents.day - 1 inComponent:i animated:YES];
                        day = minimuDateComponents.day;
                        break;
                    case CHDatePickerViewDateComponentH:
                        [self.pickerView selectRow:minimuDateComponents.hour inComponent:i animated:YES];
                        hour = minimuDateComponents.hour;
                        break;
                    case CHDatePickerViewDateComponentm:
                        [self.pickerView selectRow:minimuDateComponents.minute inComponent:i animated:YES];
                        year = minimuDateComponents.minute;
                        break;
                    case CHDatePickerViewDateComponentS:
                        [self.pickerView selectRow:minimuDateComponents.second inComponent:i animated:YES];
                        year = minimuDateComponents.second;
                        break;
                    default:

                        break;
                }
            }
        }
    }
    self.selectDate = [NSDate ch_setYear:year month:month day:day hour:hour minute:minute second:second];
}

@end
