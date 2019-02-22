//
//  CHPickerView.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/22.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "CHPickerView.h"

@implementation CHPickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setPickerViewSeparatorHidden:(BOOL)pickerViewSeparatorHidden {
    _pickerViewSeparatorHidden = pickerViewSeparatorHidden;
    for (UIView *view in self.subviews) {
        if (view.bounds.size.height < 1) {
            view.hidden = pickerViewSeparatorHidden;
        }
    }
}

- (void)setPickerViewSeparatorColor:(UIColor *)pickerViewSeparatorColor {
    _pickerViewSeparatorColor = pickerViewSeparatorColor;
    for (UIView *view in self.subviews) {
        if (view.bounds.size.height < 1) {
            view.backgroundColor = pickerViewSeparatorColor;
        }
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.pickerViewSeparatorHidden = self.pickerViewSeparatorHidden;
    self.pickerViewSeparatorColor = self.pickerViewSeparatorColor;
}

@end
