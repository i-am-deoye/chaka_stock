//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 30/11/2021.
//


import Foundation


public class NotificationHelper {
    
    public static func post(_ name: NSNotification.Name, object: Any?, userInfo: [AnyHashable: Any]?) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInfo)
    }
    
    
    public static func observe(_ receiver: Any, selector: Selector, name: NSNotification.Name) {
        NotificationCenter.default.addObserver(receiver, selector: selector, name: name, object: nil)
    }
    
    public static func remove(_ receiver: Any) {
        NotificationCenter.default.removeObserver(receiver)
    }
    
    public static func remove(_ receiver: Any, name: NSNotification.Name) {
        NotificationCenter.default.removeObserver(receiver, name: name, object: nil)
    }
    
    
    public static func logout(object: Any) {
        NotificationHelper.post(.ShouldLogout, object: object, userInfo: nil)
    }
}



extension NSNotification.Name {
    public static let ShouldLogout = NSNotification.Name.init("ShouldLogout")
    public static let TokenIsExpiredNotification = NSNotification.Name(rawValue: "TokenIsExpiredNotification")
}
