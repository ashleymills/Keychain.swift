#
# Be sure to run `pod lib lint Simple-KeychainSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Simple-KeychainSwift'
  s.version          = '4.0'
  s.summary          = 'A simple drop in Swift wrapper class for the Keychain'
  s.homepage         = 'https://github.com/ashleymills/Keychain.swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ashley Mills' => 'ashleymills@mac.com' }
  s.source           = { :git => "https://github.com/ashleymills/Keychain.swift.git", :tag => "v"+s.version.to_s }
  s.social_media_url = "http://twitter.com/ashleymills"

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.9'

  s.source_files = 'Simple-KeychainSwift/Classes/Keychain.swift'
end
