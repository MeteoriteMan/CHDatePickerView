//
//  NSBundle+CHDatePicker.m
//  CHDatePicker-Demo
//
//  Created by 张晨晖 on 2019/2/20.
//  Copyright © 2019 张晨晖. All rights reserved.
//

#import "NSBundle+CHDatePicker.h"
#import "CHDatePickerView.h"

@implementation NSBundle (CHDatePicker)

+ (instancetype)getLocalizableBundle {
    return [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"CHDatePickerLocalizable.bundle" ofType:@""]];
}

+ (NSString *)ch_localizedStringForKey:(NSString *)key {
    NSString *language = [NSLocale preferredLanguages].firstObject;
    if ([language hasPrefix:@"zh-Hans"]) {///白名单
        language = @"zh-Hans";
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
