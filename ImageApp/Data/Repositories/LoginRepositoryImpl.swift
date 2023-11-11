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
        let _ = KeyChainHelper.delete(service: "userName")
        return KeyChainHelper.delete(service: "access_token")
    }
    
    func logIn(withAccount account: Account) -> Bool {
        guard let accessToken = account.access_token.data(using: .utf8) else {
            return false
        }
        guard let userName = account.userName.data(using: .utf8) else {
            return false
        }
        let accessTokenSaved = KeyChainHelper.save(data: accessToken, service: "access_token")
        let userNameSaved = KeyChainHelper.save(data: userName, service: "userName")
        return accessTokenSaved && userNameSaved
    }
}
