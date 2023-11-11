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
    
    
    //MARK: - login
    
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
        //TODO: think about create a CredentialsManager
        if let data = account?.access_token.data(using: .utf8) {
            print("RTC = keychain.save access_token")
            let success = KeyChainHelper.save(data: data, service: "access_token")
            print("RTC = keychain.save access_token = \(success)")
        }
        if let userName = account?.userName.data(using: .utf8) {
            let success = KeyChainHelper.save(data: userName, service: "userName")
            print("RTC = keychain.save userName = \(success)") //TODO: check success=false but is working
        }
        isLoggedIn = true
    }
    
    func logOut() {
        isLoggedIn = !loginRepository.logOut()
    }
    
    
}
