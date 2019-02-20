//
//  ViewController.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHDateSourceHeader.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic ,strong) UILabel *labelTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    NSDate *date = [NSDate ch_setYear:2020 month:2];
//    NSTimeInterval timeInterval = [date timeIntervalSince1970];
//    NSInteger days = [date ch_getDays];
    UIDatePicker;
    self.labelTime = [UILabel new];
    [self.view addSubview:self.labelTime];
    [self.labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) weakSelf = self;
    CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];
    datePicker.textFont = [UIFont systemFontOfSize:10];
    datePicker.textColor = [UIColor redColor];
    datePicker.maximumDate = [NSDate date];
//    datePicker.fontSelect = [UIFont systemFontOfSize:16];
    datePicker.didSelectDateBlock = ^(NSDate * _Nonnull date, NSDateComponents * _Nonnull dateComponents) {
        weakSelf.labelTime.text = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld时%ld分%ld秒",dateComponents.year ,dateComponents.month ,dateComponents.day ,dateComponents.hour ,dateComponents.minute ,dateComponents.second];
    };
    datePicker.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponentS)];
//  @[@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponentS)];
    [datePicker show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * .5), dispatch_get_main_queue(), ^{
        [datePicker setDate:[NSDate dateWithTimeIntervalSince1970:10000] animated:YES];
    });
}

@end
