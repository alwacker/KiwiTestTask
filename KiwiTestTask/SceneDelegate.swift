//
//  SceneDelegate.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        appDelegate?.window = self.window
        let viewController = AppModule(container: DIContainer()).router.showPopularFlights()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        window?.overrideUserInterfaceStyle = .light
    }
}
