//
//  ViewController.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/18.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "ViewController.h"
#import "CHDatePickerViewHeader.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic ,strong) UILabel *labelTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labelTime = [UILabel new];
    [self.view addSubview:self.labelTime];
    [self.labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    __weak typeof(self) weakSelf = self;
    CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];
//    datePicker.dateStyle = CHDatePickerViewDateStyleYMDHms;
//    datePicker.dateStyle = CHDatePickerViewDateStyleYMDHm;
//    datePicker.dateStyle = CHDatePickerViewDateStyleYMDH;
//    datePicker.dateStyle = CHDatePickerViewDateStyleYMD;
//    datePicker.dateStyle = CHDatePickerViewDateStyleYM;
//    datePicker.dateStyle = CHDatePickerViewDateStyleY;
//    datePicker.dateStyle = CHDatePickerViewDateStyleMDHms;
//    datePicker.dateStyle = CHDatePickerViewDateStyleMDHm;
//    datePicker.dateStyle = CHDatePickerViewDateStyleMDH;
//    datePicker.dateStyle = CHDatePickerViewDateStyleMD;
//    datePicker.dateStyle = CHDatePickerViewDateStyleM;
//    datePicker.dateStyle = CHDatePickerViewDateStyleDHms;
//    datePicker.dateStyle = CHDatePickerViewDateStyleDHm;
//    datePicker.dateStyle = CHDatePickerViewDateStyleDH;
//    datePicker.dateStyle = CHDatePickerViewDateStyleD;
//    datePicker.dateStyle = CHDatePickerViewDateStyleHms;
//    datePicker.dateStyle = CHDatePickerViewDateStyleHm;
//    datePicker.dateStyle = CHDatePickerViewDateStyleH;
//    datePicker.dateStyle = CHDatePickerViewDateStylems;
//    datePicker.dateStyle = CHDatePickerViewDateStylem;
//    datePicker.dateStyle = CHDatePickerViewDateStyles;
    datePicker.dateComponents = @[@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentY)];
//    datePicker.pickerViewSeparatorHidden = YES;
//    datePicker.pickerViewSeparatorColor = [UIColor redColor];
    datePicker.didSelectDateBlock = ^(NSDate * _Nonnull date, NSDateComponents * _Nonnull dateComponents) {
        weakSelf.labelTime.text = [NSString stringWithFormat:@"%ld年%ld月%ld日%ld时%ld分%ld秒",dateComponents.year ,dateComponents.month ,dateComponents.day ,dateComponents.hour ,dateComponents.minute ,dateComponents.second];
    };
//    datePicker.date = [NSDate ch_setYear:1 month:1];
    datePicker.allowTapToDissmiss = NO;
    datePicker.pickerViewSeparatorColor = [UIColor redColor];
    [datePicker show];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC * 2), dispatch_get_main_queue(), ^{
//        datePicker.date = [NSDate ch_setYear:1 month:1];
//        [datePicker setDate:[NSDate date] animated:YES];
//    });
}

@end
