//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import Foundation


enum Methods : String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


public enum RemoteResult<R, E> {
    case success(payload: R)
    case failure(error : E)
}

public enum ViewModelState<R> {
    case loading
    case result(payload: R)
    case failure(error : String)
}


typealias Body = Data
typealias PathValue = [String:Any]
typealias Form = [String:Any]




protocol IRemote {
    
    func connect<R:Decodable>(method: Methods,
                    endpoint: IEndPoints,
                              form: Form,
                              pathValue: PathValue?,
                              pathQuery: String?,
                    handler: @escaping ((RemoteResult<R, String>) -> Void))
    
    func connect<R:Decodable>(method: Methods,
                    endpoint: IEndPoints,
                              body: Body,
                              pathQuery: String,
                    handler: @escaping ((RemoteResult<R, String>) -> Void))
    
    func connect<R:Decodable>(method: Methods,
                    endpoint: IEndPoints,
                              body: Body,
                              pathValue: PathValue,
                    handler: @escaping ((RemoteResult<R, String>) -> Void))
    
    func connect<R:Decodable>(method: Methods,
                    endpoint: IEndPoints,
                              body: Body,
                    handler: @escaping ((RemoteResult<R, String>) -> Void))
    
    func connect<R:Decodable>(method: Methods,
                    endpoint: IEndPoints,
                    handler: @escaping ((RemoteResult<R, String>) -> Void))
    
    func connect<R:Decodable>(method: Methods,
                    endpoint: IEndPoints,
                              pathValue: PathValue?,
                              pathQuery: String?,
                    handler: @escaping ((RemoteResult<R, String>) -> Void))
}


final class Remote: NSObject, IRemote, URLSessionDelegate {
    private lazy var session : URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 1200
        return Foundation.URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    
    func connect<R:Decodable>(method: Methods, endpoint: IEndPoints, handler: @escaping ((RemoteResult<R, String>) -> Void)) {
        configure(method: method, endpoint: endpoint, handler: handler)
    }
    
    func connect<R>(method: Methods, endpoint: IEndPoints, body: Body, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        configure(method: method, endpoint: endpoint, body: body, handler: handler)
    }
    
    func connect<R>(method: Methods, endpoint: IEndPoints, body: Body, pathValue: PathValue, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        configure(method: method, endpoint: endpoint, body: body, pathValue: pathValue, handler: handler)
    }
    
    func connect<R>(method: Methods, endpoint: IEndPoints, body: Body, pathQuery: String, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        configure(method: method, endpoint: endpoint, body: body, pathQuery: pathQuery, handler: handler)
    }
    
    func connect<R>(method: Methods, endpoint: IEndPoints, form: Form, pathValue: PathValue?, pathQuery: String?, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        configure(method: method, endpoint: endpoint, form: form, pathValue: pathValue, pathQuery: pathQuery ?? "", handler: handler)
    }
    
    func connect<R>(method: Methods, endpoint: IEndPoints, pathValue: PathValue?, pathQuery: String?, handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
        configure(method: method, endpoint: endpoint, pathValue: pathValue, pathQuery: pathQuery ?? "", handler: handler)
    }
    
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}




fileprivate extension Remote {
    func configure<R>(method: Methods, endpoint: IEndPoints, body: Body? = nil, form: Form? = nil, pathValue: PathValue? = nil, pathQuery: String = "", handler: @escaping ((RemoteResult<R, String>) -> Void)) where R : Decodable {
       
        let url = compute(endpoint.getUrlfullPath(), pathValue: pathValue)
        let fullURL = url + pathQuery
        
        
        guard let url = URL.init(string: fullURL) else {
            assertionFailure("unable to convert url String to URL type")
            return
        }
        
        
        
        var request = URLRequest(url: url)
        setHeaders(&request, endpoint: endpoint)
        
        if let value = form {
            let boundary : String = "Boundary-\(NSUUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.httpBody = value.data(boundary) as Data
    
        } else {
            request.httpBody = body
        }
        
        
        self.session.dataTask(with: request, completionHandler: {(data, response, error) in
            
            DispatchQueue.main.async {
                
                print(String.init(data: data ?? Data() , encoding: .utf8)!)
                
                if let decoded : R = data?.decode(R.self) {
                    handler(RemoteResult.success(payload: decoded))
                } else {
                    handler(RemoteResult.failure(error: Errors.internalParsedDataError.rawValue))
                }
            }
            
        }).resume()
        
    }
}


fileprivate extension Remote {
    
    func compute(_ url: String, pathValue: PathValue?) -> String {
        guard let path_value = pathValue  else { return url }
        
        func reduce(result: String, path: (key: String, value: Any) ) -> String {
            let value = result.replacingOccurrences(of: path.key, with: "\(path.value)")
            return value
        }
        return  path_value.reduce(url, reduce)
    }
    
    func setHeaders(_ request: inout URLRequest, endpoint: IEndPoints) {
        if endpoint.getEnvUrl() == .finn_hub{
            
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
    }
}
