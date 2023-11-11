//
//  LoginViewModel.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 8/11/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private var loginRepository: LoginRepository

    @Published var isLoggedIn: Bool = false
    
    @Published var error: CustomError? = nil
    
    init(_ loginRepository: LoginRepository) {
        self.loginRepository = loginRepository
        checkLogin()
    }
    
        
    private func checkLogin()  {
        isLoggedIn = loginRepository.isLoggedIn()
    }
    
    func saveAccount(_ urlString: String?) {
        guard let urlString else {
            isLoggedIn = false
            error = CustomError.login(errorMessage: "Error en el login")
            return
        }
        let account = urlString.getAccount()
        if let account {
            isLoggedIn = loginRepository.logIn(withAccount: account)
        }
    }
    
    func logOut() {
        isLoggedIn = !loginRepository.logOut()
    }
    
    
}
