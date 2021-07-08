source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
inhibit_all_warnings!
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

load "Pods.rb"

target 'cosmos' do
  # use_frameworks!
  
  # Pods for cosmos
  
  # POD_MODE_DEV     = 0  优先以本地文件的方式加载我们自己的pod库，会加载DEBUG库
  # POD_MODE_TEST    = 1  以远程的方式加载我们自己的pod库，会加载DEBUG库
  # POD_MODE_RELEASE = 2  以远程的方式加载我们自己的pod库，不会加载DEBUG库
  
  pod_libs POD_MODE_DEV
  
  # 消除警告
  remove_warnings '9.0'
end
