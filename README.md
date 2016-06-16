# Keychain.swift
A simple drop in Swift wrapper class for the keychain

## Installation

### Manual
Just drop the **Keychain.swift** file into your project. That's it!

### CocoaPods
**Keychain.swift** is available through CocoaPods. To install it, simply add the following line to your Podfile:

`pod "Simple-KeychainSwift"`

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
