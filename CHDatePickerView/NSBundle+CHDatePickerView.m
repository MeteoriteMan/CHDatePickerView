//
//  NSBundle+CHDatePickerView.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/20.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "NSBundle+CHDatePickerView.h"
#import "CHDatePickerView.h"

@implementation NSBundle (CHDatePickerView)

/// 获取语言Bundle
+ (instancetype)getLocalizableBundle {
    return [NSBundle bundleWithPath:[[NSBundle bundleForClass:[CHDatePickerView class]] pathForResource:@"CHDatePickerLocalizable" ofType:@"bundle"]];
}

+ (NSString *)ch_localizedStringForKey:(NSString *)key {
    NSString *language = [NSLocale preferredLanguages].firstObject;
    /// 语言转换白名单
    if ([language hasPrefix:@"zh-Hans"]) {//简体
        language = @"zh-Hans";
    } else if ([language hasPrefix:@"zh-Hant"]) {//繁体
        language = @"zh-Hant";
    } else if ([language hasPrefix:@"en"]) {
        language = @"en";
    } else {
        language = @"en";
    }
    NSString *path = [[self getLocalizableBundle] pathForResource:language ofType:@"lproj"];
    NSBundle *currentLanguagePath = [NSBundle bundleWithPath:path];
    NSString *localizedString = [currentLanguagePath localizedStringForKey:key value:nil table:nil];
    return localizedString;
}

@end
