

source 'https://github.com/CocoaPods/Specs.git'
# Uncomment this line to define a global platform for your project
#platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!


workspace ‘GWENT-Builder.xcworkspace'

target 'GWENT-Builder' do
    pod 'Alamofire', '~> 4.0'
    pod 'RxSwift',    '~> 3.0'
    pod 'RxCocoa',    '~> 3.0'
     pod 'SwiftyJSON',
    :git => 'https://github.com/BaiduHiDeviOS/SwiftyJSON.git',
    :branch => 'swift3'
end



target 'gwentBusiness' do
    xcodeproj ‘gwentBusiness/gwentBusiness.xcodeproj’
    pod 'Alamofire', '~> 4.0'
    pod 'SwiftyJSON',
    :git => 'https://github.com/BaiduHiDeviOS/SwiftyJSON.git',
    :branch => 'swift3'
end
    
