//
//  Segue.swift
//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 04/12/2021.
//




import UIKit
import Swinject



protocol Segueable {
    var anyData : Any? { get set }
}

protocol Dismissable {
    var dismissHandler : (() -> Void)? { get set }
}


struct Segue {
    
    static func push<Service>(_ page: Service.Type, controller: UIViewController, anyData: Any?, dismissableHandler: (() -> Void)? = nil ) {
        guard let resolvedController = resolve(page, anyData: anyData, dismissableHandler: dismissableHandler) else { return }
        controller.navigationController?.pushViewController(resolvedController, animated: true)
    }
    

    private static func resolve<Service>(_ page: Service.Type, anyData: Any?, dismissableHandler: (() -> Void)?) -> UIViewController? {
        
        let container = AppDelegate.app.container
        guard let resolvedController = container?.resolve(page) as? UIViewController else { return nil }
        
        if var segueWithDataController = resolvedController as? Segueable {
            segueWithDataController.anyData = anyData
        }
        
        return resolvedController
    }
    
}



