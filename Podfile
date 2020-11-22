# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

def example_pods
  # ignore all warnings from all pods
  inhibit_all_warnings!
  
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  pod 'Alamofire', '5.1.0'
  pod 'RxSwift', '5.1.1'
end

target 'FallingWords' do
  example_pods
end

target 'FallingWordsTests' do
  example_pods
  pod 'MockUIAlertController', '3.2.0'
end

