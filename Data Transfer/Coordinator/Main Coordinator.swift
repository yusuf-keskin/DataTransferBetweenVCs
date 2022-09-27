//
//  Main Coordinator.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 27.09.2022.
//

import Foundation
import UIKit

enum TransferMethod {
    case notificationCenter
    case kvo
    case closure
    case delegate
}

class MainCoordinator : NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator] ()
    
    var navigationController: UINavigationController
    
    init(navigationController : UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = FirstVC.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
   //Create child controller and give control:
    
    func goToSecondVC () {
        let child = SecondVCCoordinator(navigationController: navigationController)
        
        //set main coordinator as child's parent
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    func secondVCNotifTransferWithMethod(method :TransferMethod) {
        let child = SecondVCCoordinator(navigationController: navigationController)
        
        //set main coordinator as child's parent
        child.parentCoordinator = self
        childCoordinators.append(child)
        
        switch method {
        case .notificationCenter:
            child.transferDataWithNotificationCenter()
        case .kvo:
            child.transferDataWithKVO()
        case .closure:
            child.transferDataWithClosure()
        case .delegate:
            child.transferDataWithDelegate()
        }
        
        
    }
   
    ///remove childs that finihsed the work
    func childDidFinish(_ child : Coordinator?) {
        childCoordinators.removeAll { $0 === child }
        navigationController.dismiss(animated: true)
    }
    
    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        // Read the view controller we’re moving from.
//
//        print(navigationController.viewControllers)
//
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//
//        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//
//        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a buy view controller
//        if let secondVC = fromViewController as? SecondVC {
//
//            // We're popping a buy view controller; end its coordinator
//            childDidFinish(secondVC.coordinator)
//        }
//    }
    
    
    
}
    

