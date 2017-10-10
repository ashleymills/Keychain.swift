# Simple-KeychainSwift

[![CI Status](http://img.shields.io/travis/Ashley Mills/Simple-KeychainSwift.svg?style=flat)](https://travis-ci.org/Ashley Mills/Simple-KeychainSwift)
[![Version](https://img.shields.io/cocoapods/v/Simple-KeychainSwift.svg?style=flat)](http://cocoapods.org/pods/Simple-KeychainSwift)
[![License](https://img.shields.io/cocoapods/l/Simple-KeychainSwift.svg?style=flat)](http://cocoapods.org/pods/Simple-KeychainSwift)
[![Platform](https://img.shields.io/cocoapods/p/Simple-KeychainSwift.svg?style=flat)](http://cocoapods.org/pods/Simple-KeychainSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### Manual
Just drop the **Keychain.swift** file into your project. That's it!

### CocoaPods
Simple-KeychainSwift is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Simple-KeychainSwift"
```

## Author

Simple-KeychainSwift was wrtten by Ashley Mills, ashleymills@mac.com

## License

Simple-KeychainSwift is available under the MIT license. See the LICENSE file for more info.

## Example usage

Simple-KeychainSwift defines a protocol `TypeSafeKeychainValue`…

```swift
public protocol TypeSafeKeychainValue {
    func data() -> Data?                   // Convert to Data
    static func value(data: Data) -> Self? // Convert from Data
}
```

You can use Simple-KeychainSwift to set any values that conform to this protocol. Currently supported are `String`, `Int`, `Bool` and `Date` - but you can set any other values that conform to this protocol.

### Set a key/value pair

`Keychain.set("some value", forKey: "some string")`
`Keychain.set(true, forKey: "some bool")`
`Keychain.set(Date(), forKey: "some date")`
`Keychain.set(27, forKey: "some int")`

### Retrieve the value for a key

`Keychain.value(forKey: "some string") as String `
`Keychain.value(forKey: "some bool") as Bool `
`Keychain.value(forKey: "some date") as Date `
`Keychain.value(forKey: "some int") as Int `

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
