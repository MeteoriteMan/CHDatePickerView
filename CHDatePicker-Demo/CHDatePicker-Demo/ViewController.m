//
//  ViewController.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHDateSourceHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSDate *date = [NSDate ch_setYear:2020 month:2];
//    NSTimeInterval timeInterval = [date timeIntervalSince1970];
//    NSInteger days = [date ch_getDays];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];
    datePicker.fontDefault = [UIFont systemFontOfSize:10];
    datePicker.fontSelect = [UIFont systemFontOfSize:18];
    datePicker.didSelectDateBlock = ^(NSDate * _Nonnull date, NSDateComponents * _Nonnull dateComponents) {

    };
    datePicker.dateComponents = @[@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponentS)];
//  @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponentS)];
    [datePicker show];
}

@end
