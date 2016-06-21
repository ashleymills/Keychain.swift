# Simple-KeychainSwift

[![CI Status](http://img.shields.io/travis/Ashley Mills/Simple-KeychainSwift.svg?style=flat)](https://travis-ci.org/Ashley Mills/Simple-KeychainSwift)
[![Version](https://img.shields.io/cocoapods/v/Simple-KeychainSwift.svg?style=flat)](http://cocoapods.org/pods/Simple-KeychainSwift)
[![License](https://img.shields.io/cocoapods/l/Simple-KeychainSwift.svg?style=flat)](http://cocoapods.org/pods/Simple-KeychainSwift)
[![Platform](https://img.shields.io/cocoapods/p/Simple-KeychainSwift.svg?style=flat)](http://cocoapods.org/pods/Simple-KeychainSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Simple-KeychainSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Simple-KeychainSwift"
```

## Author

Ashley Mills, ashleymills@mac.com

## License

Simple-KeychainSwift is available under the MIT license. See the LICENSE file for more info.

## Example usage

### Set a key/value pair

`Keychain.set("some value", forKey: "my key")`
`Keychain.set(true/false, forKey: "my key")`

### Retrieve the value for a key

`Keychain.value(forKey: "my key")`
`Keychain.bool(forKey: "my key")`

### Delete a key/value pair

`Keychain.removeValue(forKey: "my key")`

### Delete all values from the keychain

`Keychain.reset()`

## Want to help?

Got a bug fix, or a new feature? Create a pull request and go for it!

## Let me know!

If you use **Keychain.swift**, please let me know.

Cheers,
Ash
