platform :ios, '9.0'
install! 'cocoapods',:deterministic_uuids => false
target 'BSMaster' do
    inhibit_all_warnings!
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
    pod 'SwiftyJSON'
	pod 'SVProgressHUD'
	pod 'Kingfisher'
   	pod 'VTMagic'   , :git => 'https://github.com/aycgithub/VTMagic.git'
    pod 'ESTabBarController-swift'
	pod 'MJRefresh', '~> 3.1.14.1'
	pod 'DZNEmptyDataSet'
    pod 'KMNavigationBarTransition'
#    pod 'RSKPlaceholderTextView'
    pod 'KMPlaceholderTextView', '~> 1.3.0'
    pod 'UMengUShare/Social/ReducedWeChat'
    pod 'RongCloudIM/IMLib', '~> 2.8.3'
    pod 'RongCloudIM/IMKit', '~> 2.8.3'  

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end
