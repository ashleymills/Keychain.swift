# **Simple-KeychainSwift**

[![Version](https://img.shields.io/cocoapods/v/**Simple-KeychainSwift**.svg?style=flat)](http://cocoapods.org/pods/**Simple-KeychainSwift**)
[![License](https://img.shields.io/cocoapods/l/**Simple-KeychainSwift**.svg?style=flat)](http://cocoapods.org/pods/**Simple-KeychainSwift**)
[![Platform](https://img.shields.io/cocoapods/p/**Simple-KeychainSwift**.svg?style=flat)](http://cocoapods.org/pods/**Simple-KeychainSwift**)

## Supporting Simple-KeychainSwift

Keeping **Simple-KeychainSwift** up-to-date is a time consuming task. Making updates, reviewing pull requests, responding to issues and answering emails all take time. If you'd like to help keep me motivated, please download my free app, Photo Flipper from the App Store. (To really motivate me, pay $1.99 for the IAP 😀)

And don't forget to ★ the repo. This increases its visibility and encourages others to contribute.

Thanks Ash

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### Manual
Just drop the **Keychain.swift** file into your project. That's it!

### Swift Package Manager
**Simple-KeychainSwift** is available through [Swift Package Manager](https://swift.org/package-manager/). **Xcode 11.0+ is required.** 
To install, open `Xcode -> File -> Swift Packages -> Add Package Dependency` and paste repo's address
```
https://github.com/ashleymills/Keychain.swift
```

### CocoaPods
**Simple-KeychainSwift** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Simple-KeychainSwift"
```

## Author

**Simple-KeychainSwift** was wrtten by Ashley Mills, ashleymills@mac.com

## License

**Simple-KeychainSwift** is available under the MIT license. See the LICENSE file for more info.

## Example usage

**Simple-KeychainSwift** declares a protocol `TypeSafeKeychainValue`:

```swift
public protocol TypeSafeKeychainValue {
    func data() -> Data?                   // Convert to Data
    static func value(data: Data) -> Self? // Convert from Data
}
```

You can use **Simple-KeychainSwift** to set any types that conform to this protocol. Currently supported are `String`, `Int`, `Bool` and `Date`, To set other types, add conformity to `TypeSafeKeychainValue`, e.g.

```swift
extension Int: TypeSafeKeychainValue {
    public func data() -> Data? {
        var value = self
        return Data(bytes: &value, count: MemoryLayout.size(ofValue: value))
    }
    public static func value(data: Data) -> Int? {
        return data.withUnsafeBytes { $0.pointee }
    }
}
```

### Set a key/value pair

```swift
Keychain.set("some value", forKey: "some string")
Keychain.set(true, forKey: "some bool")
Keychain.set(Date(), forKey: "some date")
Keychain.set(27, forKey: "some int")
```

### Retrieve the value for a key

```swift
Keychain.value(forKey: "some string") as String
Keychain.value(forKey: "some bool") as Bool
Keychain.value(forKey: "some date") as Date
Keychain.value(forKey: "some int") as Int
```

### Delete a key/value pair

`Keychain.removeValue(forKey: "my key")`

### Delete all values from the keychain

`Keychain.reset()`

## Want to help?

Got a bug fix, or a new feature? Create a pull request and go for it!

## Let me know!

If you use **Simple-KeychainSwift**, please let me know.

Cheers,
Ash
