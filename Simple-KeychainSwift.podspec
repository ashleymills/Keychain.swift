Pod::Spec.new do |s|

s.name         = "Simple-KeychainSwift"
s.version      = "1.0.1"
s.summary      = "A simple drop in Swift wrapper class for the keychain"
s.homepage     = "https://github.com/ashleymills/Keychain.swift"
s.license      = "MIT"
s.author       = { "Ashley Mills" => "ashleymills@mac.com" }
s.social_media_url   = "http://twitter.com/ashleymills"
s.platform     = :ios, "9.3"
s.platform     = :osx, "10.11"
s.ios.deployment_target = "8.0"
s.osx.deployment_target = "10.9"
s.source       = { :git => "https://github.com/ashleymills/Keychain.swift.git", :tag => "v"+s.version.to_s }
s.source_files = "Simple-Keychain.swift"

end
