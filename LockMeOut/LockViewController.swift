//
//  LockViewController.swift
//  LockMeOut
//
//  Created by Khan Winter on 2/21/21.
//

import UIKit
import LocalAuthentication
import OSLog

class LockViewController: UIViewController {
    
    //MARK: - Data and Outlets
    
    var blurView: UIVisualEffectView? = nil
    
    /// Usage description for touch ID, this is reflected in the Info.plist fot Face ID
    let usageDescription = "This is a test of the LocalAuthentication Framework"

    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up the blurred background
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        blur.contentView.backgroundColor = .clear
        view.addSubview(blur)
        blur.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blur.topAnchor.constraint(equalTo: view.topAnchor),
            blur.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            blur.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blur.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        blurView = blur
        
        view.backgroundColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startUnlock()
    }
    
    //MARK: - Authentication
    
    func startUnlock() {
        Logger(subsystem: "View Cycle", category: "LockViewController").info("\(#function)")
        let context = LAContext()
        var error: NSError? = nil
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: usageDescription) { [weak self] (success, authError) in
                guard let self = self else { return}
                DispatchQueue.main.async {
                    if success {
                        self.handleLAContextSuccess()
                    } else if let error = error {
                        self.handleError(error)
                    } else {
                        self.handleUnknownError()
                    }
                }
            }
        } else {
            // This is where we'd present the keypad for entering a passkey
            let alert = UIAlertController(title: "Uh Oh", message: "It looks like this device doesn't support biometric authentication.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
    }

    //MARK: - Auth Handlers
    
    /// Handle's the success from `LAContext.evaluatePolicy`
    func handleLAContextSuccess() {
        self.dismiss(animated: false, completion: nil)
    }
    
    /// Handles an NSError thrown by `LAContext.evaluatePolicy`
    /// - Parameter error: Error Object
    func handleError(_ error: NSError) {
        // Present an alert
        let alert = UIAlertController(title: "Uh Oh", message: "Something went wrong, please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        
        // Log the error
        Logger(subsystem: "View Cycle", category: "Local Authentication").error("Error: \(error)")
    }
    
    /// Handles the case where success is false and error is nil from `LAContext.evaluatePolicy`
    func handleUnknownError() {
        let alert = UIAlertController(title: "Uh Oh", message: "Something went wrong, please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "Okay", style: .default, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
