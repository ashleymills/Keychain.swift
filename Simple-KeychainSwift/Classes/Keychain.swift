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
    
    @discardableResult public class func set(_ value:String, forKey key:String) -> Bool {
        if valueExists(forKey: key) {
            return update(value, forKey: key)
        } else {
            return create(value, forKey: key)
        }
    }
    
    @discardableResult public class func set(_ bool:Bool, forKey key:String) -> Bool {
        let value = bool ? "true" : "false"
        return set(value, forKey: key)
    }
    
    public class func value(forKey key: String) -> String? {
        guard let valueData = valueData(forKey: key) else { return nil }
        
        return NSString(data: valueData, encoding: String.Encoding.utf8.rawValue) as String?
    }
    
    public class func bool(forKey key: String) -> Bool {
        return value(forKey: key) == "true"
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
        if status != errSecSuccess {
            return nil
        }
        
        guard let attributeDicts = retrievedAttributes as? [[String: AnyObject]] else { return nil }
        
        var allValues = [[String : String]]()
        for attributeDict in attributeDicts {
            guard let keyData = attributeDict[kSecAttrAccount as String] as? Data else { continue }
            guard let valueData = attributeDict[kSecValueData as String] as? Data else { continue }
            guard let key = NSString(data: keyData, encoding: String.Encoding.utf8.rawValue) as String? else { continue }
            guard let value = NSString(data: valueData, encoding: String.Encoding.utf8.rawValue) as String? else { continue }
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
    
    class func create(_ value: String, forKey key: String) -> Bool {
        var dictionary = newSearchDictionary(forKey: key)
        
        dictionary[kSecValueData as String] = value.data(using: String.Encoding.utf8, allowLossyConversion: false) as AnyObject?
        
        let status = SecItemAdd(dictionary as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    class func update(_ value: String, forKey key: String) -> Bool {
        
        let searchDictionary = newSearchDictionary(forKey: key)
        var updateDictionary = [String: AnyObject]()
        
        updateDictionary[kSecValueData as String] = value.data(using: String.Encoding.utf8, allowLossyConversion: false) as AnyObject?
        
        let status = SecItemUpdate(searchDictionary as CFDictionary, updateDictionary as CFDictionary)
        
        return status == errSecSuccess
    }
    
    class func deleteValue(forKey key: String) -> Bool {
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

    class func newSearchDictionary(forKey key: String) -> [String: AnyObject] {
        let encodedIdentifier = key.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        var searchDictionary = basicDictionary()
        searchDictionary[kSecAttrGeneric as String] = encodedIdentifier as AnyObject?
        searchDictionary[kSecAttrAccount as String] = encodedIdentifier as AnyObject?
        
        return searchDictionary
    }
    
    class func basicDictionary() -> [String: AnyObject] {
        
        let serviceName = Bundle(for: self).infoDictionary![kCFBundleIdentifierKey as String] as! String
        
        return [kSecClass as String : kSecClassGenericPassword, kSecAttrService as String : serviceName as AnyObject]
    }
}
