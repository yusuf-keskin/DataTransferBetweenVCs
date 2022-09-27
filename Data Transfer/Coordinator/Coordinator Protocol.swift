//
//  Coordinator Protocol.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 27.09.2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {

    // Create child (coodinators tree beneath)
    var childCoordinators : [Coordinator] { get set }
    // Create navigator
    var navigationController : UINavigationController { get set }

    func start()
}
 
