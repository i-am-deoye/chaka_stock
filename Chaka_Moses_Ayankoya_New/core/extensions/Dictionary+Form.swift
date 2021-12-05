//  Chaka_Moses_Ayankoya_New
//
//  Created by Moses on 29/11/2021.
//

import UIKit


extension Dictionary {
    
    func data(_ boundary: String) -> Data {
        var body = Data()
        let parameters = self
        
        for (key, value) in parameters {
            print("The \(key) and \(value)")
            
            if value is UIImage, let image = value as? UIImage, let data = image.jpegData(compressionQuality: 0.3){
                
                let filename = "\(key).jpg"
                let mimetype = "image/jpg"
                
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.appendString("Content-Type: \(mimetype)\r\n\r\n")
                body.append(data)
                body.appendString("\r\n")
            }
            
            
            if(value is String || value is NSString ){
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
                print("The value of string is s\(key) \(value)")

            } else if (value is Bool){
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendBool(value as? Bool ?? false)
                body.appendString("\r\n")
            } else if (value is Int || value is NSInteger ){
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendInt(value as? Int ?? 0)
                body.appendString("\r\n")
            } else if (value is [String] || value is [NSString]){
                for string in value as! [String]{
                    body.appendString("--\(boundary)\r\n")
                    body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                    body.appendString("\(string)\r\n")
                }
            }
       }
        
        body.appendString("--\(boundary)--\r\n")
        return body
    }
}
