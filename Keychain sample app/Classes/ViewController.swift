//
//  ViewController.swift
//  SimpleKeychain sample app
//
//  Created by Ashley Mills on 17/04/2015.
//  Copyright (c) 2015 Joylord Systems Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var addKey: UITextField!
    @IBOutlet private weak var addValue: UITextField!

    @IBOutlet private weak var fetchKey: UITextField!
    @IBOutlet private weak var fetchValue: UILabel!
    
    @IBOutlet private weak var deleteKey: UITextField!


    @IBAction private func addToKeychain(sender: AnyObject) {
        SimpleKeychain.set(addValue.text!, forKey: addKey.text!)
        print("\(SimpleKeychain.allValues())")
    }

    @IBAction private func fetchFromKeychain(sender: AnyObject) {
        fetchValue.text = SimpleKeychain.value(forKey: fetchKey.text!) ?? "Not found"
        print("\(SimpleKeychain.allValues())")
    }

    @IBAction private func deleteFromKeychain(sender: AnyObject) {
        SimpleKeychain.removeValue(forKey: deleteKey.text!)
        print("\(SimpleKeychain.allValues())")
    }

    @IBAction private func resetKeychain(sender: AnyObject) {
        SimpleKeychain.reset()
        print("\(SimpleKeychain.allValues())")
    }
}

