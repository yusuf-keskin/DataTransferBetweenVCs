//
//  KVO Observer.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 26.09.2022.
//

import Foundation

class PersonObserver {

    var kvoToken: NSKeyValueObservation?
    
    func observe(person: Person) {
        kvoToken = person.observe(\.favoritePet, options: .new) { (person, change) in
            guard let pet = change.newValue else { return }
            print("New pet is: \(pet)")
        }
    }
    
    deinit {
        kvoToken?.invalidate()
    }
}


// Old method

class PersonObserver2: NSObject {
    
    func observe(person: Person) {
        person.addObserver(self, forKeyPath: "age",
                           options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        if keyPath == "age",
           let age = change?[.newKey] {
             print("New age is: \(age)")
        }
    }
}
