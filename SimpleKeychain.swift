//
//  KeychainWrapper.swift
//  SimpleKeychain sample app
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import Foundation

class SimpleKeychain {
    
    // MARK: - *** Public methods ***
    class func set(value:String, forKey key:String) -> Bool {
        if valueExists(forKey: key) {
            return update(value, forKey: key)
        } else {
            return create(value, forKey: key)
        }
    }
    
    class func set(bool:Bool, forKey key:String) -> Bool {
        let value = bool ? "true" : "false"
        return set(value, forKey: key)
    }
    
    class func value(forKey key: String) -> String? {
        guard let valueData = valueData(forKey: key) else { return nil }
        
        return NSString(data: valueData, encoding: NSUTF8StringEncoding) as? String
    }
    
    class func bool(forKey key: String) -> Bool {
        return value(forKey: key) == "true"
    }
    
    class func removeValue(forKey key:String) -> Bool {
        return deleteValue(forKey: key)
    }
    
    class func reset() -> Bool {
        
        let searchDictionary = basicDictionary()
        let status = SecItemDelete(searchDictionary)
        return status == errSecSuccess
    }
    
    // MARK: - *** methods ***
    private class func valueExists(forKey key: String) -> Bool {
        return valueData(forKey: key) != nil
    }
    
    private class func create(value: String, forKey key: String) -> Bool {
        var dictionary = newSearchDictionary(forKey: key)
        
        dictionary[kSecValueData as String] = value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)

        let status = SecItemAdd(dictionary, nil)
        return status == errSecSuccess
    }
    
    private class func update(value: String, forKey key: String) -> Bool {
        
        let searchDictionary = newSearchDictionary(forKey: key)
        var updateDictionary = [String: AnyObject]()
        
        updateDictionary[kSecValueData as String] = value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        let status = SecItemUpdate(searchDictionary, updateDictionary)
        
        return status == errSecSuccess
    }
    
    private class func deleteValue(forKey key: String) -> Bool {
        let searchDictionary = newSearchDictionary(forKey: key)
        let status = SecItemDelete(searchDictionary)
        
        return status == errSecSuccess
    }
    
    private class func valueData(forKey key: String) -> NSData?  {
        
        var searchDictionary = newSearchDictionary(forKey: key)
        
        searchDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var retrievedData: AnyObject?
        let status = SecItemCopyMatching(searchDictionary as CFDictionaryRef, &retrievedData)
        
        var data: NSData?
        if status == errSecSuccess {
            data = retrievedData as? NSData
        }
        
        return data
    }
    
    class func allValues() -> [[String: String]]?  {
        
        var searchDictionary = basicDictionary()
        
        searchDictionary[kSecMatchLimit as String] = kSecMatchLimitAll
        searchDictionary[kSecReturnAttributes as String] = kCFBooleanTrue
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var retrievedAttributes: AnyObject?
        var retrievedData: AnyObject?
        
        var status = SecItemCopyMatching(searchDictionary as CFDictionaryRef, &retrievedAttributes)
        if status != errSecSuccess {
            return nil
        }

        status = SecItemCopyMatching(searchDictionary as CFDictionaryRef, &retrievedData)
        if status != errSecSuccess {
            return nil
        }

        guard let attributeDicts = retrievedAttributes as? [[String: AnyObject]] else { return nil }

        var allValues = [[String : String]]()
        for attributeDict in attributeDicts {
            guard let keyData = attributeDict[kSecAttrAccount as String] as? NSData else { continue }
            guard let valueData = attributeDict[kSecValueData as String] as? NSData else { continue }
            guard let key = NSString(data: keyData, encoding: NSUTF8StringEncoding) as? String else { continue }
            guard let value = NSString(data: valueData, encoding: NSUTF8StringEncoding) as? String else { continue }
            allValues.append([key: value])
        }
        
        return allValues
    }
    
    private class func newSearchDictionary(forKey key: String) -> [String: AnyObject] {
        let encodedIdentifier = key.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        var searchDictionary = basicDictionary()
        searchDictionary[kSecAttrGeneric as String] = encodedIdentifier
        searchDictionary[kSecAttrAccount as String] = encodedIdentifier
        
        return searchDictionary
    }
    
    private class func basicDictionary() -> [String: AnyObject] {
        
        let serviceName = NSBundle(forClass: self).infoDictionary![kCFBundleIdentifierKey as String] as! String
        
        return [kSecClass as String : kSecClassGenericPassword, kSecAttrService as String : serviceName]
    }
}
