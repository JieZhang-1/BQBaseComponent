#
# Be sure to run `pod lib lint BQBaseComponent.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BQBaseComponent'
  s.version          = '0.2'
  s.summary          = 'BQBaseComponent Kit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/JieZhang-1/BQBaseComponent'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhang_j@yeah.net' => 'zhang_j@yeah.net' }
  s.source           = { :git => 'https://github.com/JieZhang-1/BQBaseComponent.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  
  #s.requires_arc = false
  #s.requires_arc = ['ELDiagnosis/Classes/ARC/**/*.m']
  
  #s.source_files = 'BQBaseComponent/Classes/**/*'
  s.subspec 'CommMacro' do |ss|
      ss.source_files = 'BQBaseComponent/Classes/CommMacro/*.{h,m}'
  end
  s.subspec 'Utils' do |ss|
      ss.source_files = 'BQBaseComponent/Classes/Utils/*.{h,m}'
  end
  s.subspec 'LogCategory' do |ss|
      ss.source_files = 'BQBaseComponent/Classes/LogCategory/*.{h,m}'
  end
  s.subspec 'Categorys' do |ss|
      ss.source_files = 'BQBaseComponent/Classes/Categorys/*.{h,m}'
      ss.dependency 'BQBaseComponent/CommMacro'
  end
  s.subspec 'Network' do |ss|
      ss.source_files = 'BQBaseComponent/Classes/Network/*.{h,m}'
  end
  s.subspec 'BQBaseUI' do |ss|
      ss.source_files = 'BQBaseComponent/Classes/BQBaseUI/**/*'
  end
  
  
  
  
  
   s.resource_bundles = {
     'BQBaseComponent' => ['BQBaseComponent/Assets/*.png']
   }

  #s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 3.0.0'
  s.dependency 'RTRootNavigationController'
end
