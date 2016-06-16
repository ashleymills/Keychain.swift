//
//  Keychain_swift_Tests.swift
//  SimpleKeychain.swift Tests
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import UIKit
import XCTest

class Keychain_swift_Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        SimpleKeychain.reset()
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
        var success = SimpleKeychain.set("value1", forKey: "key1")
        XCTAssertTrue(success, "SimpleKeychain.createKeychain should return true")
        
        success = SimpleKeychain.set("value2", forKey: "key2")
        XCTAssertTrue(success, "SimpleKeychain.createKeychain should return true")
        
        success = SimpleKeychain.set("value2a", forKey: "key2")
        XCTAssertTrue(success, "SimpleKeychain.createKeychain should return true")
    }
    
    func testValue() {
        var value = SimpleKeychain.value(forKey: "key1")
        XCTAssertTrue(value == nil, "SimpleKeychain.value should return nil if the key doesn't exist")
        
        SimpleKeychain.set("value1", forKey: "key1")
        value = SimpleKeychain.value(forKey: "key1")
        XCTAssertEqual(value!, "value1", "SimpleKeychain.value should return the correct value after update")
        
        SimpleKeychain.set("value2", forKey: "key2")
        value = SimpleKeychain.value(forKey: "key2")
        XCTAssertEqual(value!, "value2", "SimpleKeychain.value should return the correct value after update")
        
        SimpleKeychain.set("value2a", forKey: "key2")
        value = SimpleKeychain.value(forKey: "key2")
        XCTAssertEqual(value!, "value2a", "SimpleKeychain.value should return the correct value after update")
    }
    
    func testRemoveValue() {
        SimpleKeychain.set("value1", forKey: "key1")
        SimpleKeychain.set("value2", forKey: "key2")

        var success = SimpleKeychain.removeValue(forKey: "key1")
        XCTAssertTrue(success, "SimpleKeychain.removeValue should return true if the key exists")
        
        success = SimpleKeychain.removeValue(forKey: "key3")
        XCTAssertFalse(success, "SimpleKeychain.removeValue should return falue if the key doesn't exist")
        
        var value = SimpleKeychain.value(forKey: "key1")
        XCTAssertTrue(value == nil, "SimpleKeychain.value should return nil if the key was removed")

        value = SimpleKeychain.value(forKey: "key2")
        XCTAssertEqual(value!, "value2", "SimpleKeychain.value should return the correct value for non removed keys")
    }

    func testReset() {
        SimpleKeychain.set("value1", forKey: "key1")
        SimpleKeychain.set("value2", forKey: "key2")
        
        let success = SimpleKeychain.reset()
        XCTAssertTrue(success, "SimpleKeychain.reset should return true")
        
        var value = SimpleKeychain.value(forKey: "key1")
        XCTAssertTrue(value == nil, "SimpleKeychain.value should return nil after reset")
        
        value = SimpleKeychain.value(forKey: "key2")
        XCTAssertTrue(value == nil, "SimpleKeychain.value should return nil after reset")
    }
}
