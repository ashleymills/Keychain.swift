//
//  KeychainWrapper.swift
//  Keychain sample app
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import Foundation

class Keychain {
    
    // MARK: - *** Public methods ***
    class func set(value:String, forKey key:String) -> Bool {
        if valueExists(forKey: key) {
            return update(value, forKey: key)
        } else {
            return create(value, forKey: key)
        }
    }
    
    class func value(forKey key: String) -> String? {
        if let valueData = valueData(forKey: key) {
            return NSString(data: valueData, encoding: NSUTF8StringEncoding) as? String
        }
        
        return nil
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
        
        var searchDictionary = newSearchDictionary(forKey: key)
        var updateDictionary = [String: AnyObject]()
        
        updateDictionary[kSecValueData as String] = value.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        let status = SecItemUpdate(searchDictionary, updateDictionary)
        
        return status == errSecSuccess
    }
    
    private class func deleteValue(forKey key: String) -> Bool {
        var searchDictionary = newSearchDictionary(forKey: key)
        let status = SecItemDelete(searchDictionary)
        
        return status == errSecSuccess
    }
    
    private class func valueData(forKey key: String) -> NSData?  {
        
        var searchDictionary = newSearchDictionary(forKey: key)
        
        searchDictionary[kSecMatchLimit as String] = kSecMatchLimitOne
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var dataTypeRef: Unmanaged<AnyObject>?

        let status = SecItemCopyMatching(searchDictionary as CFDictionaryRef, &dataTypeRef)
        
        var data: NSData?
        if status == errSecSuccess {
            data = dataTypeRef!.takeRetainedValue() as? NSData
        }
        
        return data
    }
    
    private class func newSearchDictionary(forKey key: String) -> [String: AnyObject] {
        let encodedIdentifier = key.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        
        var searchDictionary = basicDictionary()
        searchDictionary[kSecAttrGeneric as String] = encodedIdentifier
        searchDictionary[kSecAttrAccount as String] = encodedIdentifier
        
        return searchDictionary
    }
    
    private class func basicDictionary() -> [String: AnyObject] {
        
        let serviceName = NSBundle(forClass: self).infoDictionary![kCFBundleIdentifierKey] as! String
        
        return [kSecClass as String : kSecClassGenericPassword, kSecAttrService as String : serviceName]
    }
}
