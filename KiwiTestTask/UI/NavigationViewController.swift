//
//  NavigationViewController.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import UIKit

class NavigationViewController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setupLargeTitle()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setupLargeTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLargeTitle() {
        self.navigationBar.prefersLargeTitles = true
    }
}
