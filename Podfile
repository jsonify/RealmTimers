platform :ios, '9.0'

target 'RealmTimers' do
  use_frameworks!

pod 'RealmSwift'
pod 'SwiftDate', '~> 6.0'
pod 'SwipeCellKit'
pod "SAConfettiView"
pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'

post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
            end
        end
    end

end
