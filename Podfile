# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CallibriDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'neurosdk2', '~> 1.0.6.2'
  pod 'DropDown', '2.3.4'
  pod 'CorePlot', '2.3'

  # Pods for CallibriDemo

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end

end
