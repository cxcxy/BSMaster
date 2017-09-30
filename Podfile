platform :ios, '9.0'
install! 'cocoapods',:deterministic_uuids => false
target 'BSMaster' do

	use_frameworks!

   	pod 'Moya' , '~> 8.0.5'
	pod 'Moya/RxSwift'
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

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
