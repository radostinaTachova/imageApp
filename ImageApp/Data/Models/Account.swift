//
//  User.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation

struct Account: CustomDebugStringConvertible {
   
    
    var userName: String
    var account_id: String
    var access_token: String
    var expires_in: String
    var refresh_token: String
    
    
    var debugDescription: String {
        "username = \(userName)"
    }
    
}
