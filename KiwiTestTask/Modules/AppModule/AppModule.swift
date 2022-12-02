//
//  AppModule.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import UIKit

class AppModule {
    private let container: DIContainer

    init(container: DIContainer) {
        self.container = container
        setUpAppearance()
    }

    public lazy var router: AppRouter = {
        return .init(container: container)
    }()

    private func setUpAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemPink
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemPink.withAlphaComponent(0.2)
    }
}
