//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//
import UIKit


public struct Preference {
    static let cache = UserDefaults.init(suiteName: Constants.cacheSuiteName)
    
    public static var authenticated : Bool {
        guard let value : String = Preference.get(.authToken) else { return false }
        return value.isNotEmpty
    }
    
    public static func set(_ key: Constants.CacheKeys, any: Any) {
        if key == .authToken { Logger.log(.d, messages: " AUTH :::::      \(any)") }
        if let image = any as? UIImage, let data = image.pngData() {
            cache?.setValue(data, forKey: key.rawValue)
        } else {
            cache?.setValue(any, forKey: key.rawValue)
        }
    }
    
    public static func get<ANY>(_ key: Constants.CacheKeys) -> ANY? {
        let any = cache?.value(forKey: key.rawValue)
        if let data = any as? Data, let image = UIImage.init(data: data) {
            return image as? ANY
        } else {
            if key == .authToken, let value = any  { Logger.log(.d, messages: "GET AUTH :::::      \(value)") }
            return any as? ANY
        }
    }
    
    public static func remove(_ key: Constants.CacheKeys) {
        Preference.cache?.removeObject(forKey: key.rawValue)
    }
    
    public static func contain(_ key: Constants.CacheKeys) -> Bool {
       return Preference.cache?.value(forKey: key.rawValue) != nil
    }
    
    public static func logout() {
        Constants.CacheKeys.getValues(excluded: []).forEach { key in
            Preference.remove(key)
        }
    }
    
}
