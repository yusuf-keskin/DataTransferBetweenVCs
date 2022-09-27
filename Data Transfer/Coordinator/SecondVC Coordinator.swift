//
//  SecondVC Coordinator.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 27.09.2022.
//

import UIKit

class SecondVCCoordinator : Coordinator {
    
    weak var parentCoordinator : MainCoordinator?

    var childCoordinators = [Coordinator] ()
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SecondVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didFinishBuying() {
        parentCoordinator?.childDidFinish(self)
    }

   
    func transferDataWithClosure() {
//        let vc = SecondVC.instantiate()
//        vc.coordinator = self
//        vc.colorClosure = { [weak self] color in
//            DispatchQueue.main.async {
//                vc.view.backgroundColor = color
//            }
//        }
//        navigationController.pushViewController(vc, animated: true)
    }
    
    func transferDataWithDelegate() {
//        let vc = SecondVC.instantiate()
//        vc.coordinator = self
//        vc.delegate = FirstVC() as? ColorTransferDelegate
//        navigationController.pushViewController(vc, animated: true)
  }
    
    func transferDataWithKVO() {
        let vc = SecondVC.instantiate()
        vc.coordinator = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            vc.newPerson.favoritePet = "Demsy is a cat"
        }
        navigationController.pushViewController(vc, animated: true)
    }
    
    func transferDataWithNotificationCenter() {
        
        //Define user Info for selection data to transfer
        let mycat = Cat()
        let userInfo = ["text" : mycat]
        
        //Delay notification otherwise action happen before vc initialized
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            NotificationCenter.default.post(name: NSNotification.catWaiting, object: self, userInfo: userInfo)
        }
        
        let vc = SecondVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }

}

