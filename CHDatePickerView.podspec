Pod::Spec.new do |s|
    s.name         = "CHDatePickerView"
    s.version      = "0.1.0"
    s.summary      = "CHDatePickerView支持自组合的方式快速创建日期选择器,支持横竖屏切换适配安全区"
    s.homepage     = "https://github.com/MeteoriteMan/CHDatePicker"
    s.license      = "MIT"
    s.license      = { :type => "MIT", :file => "LICENSE" }
    s.author       = { "张晨晖" => "shdows007@gmail.com" }
    s.platform     = :ios
    s.source       = { :git => "https://github.com/MeteoriteMan/CHDatePicker.git", :tag => s.version }
    s.source_files = "CHDatePickerView/**/*.{h,m}"
    s.resource     = 'CHDatePickerView/CHDatePickerLocalizable.bundle'
    s.frameworks   = 'Foundation', 'UIKit', 'Masonry'
    s.dependency 'Masonry'
    s.requires_arc = true
end