#Keychain.swift
A simple drop in Swift wrapper class for the keychain

###Setup and Installation
You can just drop the `Keychain.swift` file into your project, or use something more robust like Carthage.

#####Installing with Carthage
Carthage is a decentralised dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate Keychain into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "ashleymills/Keychain.swift" "master"
```

##Example usage
####Set a key/value pair

`Keychain.set("some value", forKey: "my key")`

`Keychain.set(true/false, forKey: "my key")`

####Retrieve the value for a key

`Keychain.value(forKey: "my key")`

`Keychain.bool(forKey: "my key")`

####Delete a key/value pair

`Keychain.removeValue(forKey: "my key")`

###Delete all values from the keychain

`Keychain.reset()`

##Want to help?

Got a bug fix, or a new feature? Create a pull request and go for it!

##Let me know!

If you use **Keychain.swift**, please let me know.

Cheers,
Ash
