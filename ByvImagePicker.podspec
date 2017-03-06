#
# Be sure to run `pod lib lint ByvImagePicker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ByvImagePicker'
  s.version          = '0.1.3'
  s.summary          = 'Library to pick image from camera or library and edit or crop image'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
With ByvImagePicker you can in one method display an action sheet to choose camera or photoLibrary, and then edit image with TOCropViewController
                       DESC

  s.homepage         = 'https://github.com/byvapps/ByvImagePicker'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Adrian Apodaca' => 'adrian@byvapps.com' }
  s.source           = { :git => 'https://github.com/byvapps/ByvImagePicker.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/byvapps'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ByvImagePicker/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ByvImagePicker' => ['ByvImagePicker/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ByvUtils'
  s.dependency 'TOCropViewController'
end
