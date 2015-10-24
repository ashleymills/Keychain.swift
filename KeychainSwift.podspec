Pod::Spec.new do |s|
  s.name         = 'KeychainSwift'
  s.version      = '1.0'
  s.homepage     = 'https://github.com/ashleymills/Keychain.swift'
  s.authors      = {
    'Ashley Mills' => 'ashleymills@mac.com'
  }
  s.summary      = 'A simple drop in Swift wrapper class for the keychain'
  s.license      = { :type => 'MIT' }

# Source Info
  s.ios.platform = :ios, "9.0"
  s.osx.platform = :osx, "10.11"
  s.ios.deployment_target = "8.0"
  s.osx.deployment_target = "10.9"
  s.source       =  {
    :git => 'https://github.com/ashleymills/Keychain.swift.git',
    :tag => 'v'+s.version.to_s
  }
  s.source_files = 'Keychain.swift'
  s.framework    = 'SystemConfiguration'

  s.requires_arc = true
end
