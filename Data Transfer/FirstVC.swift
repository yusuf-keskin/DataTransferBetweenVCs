//
//  FirstVC.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 26.09.2022.
//

import UIKit

class FirstVC: UIViewController, ColorTransferDelegate {
    
    //Notification center will send this as data
    var mycat = Cat()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func protocolDelegateDataTransferBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        
        //Delegate Trigger Backward
        vc.delegate = self
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    @IBAction func setCatHungrynessWithNotification(_ sender: Any) {
        
        //Define user Info for selection data to transfer
        let userInfo = ["text" : mycat]
        
        //Delay notification otherwise action happen before vc initialized
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            NotificationCenter.default.post(name: NSNotification.catWaiting, object: self, userInfo: userInfo)
        }
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func backgroundColorSetWithClosure(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        //Closure trigger backward
        vc.colorClosure = { color in
            DispatchQueue.main.async {
                self.view.backgroundColor = color
            }
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func catHungynessByKVO(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        
        
        // KVO trigger forward / backward?
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            vc.newPerson.favoritePet = "Demsy is a cat"
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //Delegate's method
    func setColor(withUIColor color: UIColor) {
        DispatchQueue.main.async {
            self.view.backgroundColor = color
        }
    }
    
    
}

