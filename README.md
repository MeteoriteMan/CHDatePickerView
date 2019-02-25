# CHDatePickerView

> 目前支持简中、繁体、英文三种语言.

## 效果

### 默认样式
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-iPhone%20SE.gif?raw=true)

### 手动设置样式
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-Style1-iPhone%20SE.gif?raw=true)

### iPhone X/横屏/横竖屏切换支持
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-iPhone%20X.gif?raw=true)

### iPhone Xs Max(手动设置样式)
![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo-iPhone%20Xs%20Max.gif?raw=true)

### iPhone Xs Max(0.0.6新样式)
> 调高了按钮背景以及row高度.以及按钮的默认大小,颜色是"自定义"的

![](https://github.com/MeteoriteMan/Assets/blob/master/gif/CHDatePickerView-Demo(0.0.6)-iPhone%20Xs%20Max.gif?raw=true)

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

// MARK: 0.0.1
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

// MARK: 0.0.2
/// 是否datePickerView显示分割线
@property (nonatomic ,assign) BOOL pickerViewSeparatorHidden;

/// datePickerView分割线颜色
@property (nonatomic ,strong) UIColor *pickerViewSeparatorColor;

// MARK: 0.0.3
/// 允许tap手势使pickerView隐藏
@property (nonatomic ,assign) BOOL allowTapToDissmiss;

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
|0.0.6|新增繁体中文支持.稍微调整了一下UI|
|0.0.5|获取Bundle方式修正|
|0.0.4|修复本地化语言bundle不能读取的问题|
|0.0.3|直接.date设置日期未实现的BUG,0.0.3以下版本建议使用setDate: animated:方法|
|0.0.2|修复iPhoneX横屏布局遮挡问题(PS:最开始写的时候没考虑到横屏).新增一个设置分割线的属性|
|0.0.1|解决了一些bug,目前可以直接使用.|
