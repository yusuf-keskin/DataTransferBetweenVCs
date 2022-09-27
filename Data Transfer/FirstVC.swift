//
//  FirstVC.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 26.09.2022.
//

import UIKit

class FirstVC: UIViewController, ColorTransferDelegate, Storyboarded {
    
    //Notification center will send this as data
    var mycat = Cat()
    
    weak var coordinator : MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func protocolDelegateDataTransferBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC

        //Delegate Trigger Backward
        vc.delegate = self
        present(vc, animated: true)
//    coordinator?.secondVCNotifTransferWithMethod(method: .delegate)
    }
    
    @IBAction func setCatHungrynessWithNotification(_ sender: Any) {
        coordinator?.secondVCNotifTransferWithMethod(method: .notificationCenter)
    }
    
    
    @IBAction func backgroundColorSetWithClosure(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "SecondVC") as! SecondVC
        //Closure trigger backward
        vc.colorClosure = { [weak self] color in
            DispatchQueue.main.async {
                self!.view.backgroundColor = color
            }
        }
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func catHungynessByKVO(_ sender: Any) {
        coordinator?.secondVCNotifTransferWithMethod(method: .kvo)
    }
    
    
    //Delegate's method
    func setColor(withUIColor color: UIColor) {
        DispatchQueue.main.async {
            self.view.backgroundColor = color
        }
    }
    
    
}

