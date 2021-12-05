//
//  AppDelegateUtils.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 30/11/2021.
//


import UIKit

final class AppDelegateUtils {
    
    static func visibleController () -> UIViewController? {
        var controller : UIViewController?
        
        if let value = AppDelegateUtils.getWindow()?.rootViewController?.navigationController?.viewControllers.last {
            controller = value
        } else if let value = getWindow()?.rootViewController {
            controller = value
        }
        
        return controller
    }
    
    static func getApp() -> AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    @available(iOS 13.0, *)
    static func getScene() -> SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
    
    static var  becomeActiveDidCalled : Bool {
        
        if #available(iOS 13.0, *) {
            return getScene()?.becomeActiveDidCalled ?? false
        } else {
            // Fallback on earlier versions
            return getApp()?.becomeActiveDidCalled ?? false
        }
    }

    
    static func getWindow() -> UIWindow? {
        var window : UIWindow!
        
        if #available(iOS 13.0, *) {
            window = getScene()?.window
        } else {
            // Fallback on earlier versions
            window = getApp()?.window
        }
        
        return window
    }
    
    
    
    static func routeToHomePage() {
        guard let window = getWindow() else { return }
        guard let controller = getApp()?.container.resolve(ListStockPricePage.self) else { return }
        window.rootViewController = UINavigationController.init(rootViewController: controller)
    }
}
