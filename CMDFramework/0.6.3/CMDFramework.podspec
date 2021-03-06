#
# Be sure to run `pod lib lint CMDFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'CMDFramework'
  s.version          = '0.6.3'
  s.summary          = 'CINEMOOD IOS Application Framework'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://cinemood.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Nikolay Karataev aka Babaka' => 'babaka@cinemood.com' }
  s.source           = { :git => 'git@github.com:nbabaka/CMDFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'CMDFramework/Framework/**/*'
  s.frameworks = 'UIKit'
  s.dependency 'EasyPeasy'
  s.dependency 'libPhoneNumber-iOS'
  s.dependency 'SDWebImage'
  s.dependency 'Restofire'
  s.dependency 'SSZipArchive'
  s.dependency 'SwiftyJSON'
  s.dependency 'PKHUD'
  s.dependency 'EasyAnimation'
  s.dependency 'FacebookCore'
  s.dependency 'FacebookLogin'
  s.dependency 'LGSideMenuController'

  s.requires_arc = true
  s.resource_bundles = {
    'Assets' => ['CMDFramework/Assets/*.xcassets'],
    'Localization' => ['CMDFramework/*.lproj/*.strings'],
    'Resources' => ['CMDFramework/Resources/**/*']
  }

  s.resources = ['CMDFramework/Assets/*.xcassets']
end
