//
//  Navigator.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import UIKit

class Navigator {
    static var rootViewController: UIViewController? {
        if let window = UIApplication.shared.delegate?.window {
            return window?.rootViewController
        }
        return nil
    }
    
    static func getRootNavigationViewController(rootController: UIViewController) -> UINavigationController {
        let rootViewController = Navigator.rootViewController
        if let rootNavigationController = rootViewController as? NavigationViewController {
            return rootNavigationController
        } else {
            let navigationController = NavigationViewController(rootViewController: rootController)
            navigationController.navigationBar.isTranslucent = false
            navigationController.navigationBar.isOpaque = true
            return navigationController
        }
    }
    
    static func showModalViewController(
        _ vc: UIViewController,
        inNavigationController: Bool,
        animated: Bool) {
        let root = Navigator.rootViewController
        vc.modalPresentationStyle = .automatic
        vc.modalTransitionStyle = .flipHorizontal
        vc.providesPresentationContextTransitionStyle = true
        vc.definesPresentationContext = true
        root?.present(vc, animated: animated)
    }
}
