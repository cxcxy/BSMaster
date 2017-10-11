platform :ios, '9.0'
install! 'cocoapods',:deterministic_uuids => false
target 'BSMaster' do
    inhibit_all_warnings!
	use_frameworks!

   	pod 'Moya' , '~> 8.0.5'
	pod 'Moya/RxSwift', '~> 8.0.5'
    pod 'RxSwift', '~> 3.5.0'
    pod 'RxCocoa', '~> 3.5.0'
    pod 'Alamofire'
	pod 'RxDataSources'
    pod 'SnapKit', '~> 3.0.0'
	pod 'UITableView+FDTemplateLayoutCell', '~> 1.5.beta'
	pod 'SwiftyUserDefaults'
    pod 'EZSwiftExtensions'
  	pod 'IQKeyboardManagerSwift'
	pod 'ObjectMapper'
	pod 'SVProgressHUD'
	pod 'Kingfisher'
   	pod 'VTMagic'   , :git => 'https://github.com/aycgithub/VTMagic.git'
    pod 'ESTabBarController-swift'
	pod 'MJRefresh'
	pod 'DZNEmptyDataSet'
    pod 'KMNavigationBarTransition'
    pod 'PonyFrameworkOnSwift',:path => "PonyFrameworkOnSwift/PonyFrameworkOnSwift.podspec"

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
