//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


struct Configuration {
    static let value = Environment.staged
    private init(){}
}


protocol IBaseEnvUrl {
    func getUrl(_ env: Environment) -> String
}

enum  BaseEnvUrl {
    case finn_hub
}

enum Environment {
    case staged
     case live
     
    
    func get_environment_based_url(_ env: BaseEnvUrl) -> String {
        switch env {
        case .finn_hub:
            return StockBaseUrl.getUrl(self)
        }
    }
}

protocol IEndPoints {
    func getValue() -> String
    func getEnvUrl() -> BaseEnvUrl
}


extension IEndPoints {
    func getUrlfullPath() -> String {
        return "\(Configuration.value.get_environment_based_url(getEnvUrl()) + self.getValue())"
    }
}




extension IEndPoints {
    
    func connect<R:Decodable>(method: Methods, handler: @escaping ((RemoteResult<R, String>) -> Void)) {
        Remote.init().connect(method: method, endpoint: self, handler: handler)
    }
    
    func connect<R>(method: Methods, body: Body, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        Remote.init().connect(method: method, endpoint: self, body: body, handler: handler)
    }
    
    func connect<R>(method: Methods, body: Body, pathValue: PathValue, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        Remote.init().connect(method: method, endpoint: self, body: body, pathValue: pathValue, handler: handler)
    }
    
    func connect<R>(method: Methods, body: Body, pathQuery: String = "", handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        Remote.init().connect(method: method, endpoint: self, body: body, pathQuery: pathQuery, handler: handler)
    }
    
    func connect<R>(method: Methods, form: Form, pathValue: PathValue?, pathQuery: String = "", handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        Remote.init().connect(method: method, endpoint: self, form: form, pathValue: pathValue, pathQuery: pathQuery, handler: handler)
    }
    
    func connect<R>(method: Methods, pathValue: PathValue?, pathQuery: String = "", handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        Remote.init().connect(method: method, endpoint: self, pathValue: pathValue, pathQuery: pathQuery, handler: handler)
    }
}
