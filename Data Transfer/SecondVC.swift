//
//  SecondVC.swift
//  Data Transfer
//
//  Created by YUSUF KESKİN on 26.09.2022.
//

import UIKit
typealias completionHandler = (_ color : UIColor)->()
class SecondVC: UIViewController, Storyboarded {
    
    weak var coordinator : SecondVCCoordinator?
    
    @IBOutlet weak var hungryCatLbl: UILabel!
    @IBOutlet weak var catNameLbl: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var delegate : ColorTransferDelegate?
    
    
    var colorClosure : completionHandler?
    
    var kvoToken: NSKeyValueObservation?
    var newPerson = Person()


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kvoToken = newPerson.observe(\.favoritePet, options: .new) { [weak self] (person, change) in
            guard let pet = change.newValue else { return }
            self!.catNameLbl.text = pet
        }
        

        NotificationCenter.default.addObserver(self, selector: #selector(self.notificationReceived(_:)), name: NSNotification.catWaiting, object: nil)
        

    }
 
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        coordinator?.didFinishBuying()
    }
    
   
    @objc func notificationReceived(_ notification: Notification) {
        guard let cat = notification.userInfo?["text"] as? Cat else { return }
        hungryCatLbl.text = cat.hungryness
    }
    
    
    @IBAction func didSelectSegmentForColorSelect(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0 :
            delegate?.setColor(withUIColor: UIColor.white)
        case 1 :
            delegate?.setColor(withUIColor: UIColor.blue)
        case 2:
            delegate?.setColor(withUIColor: UIColor.red)
        default:
            delegate?.setColor(withUIColor: UIColor.white)
        }
    }
    
    @IBAction func didDelayedColorValueChange(_ sender: Any) {
        guard let colorClosure = colorClosure else {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            colorClosure(UIColor.green)
        }
    }
    
    @IBAction func setCatNameKVOActtionBtn(_ sender: Any) {
        newPerson.favoritePet = "Demsy"
    }
    
    @IBAction func closeBtnTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
}


