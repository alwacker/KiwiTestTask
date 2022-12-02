//
//  AppRouterOptions.swift
//  KiwiTestTask
//
//  Created by Oleksandr Vaker on 30.11.2022.
//

import Foundation
import UIKit

public class AppRouterOptions: NSObject {
    @objc public static var Default: AppRouterOptions {
        return AppRouterOptions()
    }
    
    @objc public static var ModalWithNavigation: AppRouterOptions {
        return AppRouterOptions(navigation: [
            .all: .Modal(
                options: .Navigation,
                animated: true,
                presentationStyle: .formSheet,
                prefferedSize: nil)]
        )
    }
    
    @objc public static var SmallModalWithoutNavigation: AppRouterOptions {
        return AppRouterOptions(navigation: [
            .phone: .Modal(
                options: .Plain,
                animated: true,
                presentationStyle: .overCurrentContext,
                prefferedSize: CGSize.zero
            ),
            .pad: .Modal(
                options: .Plain,
                animated: true,
                presentationStyle: .formSheet,
                prefferedSize: CGSize(width: 600, height: 600))]
        )
    }
    
    @objc public static var SmallModalWithNavigation: AppRouterOptions {
        return AppRouterOptions(navigation: [
            .phone: .Modal(
                options: .Navigation,
                animated: true,
                presentationStyle: .overCurrentContext,
                prefferedSize: CGSize.zero
            ),
            .pad: .Modal(
                options: .Navigation,
                animated: true,
                presentationStyle: .formSheet,
                prefferedSize: CGSize(width: 600, height: 600)
            )]
        )
    }
    
    @objc public static var ModalWithoutNavigation: AppRouterOptions {
        return AppRouterOptions(navigation: [
            .all: .Modal(
                options: .Plain,
                animated: true,
                presentationStyle: .formSheet,
                prefferedSize: nil)]
        )
    }
    
    @objc public static var ModalOnIpadWithoutNavigation: AppRouterOptions {
        return AppRouterOptions(navigation: [
            .pad: .Modal(
                options: .Plain,
                animated: true,
                presentationStyle: .formSheet,
                prefferedSize: nil)]
        )
    }
    
    @objc public static var ModalOnIpadWithNavigation: AppRouterOptions {
        return AppRouterOptions(navigation: [
            .pad: .Modal(
                options: .Navigation,
                animated: true,
                presentationStyle: .formSheet,
                prefferedSize: nil)]
        )
    }
    
    public enum DeviceIdiom {
        case pad
        case phone
        case all
    }
    
    public enum NavigationType {
        public enum PushOptions {
            case ResetHistory
            case ReplaceLastItem
            case Plain
        }
        
        public enum ModalOptions {
            case Navigation
            case Plain
        }
        
        case Modal(options: ModalOptions, animated: Bool, presentationStyle: UIModalPresentationStyle, prefferedSize: CGSize?)
        case Dialog(options: ModalOptions, animated: Bool)
        case Push(options: PushOptions, animated: Bool)
    }
    
    public typealias DeviceNavigationType = [DeviceIdiom: NavigationType]
    
    public let navigation: NavigationType
    
    public init(navigation: DeviceNavigationType = [.all: .Push(options: .Plain, animated: true)]) {
        if let navigation = AppRouterOptions.resolve(set: navigation) {
            self.navigation = navigation
        } else {
            self.navigation = .Push(options: .Plain, animated: true)
        }
        super.init()
    }
    
    // Resolve navigation for current device type
    private static func resolve(set: DeviceNavigationType) -> NavigationType? {
        if [.phone, .unspecified].contains(UIDevice.current.userInterfaceIdiom),
            let option = set[.phone] {
            return option
        } else if [.pad].contains(UIDevice.current.userInterfaceIdiom), let option = set[.pad] {
            return option
        } else if let option = set[.all] {
            return option
        } else {
            return nil
        }
    }
}
