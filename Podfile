# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Mapmo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'NMapsMap'
  pod 'SnapKit'
  pod 'RealmSwift', '10.47.0'
  pod 'Alamofire'
  pod 'FloatingPanel'
  pod 'IQKeyboardManagerSwift'
  pod 'FSCalendar'
  pod 'DGCharts'
  pod 'Tabman', '~> 3.0'

  pod ‘Firebase/AnalyticsWithoutAdIdSupport’
  pod 'Firebase/Crashlytics'
  # Pods for Mapmo

end


post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
   end
end