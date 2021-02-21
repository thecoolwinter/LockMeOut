//
//  ViewController.swift
//  LockMeOut
//
//  Created by Khan Winter on 2/21/21.
//

import UIKit
import LocalAuthentication
import OSLog

class ViewController: UIViewController {

    //MARK: - Outlets & Data
    
    @IBOutlet weak var tapToStartButton: UIButton!
    
    //MARK: - View Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButton()
    }

    func updateButton() {
        if KeychainWrapper.standard.bool(forKey: "lock_me_out_lock_enabled") ?? false {
            tapToStartButton.setTitle("Tap To Disable Lock", for: .normal)
        } else {
            tapToStartButton.setTitle("Tap To Enable Lock", for: .normal)
        }
    }
    
    //MARK: - Start Tapped

    @IBAction func startTapped(_ sender: UIButton) {
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            KeychainWrapper.standard.set(!(KeychainWrapper.standard.bool(forKey: "lock_me_out_lock_enabled") ?? false), forKey: "lock_me_out_lock_enabled")
        } else {
            // This device doesn't support biometric auth. :(
            let alert = UIAlertController(title: "Uh Oh", message: "It looks like this device doesn't support biometric authentication.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        updateButton()
    }
}

