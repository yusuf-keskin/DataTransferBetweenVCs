//
//  StoryBoardedProtocol.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 27.09.2022.
//

import UIKit

protocol Storyboarded {
    
    // Who confirms this protocol will have it's own type instantiate method! and return
    //it's own type. Example, if nav controller return nav, if view controller return vc
    
    static func instantiate () -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate () -> Self{
        
        // Create VC id from VC's name:
        let id = String(describing: self)
        
        //Here we instantiate it. So, later we won't write all this instantiate code,
        // instead, we'll use instantiate method on vc (vc.instantiate()) and it'll work
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        //We can forcecast "id as!" because all VC will have the its own name as id
        //since we defined it above so!
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}

