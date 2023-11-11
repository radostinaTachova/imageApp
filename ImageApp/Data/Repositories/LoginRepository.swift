//
//  LoginRepository.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 7/11/23.
//

import Foundation

protocol LoginRepository {
    func isLoggedIn() -> Bool
    func logOut() -> Bool
    func logIn(withAccount account: Account) -> Bool
}
