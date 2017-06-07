//
//  ViewController.swift
//  Keychain sample app
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate weak var addKey: UITextField!
    @IBOutlet fileprivate weak var addValue: UITextField!

    @IBOutlet fileprivate weak var fetchKey: UITextField!
    @IBOutlet fileprivate weak var fetchValue: UILabel!
    
    @IBOutlet fileprivate weak var deleteKey: UITextField!


    @IBAction fileprivate func addToKeychain(_ sender: AnyObject) {
        Keychain.set(addValue.text!, forKey: addKey.text!)
        print("\(Keychain.allValues() ?? [])")
    }

    @IBAction fileprivate func fetchFromKeychain(_ sender: AnyObject) {
        fetchValue.text = Keychain.value(forKey: fetchKey.text!) ?? "Not found"
        print("\(Keychain.allValues() ?? [])")
    }

    @IBAction fileprivate func deleteFromKeychain(_ sender: AnyObject) {
        Keychain.removeValue(forKey: deleteKey.text!)
        print("\(Keychain.allValues() ?? [])")
    }

    @IBAction fileprivate func resetKeychain(_ sender: AnyObject) {
        Keychain.reset()
        print("\(Keychain.allValues() ?? [])")
    }
}

