//
//  LoginRepositoryImpl.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 7/11/23.
//

import Foundation

struct LoginRepositoryImpl: LoginRepository {
    
    //TODO: add refresh token to login flow
    func isLoggedIn() -> Bool {
        return (KeyChainHelper.retrieve(service: "access_token") != nil)
    }
    
    func logOut() -> Bool {
        return KeyChainHelper.delete(service: "access_token")
    }
}
