platform :ios, '15.0'
inhibit_all_warnings!
use_frameworks!

target 'Recruitment-iOS' do
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  pod 'R.swift'
  pod 'RxSwiftExt', '~> 5'
end

target 'Recruitment-iOSTests' do
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxTest'
  pod 'RxSwiftExt', '~> 5'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
            config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'YES'
        end
    end
 end
