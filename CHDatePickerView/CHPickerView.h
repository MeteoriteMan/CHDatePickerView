//
//  CHPickerView.h
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/22.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CHPickerView : UIPickerView

/// 是否datePickerView显示分割线
@property (nonatomic ,assign) BOOL pickerViewSeparatorHidden;

/// datePickerView分割线颜色
@property (nonatomic ,strong) UIColor *pickerViewSeparatorColor UI_APPEARANCE_SELECTOR;

@end

NS_ASSUME_NONNULL_END
