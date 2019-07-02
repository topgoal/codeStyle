use_frameworks!

workspace 'TGSmart'

# smart
project 'Smart/Smart.xcodeproj'
# models
project 'Models/Models.xcodeproj'
# viewModels
project 'ViewModels/ViewModels.xcodeproj'

def network_pods
    pod 'Alamofire', '~>4.7'
    pod 'Moya/RxSwift'
end

def smart
    network_pods
    pod 'RxSwift'
    pod 'RxCocoa', '~>4.0'
    pod 'SwiftyUserDefaults'
    pod 'SwiftDate'
    pod 'MBProgressHUD'
    pod 'RxDataSources', '~> 3.0'
    pod 'Tabman', '~> 1.8.2'
    pod 'Charts'
    pod 'IQKeyboardManagerSwift'
    pod 'MJRefresh'
    pod 'Hue'
    pod 'RxGesture'
    pod 'JPush', '3.1.0'
    pod 'FSPagerView'
    pod 'SwiftLint'
    #pod 'EZOpenSDK'
#    pod 'EZUIKit'
end

target 'Smart' do
    xcodeproj 'Smart/Smart.xcodeproj'
    smart
end

target 'Models' do
    xcodeproj 'Models/Models.xcodeproj'
    network_pods
    pod 'SwiftyUserDefaults'
    pod 'SwiftLint'
end

target 'ViewModels' do
    xcodeproj 'ViewModels/ViewModels.xcodeproj'
    network_pods
    pod 'RxSwift'
    pod 'RxCocoa', '~>4.0'
    pod 'SwiftyUserDefaults'
    pod 'SwiftDate'
    pod 'MJRefresh'
    pod 'SwiftLint'
end

