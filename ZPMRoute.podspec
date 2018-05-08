#
# Be sure to run `pod lib lint WLRRoute.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZPMRoute'
  s.version          = '0.1.0'
  s.summary          = 'WLRRoute is a simple route,it can provide Url matching and custom handler~'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
It is used to show how to build a route system in iOS app, and I keep it simple and clear.WLRRoute provide url matching , primitive parameters transfer, target callback block , custom handler can overwrite  transitionWithRequest to navigate source to target.
                       DESC

  s.homepage         = 'https://github.com/Wu-Dong-Hui/WLRRoute'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Roy' => 'https://github.com/Wu-Dong-Hui' }
  s.source           = { :git => 'https://github.com/Wu-Dong-Hui/WLRRoute.git', :commit => 'c8136c81fe515d0a5142a1b86a4556436092e853' }
  # s.source           = { :git => 'https://github.com/Wu-Dong-Hui/WLRRoute.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '7.0'

  s.source_files = 'WLRRoute/Classes/**/*'
  
  # s.resource_bundles = {
  #   'WLRRoute' => ['WLRRoute/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
