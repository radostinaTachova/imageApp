//
//  RequestWrapper.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 11/11/23.
//

import Foundation

struct RequestWrapper {
    private var request: URLRequest
    
    init(url: String, withAccessToken auth: Bool) {
        self.request = URLRequest(url: URL(string: url)!) //TODO: remove !
        
        if auth {
            guard let accessTokenData = KeyChainHelper.retrieve(service: "access_token") else {
                return
            }
            guard let accessToken = String(data: accessTokenData, encoding: .utf8) else {
                return
            }
            
            self.request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
    }
    
    func get() -> URLRequest {
        return request
    }
    
    mutating func setDeleteRequest() {
        request.httpMethod = "DELETE"
    }
    
    mutating func addBodyForm(with name: String, value: String) {
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        var body = ""
        body += "--\(boundary)\r\n"
        body += "Content-Disposition:form-data; name=\"\(name)\""
        body += "\r\n\r\n\(value)\r\n"
        body += "--\(boundary)--\r\n"
        let postData = body.data(using: .utf8)
        request.httpBody = postData
    }
    
}
