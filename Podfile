source 'https://cdn.cocoapods.org/'

use_frameworks!
inhibit_all_warnings!
platform :ios, '14.0.0'

def dev_pods
  pod 'SwiftLint', configurations: ['Debug']
end

def test_pods
#  pod 'Quick'
#  pod 'Nimble'
end

target 'SwiftDemoTests' do
  test_pods
end

target 'Networking' do
  pod 'Alamofire'
end

target 'SwiftDemo' do
  dev_pods
  # Logging
  pod 'CocoaLumberjack/Swift'
  
  # Data Flow
  pod 'ReSwift'

  # Networking
  pod 'SDWebImage'
  
  # Storage
  pod 'KeychainAccess'

  # UI
  pod 'MJRefresh'
  
  # Utils
  pod 'IQKeyboardManagerSwift'
  pod 'SnapKit'
  pod 'R.swift'
end

post_install do |installer|
  # This removes the warning about swift conversion
  installer.pods_project.root_object.attributes['LastSwiftMigration'] = 9999
  installer.pods_project.root_object.attributes['LastSwiftUpdateCheck'] = 9999
  installer.pods_project.root_object.attributes['LastUpgradeCheck'] = 9999

  # Set Deployment Target iOS Version
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
