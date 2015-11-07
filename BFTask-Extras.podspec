#
# Be sure to run `pod lib lint BFTask-Extras.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "BFTask-Extras"
  s.version          = "1.0.2"
  s.summary          = "A collection of useful extras to make working with BFTasks more pleasant."
  s.description      = <<-DESC
- Create tasks with expiration
- Create a race between tasks
- Use tasks to set imageViews
- Use a result block for faster type casting
- Add promise like blocks
                       DESC
  s.homepage         = "https://github.com/felix-dumit/BFTask-Extras"
  s.license          = 'MIT'
  s.author           = { "Felix Dumit" => "felix.dumit@gmail.com" }
  s.source           = { :git => "https://github.com/felix-dumit/BFTask-Extras.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/felix_dumit'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.10'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
#  s.resource_bundles = {
#    'BFTask-Extras' => ['Pod/Assets/*.png']
#  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Bolts/Tasks'
end
