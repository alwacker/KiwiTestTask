//
//  TransitionHandler.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import UIKit

public protocol TransitionHandler {
    func push(controller: UIViewController, animated: Bool)
    func modal(controller: UIViewController, animated: Bool)
}

extension UIViewController: TransitionHandler {
    public func modal(controller: UIViewController, animated: Bool) {
        self.present(controller, animated: animated, completion: nil)
    }
    
    public func push(controller: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(controller, animated: animated)
    }
}
