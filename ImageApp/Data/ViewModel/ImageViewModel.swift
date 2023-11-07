//
//  ImageViewModel.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import Foundation


class ImageViewModel: ObservableObject {
    
    private var respository: ImageRepository
    
    private var loginRepository: LoginRepository
    
    @Published var account: Account? = nil
    
    @Published var showLoginView: Bool = true
    
    init(_ imageRepository: ImageRepository, _ loginRepository: LoginRepository) {
        self.respository = imageRepository
        self.loginRepository = loginRepository
    }
    
    //MARK: login 
    func saveAccount(_ urlString: String) {
        account = urlString.getAccount()
        showLoginView = false
        if let data = account?.access_token.data(using: .utf8) {
            print("RTC = keychain.save access_token")
            let success = KeyChainHelper.save(data: data, service: "access_token")
            print("RTC = keychain.save access_token = \(success)")

        }
    }
    
    func checkLogin()  {
        showLoginView = !loginRepository.isLoggedIn()
    }
    
    func logOut() {
        showLoginView = loginRepository.logOut()
    }
    
    
    
    
}
