//
//  ViewController.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHDatePickerViewHeader.h"
#import "CHPickerView.h"
#import "Masonry.h"

@interface ViewController () <CHDatePickerViewDelegate>

@property (nonatomic ,strong) UILabel *labelTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    // 设置CHDatePickerView的全局appearance
    [CHDatePickerView appearance].textColor = [UIColor darkGrayColor];
    [CHDatePickerView appearance].singleRowTextColor = [UIColor darkTextColor];
    [CHPickerView appearance].pickerViewSeparatorColor = [UIColor darkTextColor];

    self.labelTime = [UILabel new];
    self.labelTime.text = @"点击屏幕选择日期";
    [self.view addSubview:self.labelTime];
    [self.labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    __weak typeof(self) weakSelf = self;
    CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];
    datePicker.delegate = self;
    datePicker.dateTextShowType = CHDatePickerViewDateTextShowTypeSingleRow;
//    datePicker.pickerViewSeparatorColor = [UIColor greenColor];
//    datePicker.textColor = [UIColor greenColor];
    datePicker.labelTitle.text = @"请选择日期";
    datePicker.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentHShort) ,@(CHDatePickerViewDateComponentAMPMS)];
//    datePicker.didSelectDateBlock = ^(NSDate * _Nonnull date, NSDateComponents * _Nonnull dateComponents) {
//        weakSelf.labelTime.text = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld时%ld分%ld秒",dateComponents.year ,dateComponents.month ,dateComponents.day ,dateComponents.hour ,dateComponents.minute ,dateComponents.second];
//    };
    [datePicker show];
}

// MARK: CHDatePickerViewDelegate
- (void)datePickerViewDidSelectDate:(NSDate *)date dateComponents:(NSDateComponents *)dateComponents {
    self.labelTime.text = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld时%ld分%ld秒",dateComponents.year ,dateComponents.month ,dateComponents.day ,dateComponents.hour ,dateComponents.minute ,dateComponents.second];
}

@end
