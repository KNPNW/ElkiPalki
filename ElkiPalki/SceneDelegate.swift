//
//  SceneDelegate.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 25.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    public var authState: Bool = false{
        didSet {
//            changeAuth(authState: authState)
        }
    }
    

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let isFirst = UserSettings.isFirstLaunch ?? true
        if isFirst {
            window?.rootViewController = FirstViewController()
        } else {
            window?.rootViewController = MainViewController(auth: UserSettings.isAuthorized ?? false)
        }
        window?.makeKeyAndVisible()
        
    }
    
    func changeRootViewController(animated: Bool = true) {
        guard let window = self.window else {
            return
        }
        // change the root view controller to your specific view controller
        let isFirst = UserSettings.isFirstLaunch ?? true
        if isFirst {
            window.rootViewController = FirstViewController()
        } else {
            window.rootViewController = MainViewController(auth: UserSettings.isAuthorized ?? false)
        }
        
        UIView.transition(with: window,
                              duration: 0.5,
                              options: [.transitionFlipFromLeft],
                              animations: nil,
                              completion: nil)
    }
}


