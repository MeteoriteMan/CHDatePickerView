# CHDatePickerView

## 效果

### 默认样式
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-iPhone%20SE.gif?raw=true)

### 手动设置样式
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-Style1-iPhone%20SE.gif?raw=true)

## 使用

1.起调datePickerView

```
CHDatePickerView *datePicker = [[CHDatePickerView alloc] init];	
[datePicker show];
```

2.datePickerView的显示组合设置

```
datePicker.dateStyle = CHDatePickerViewDateStyleYMDHms;
```

3.datePickerView的自定义显示组合设置

```
/// 年月日时分秒的前后是根据dateComponents内的顺序决定的.
datePicker.dateComponents = @[@(CHDatePickerViewDateComponentY) ,@(CHDatePickerViewDateComponentM) ,@(CHDatePickerViewDateComponentD) ,@(CHDatePickerViewDateComponentH) ,@(CHDatePickerViewDateComponentm) ,@(CHDatePickerViewDateComponents)];
```

4.获取数据回调的两种方式

```
// MARK: 1.block回调.
datePicker.didSelectDateBlock = ^(NSDate * _Nonnull date, NSDateComponents * _Nonnull dateComponents) {

};
    
// MARK: 2.delegate回调.
<CHDatePickerViewDelegate>
- (void)datePickerViewDidSelectDate:(NSDate *)date dateComponents:(NSDateComponents *)dateComponents {

}
```

**注意点:**
1.使用block记得要__weak typeof(xx) weakXX = xx;以免循环引用.
2.dateComponents中有年月日时分秒属性,直接.xx调用.
3.如果要获取时间戳的话使用[date timeIntervalSince1970]即可获取.

4.属性

```
一些常用的属性我已经抛在外头了.

/// 按钮背景板
@property (nonatomic ,strong) UIView *viewButtonBackground;

/// 确认按钮
@property (nonatomic ,strong) UIButton *buttonConfirm;

/// 取消按钮
@property (nonatomic ,strong) UIButton *buttonCancel;

/// 字体大小
@property (nonatomic ,strong) UIFont *textFont;

/// 文字颜色
@property (nonatomic ,strong) UIColor *textColor;

// 默认的选中时间.默认为当前时间[NSDate date]
@property (nonatomic, strong) NSDate *date;

/// 允许选中的最小时间
@property (nullable, nonatomic, strong) NSDate *minimumDate; // default is nil

/// 允许选中的最大时间
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil
```

如果想使用手动设置年月日可以使用`NSDate+CHCategory`内的方法

```
NSDate *date = [NSDate ch_setYear:year month:month day:day hour:hour minute:minute second:second];
```

## 安装

使用 [CocoaPods](http://www.cocoapods.com/) 集成.
首先在podfile中
>`pod 'CHDatePickerView'

安装一下pod

>`#import <CHDatePickerView/CHDatePickerViewHeader.h>`

## 更新记录

|版本|更新内容|
|:--|:--|
|0.0.1|解决了一些bug,目前可以直接使用.|
