//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import UIKit


public struct Constants {
    public static let cacheSuiteName = "frontstore:contants:cache:suite:name:key"
    
    
    public enum CacheKeys : String {
        case authToken
        case realmMigrationSchemaVersionNumber

        
        static func getValues(excluded: [CacheKeys]) -> [CacheKeys] {
            return [.authToken].filter({ !excluded.contains($0)})
        }
    }
    
    public struct Assessment {
        static let passMark : Double = 60
        static let perfectScoreMark : Double = 100
    }
}
