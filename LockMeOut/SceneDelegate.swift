//
//  SceneDelegate.swift
//  LockMeOut
//
//  Created by Khan Winter on 2/21/21.
//

import UIKit
import LocalAuthentication
import OSLog

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
//        guard let windowScene = (scene as? UIWindowScene) else { return }
        Logger(subsystem: "View Cycle", category: "Scene Delegate").info("\(#function)")
//        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        window?.windowScene = windowScene
//        window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
//        window?.makeKeyAndVisible()
    }
        
    func sceneWillEnterForeground(_ scene: UIScene) {
        Logger(subsystem: "View Cycle", category: "Scene Delegate").info("\(#function)")
        if KeychainWrapper.standard.bool(forKey: "lock_me_out_lock_enabled") ?? false {
            Logger(subsystem: "View Cycle", category: "Local Authentication").info("Lock out enabled, starting Local Authentication")
            let lockController = LockViewController()
            lockController.modalPresentationStyle = .overCurrentContext
            window?.rootViewController?.present(lockController, animated: false, completion: nil)
        } else {
            Logger(subsystem: "View Cycle", category: "Local Authentication").info("Lock out disabled, ignoring")
        }
    }
    
//    var hasAlreadyPresentedLock: Bool = false
//    func sceneDidBecomeActive(_ scene: UIScene) {
//        Logger(subsystem: "View Cycle", category: "Scene Delegate").info("\(#function)")
//        if KeychainWrapper.standard.bool(forKey: "lock_me_out_lock_enabled") ?? false {
//            Logger(subsystem: "View Cycle", category: "Local Authentication").info("Lock out enabled, starting Local Authentication")
//
//            if !hasAlreadyPresentedLock {
//                let lockController = LockViewController()
//                lockController.modalPresentationStyle = .overCurrentContext
//                window?.rootViewController?.present(lockController, animated: false, completion: nil)
//                hasAlreadyPresentedLock.toggle()
//            }
//        } else {
//            Logger(subsystem: "View Cycle", category: "Local Authentication").info("Lock out disabled, ignoring")
//        }
//    }
    
}

