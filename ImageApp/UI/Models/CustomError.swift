//
//  CustomError.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 11/11/23.
//

import Foundation

enum CustomError: LocalizedError {
    case generalError(errorMessage: String)
    case login(errorMessage: String)
     
    var errorDescription: String? {
        switch self {
        case let .generalError(errorMessage: stringError): return stringError
        case let .login(errorMessage: stringError): return stringError
        }
    }
    
    
   
}

