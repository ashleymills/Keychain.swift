//
//  KeychainWrapper.swift
//  Keychain sample app
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import Foundation

private extension Bool {
    var stringValue: String {
        return self ? "true" : "false"
    }
}

//MARK: - Public
public class Keychain {
    
    class func set(_ value:String, forKey key:String) -> Bool {
        if valueExists(forKey: key) {
            return update(value, forKey: key)
        } else {
            return create(value, forKey: key)
        }
    }
    
    class func set(_ bool:Bool, forKey key:String) -> Bool {
        return set(bool.stringValue, forKey: key)
    }
    
    class func value(forKey key: String) -> String? {
        guard let valueData = valueData(forKey: key) else { return nil }
        return String(data: valueData, encoding: .utf8)
    }
    
    class func bool(forKey key: String) -> Bool {
        return value(forKey: key) == true.stringValue
    }
    
    class func removeValue(forKey key:String) -> Bool {
        return deleteValue(forKey: key)
    }
    
    class func reset() -> Bool {
        
        let searchDictionary = basicDictionary()
        let status = SecItemDelete(searchDictionary as CFDictionary)
        return status == errSecSuccess
    }
    
    class func allValues() -> [[String: String]]?  {
        
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
            let attributeDicts = retrievedAttributes as? [[String: Any]] else { return nil }
        
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

//MARK: - fileprivate
fileprivate extension Keychain {
    class func valueExists(forKey key: String) -> Bool {
        return valueData(forKey: key) != nil
    }
    
    class func create(_ value: String, forKey key: String) -> Bool {
        var dictionary = newSearchDictionary(forKey: key)
        
        dictionary[kSecValueData as String] = value.data(using: .utf8, allowLossyConversion: false)

        let status = SecItemAdd(dictionary as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    class func update(_ value: String, forKey key: String) -> Bool {
        
        let searchDictionary = newSearchDictionary(forKey: key)
        var updateDictionary = [String: Any]()
        
        updateDictionary[kSecValueData as String] = value.data(using: .utf8, allowLossyConversion: false)
        
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
        
        var retrievedData: CFTypeRef? = nil
        let status = SecItemCopyMatching(searchDictionary as CFDictionary, &retrievedData)
        
        return status == errSecSuccess ? retrievedData as? Data : nil
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
        
        return [kSecClass as String : kSecClassGenericPassword, kSecAttrService as String : serviceName]
    }
}
