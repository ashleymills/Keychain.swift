//
//  KeychainWrapper.swift
//  Keychain sample app
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import Foundation

// MARK: - *** Public methods ***
public class Keychain {
    
    public static var allowBackgroundAccess = false
    
    @discardableResult public class func set<T: TypeSafeKeychainValue>(_ value: T?, forKey key: String) -> Bool {
        guard let value = value else {
            removeValue(forKey: key)
            return true
        }
        if valueExists(forKey: key) {
            return update(value, forKey: key)
        } else {
            return create(value, forKey: key)
        }
    }
    
    public class func value<T: TypeSafeKeychainValue>(forKey key: String) -> T? {
        guard let valueData = valueData(forKey: key) else { return nil }
        
        return T.value(data: valueData)
    }
    
    @discardableResult public class func removeValue(forKey key:String) -> Bool {
        return deleteValue(forKey: key)
    }
    
    @discardableResult public class func reset() -> Bool {
        
        let searchDictionary = basicDictionary()
        let status = SecItemDelete(searchDictionary as CFDictionary)
        return status == errSecSuccess
    }
    
    public class func allValues() -> [[String: String]]?  {
        
        var searchDictionary = basicDictionary()
        
        searchDictionary[kSecMatchLimit as String] = kSecMatchLimitAll
        searchDictionary[kSecReturnAttributes as String] = kCFBooleanTrue
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var retrievedAttributes: AnyObject?
        var retrievedData: AnyObject?
        
        var status = SecItemCopyMatching(searchDictionary as CFDictionary, &retrievedAttributes)
        if status != errSecSuccess {
            return nil
        }
        
        status = SecItemCopyMatching(searchDictionary as CFDictionary, &retrievedData)
        guard status == errSecSuccess,
            let attributeDicts = retrievedAttributes as? [[String: AnyObject]] else { return nil }
        
        var allValues = [[String : String]]()
        for attributeDict in attributeDicts {
            guard let keyData = attributeDict[kSecAttrAccount as String] as? Data,
                let valueData = attributeDict[kSecValueData as String] as? Data,
                let key = String(data: keyData, encoding: .utf8),
                let value = String(data: valueData, encoding: .utf8) else { continue }
            allValues.append([key: value])
        }
        
        return allValues
    }
}

// MARK: - *** Private methods ***
fileprivate extension Keychain {
    
    class func valueExists(forKey key: String) -> Bool {
        return valueData(forKey: key) != nil
    }
    
    class func create<T: TypeSafeKeychainValue>(_ value: T, forKey key: String) -> Bool {
        var dictionary = newSearchDictionary(forKey: key)
        
        dictionary[kSecValueData as String] = value.data()
        
        let status = SecItemAdd(dictionary as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    class func update<T: TypeSafeKeychainValue>(_ value: T, forKey key: String) -> Bool {
        
        let searchDictionary = newSearchDictionary(forKey: key)
        var updateDictionary = [String: Any]()
        
        updateDictionary[kSecValueData as String] = value.data()
        
        let status = SecItemUpdate(searchDictionary as CFDictionary, updateDictionary as CFDictionary)
        
        return status == errSecSuccess
    }
    
    @discardableResult class func deleteValue(forKey key: String) -> Bool {
        let searchDictionary = newSearchDictionary(forKey: key)
        let status = SecItemDelete(searchDictionary as CFDictionary)
        
        return status == errSecSuccess
    }
    
    class func valueData(forKey key: String) -> Data?  {
        
        var searchDictionary = newSearchDictionary(forKey: key)
        
        searchDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var retrievedData: AnyObject?
        let status = SecItemCopyMatching(searchDictionary as CFDictionary, &retrievedData)
        
        var data: Data?
        if status == errSecSuccess {
            data = retrievedData as? Data
        }
        
        return data
    }
    
    class func newSearchDictionary(forKey key: String) -> [String: Any] {
        let encodedIdentifier = key.data(using: .utf8, allowLossyConversion: false)
        
        var searchDictionary = basicDictionary()
        searchDictionary[kSecAttrGeneric as String] = encodedIdentifier
        searchDictionary[kSecAttrAccount as String] = encodedIdentifier
        
        return searchDictionary
    }
    
    class func basicDictionary() -> [String: Any] {
        
        let serviceName = Bundle(for: self).infoDictionary![kCFBundleIdentifierKey as String] as! String
        
        var dict: [String: Any] = [kSecClass as String : kSecClassGenericPassword, kSecAttrService as String : serviceName]
        if allowBackgroundAccess {
            dict[kSecAttrAccessible as String] = kSecAttrAccessibleAfterFirstUnlock
        }
        return dict
    }
}

//MARK: - TypeSafeKeychainValue
public protocol TypeSafeKeychainValue {
    func data() -> Data?
    static func value(data: Data) -> Self?
}

extension String: TypeSafeKeychainValue {
    public func data() -> Data? {
        return data(using: .utf8, allowLossyConversion: false)
    }
    public static func value(data: Data) -> String? {
        return String(data: data, encoding: .utf8)
    }
}

extension Int: TypeSafeKeychainValue {
    public func data() -> Data? {
        var value = self
        return Data(bytes: &value, count: MemoryLayout.size(ofValue: value))
    }
    public static func value(data: Data) -> Int? {
        return data.withUnsafeBytes { $0.load(as: Int.self) }
    }
}

extension Bool: TypeSafeKeychainValue {
    public func data() -> Data? {
        var value = self
        return Data(bytes: &value, count: MemoryLayout.size(ofValue: value))
    }
    public static func value(data: Data) -> Bool? {
        return data.withUnsafeBytes { $0.load(as: Bool.self) }
    }
}

extension Date: TypeSafeKeychainValue {
    public func data() -> Data? {
        if #available(iOS 11.0, *) {
            return try? NSKeyedArchiver.archivedData(withRootObject: (self as NSDate), requiringSecureCoding: false)
        } else {
            return NSKeyedArchiver.archivedData(withRootObject: (self as NSDate))
        }
    }
    public static func value(data: Data) -> Date? {
        if #available(iOS 11.0, *) {
            return try? NSKeyedUnarchiver.unarchivedObject(ofClass: NSDate.self, from: data) as Date?
        } else {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? Date
        }
    }
}

extension Data: TypeSafeKeychainValue {
    public func data() -> Data? {
        return self
    }
    
    public static func value(data: Data) -> Self? {
        return data
    }
}

extension TypeSafeKeychainValue where Self: Codable {
    public func data() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
    public static func value(data: Data) -> Self? {
        return try? JSONDecoder().decode(Self.self, from: data)
    }
}
