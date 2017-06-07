//
//  Keychain_swift_Tests.swift
//  Keychain.swift Tests
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import UIKit
import XCTest
@testable import Simple_KeychainSwift

class Keychain_swift_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        Keychain.reset()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    
    func testSet() {
        var success = Keychain.set("value1", forKey: "key1")
        XCTAssertTrue(success, "Keychain.createKeychain should return true")
        
        success = Keychain.set("value2", forKey: "key2")
        XCTAssertTrue(success, "Keychain.createKeychain should return true")
        
        success = Keychain.set("value2a", forKey: "key2")
        XCTAssertTrue(success, "Keychain.createKeychain should return true")
    }
    
    func testValue() {
        var value = Keychain.value(forKey: "key1")
        XCTAssertTrue(value == nil, "Keychain.value should return nil if the key doesn't exist")
        
        Keychain.set("value1", forKey: "key1")
        value = Keychain.value(forKey: "key1")
        XCTAssertEqual(value!, "value1", "Keychain.value should return the correct value after update")
        
        Keychain.set("value2", forKey: "key2")
        value = Keychain.value(forKey: "key2")
        XCTAssertEqual(value!, "value2", "Keychain.value should return the correct value after update")
        
        Keychain.set("value2a", forKey: "key2")
        value = Keychain.value(forKey: "key2")
        XCTAssertEqual(value!, "value2a", "Keychain.value should return the correct value after update")
    }
    
    func testRemoveValue() {
        Keychain.set("value1", forKey: "key1")
        Keychain.set("value2", forKey: "key2")

        var success = Keychain.removeValue(forKey: "key1")
        XCTAssertTrue(success, "Keychain.removeValue should return true if the key exists")
        
        success = Keychain.removeValue(forKey: "key3")
        XCTAssertFalse(success, "Keychain.removeValue should return falue if the key doesn't exist")
        
        var value = Keychain.value(forKey: "key1")
        XCTAssertTrue(value == nil, "Keychain.value should return nil if the key was removed")

        value = Keychain.value(forKey: "key2")
        XCTAssertEqual(value!, "value2", "Keychain.value should return the correct value for non removed keys")
    }

    func testReset() {
        Keychain.set("value1", forKey: "key1")
        Keychain.set("value2", forKey: "key2")
        
        let success = Keychain.reset()
        XCTAssertTrue(success, "Keychain.reset should return true")
        
        var value = Keychain.value(forKey: "key1")
        XCTAssertTrue(value == nil, "Keychain.value should return nil after reset")
        
        value = Keychain.value(forKey: "key2")
        XCTAssertTrue(value == nil, "Keychain.value should return nil after reset")
    }
}
