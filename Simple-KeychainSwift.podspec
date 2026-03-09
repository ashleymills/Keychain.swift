Pod::Spec.new do |s|
  s.name             = 'Simple-KeychainSwift'
  s.version          = '4.3.0'
  s.summary          = 'A simple drop in Swift wrapper class for the Keychain'
  s.homepage         = 'https://github.com/ashleymills/Keychain.swift'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ashley Mills' => 'ashleymills@mac.com' }
  s.source           = { :git => "https://github.com/ashleymills/Keychain.swift.git", :tag => "v" + s.version.to_s }
  s.swift_version    = '5.0'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'

  s.source_files = 'Simple-KeychainSwift/Classes/Keychain.swift'
end
