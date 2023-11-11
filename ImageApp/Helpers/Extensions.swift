//
//  Helpers.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation
import UIKit
import SwiftUI

extension String {
    
    func getAccount() -> Account? {
                
        
        //'split(separator:maxSplits:omittingEmptySubsequences:)' is only available in iOS 16.0 or newer
        
       
        
//        if #available(iOS 16.0, *) {
//            let splitAccessToken = self.split(separator: "access_token=").last
//            let accessToken = splitAccessToken?.split(separator: "&").first
//            
//            let splitExpiresIn = self.split(separator: "expires_in=").last
//            let expiresIn = splitExpiresIn?.split(separator: "&").first
//            
//            let splitrefresh = self.split(separator: "refresh_token=").last
//            let refresh = splitrefresh?.split(separator: "&").first
//            
//            let splitUsername = self.split(separator: "account_username=").last
//            let username = splitUsername?.split(separator: "&").first
//            
//            let splitAccountId = self.split(separator: "account_id=").last
//            let accountId = splitAccountId?.split(separator: "&").first
//            
//            guard let username, let accountId, let expiresIn, let accessToken, let refresh else {
//                return nil
//            }
//            
//            return Account(userName: String(username), account_id: String(accountId), access_token: String(accessToken), expires_in: String(expiresIn), refresh_token: String(refresh))
//        } else {
        // let urlString = "https://imageapp.com/?state=APPLICATION_STATE#access_token=39a7cd2b2db7b953e392d8a4ab47dd3c1e81d718&expires_in=315360000&token_type=bearer&refresh_token=57fbb54998c1c901d631bcf342d340893097eff1&account_username=radostTest&account_id=175735105"
        let params = self.split(whereSeparator: {$0 == "#"}).last
        let arrayParams = params?.split(whereSeparator: { $0 == "&"})
        
            //TODO: hacer mas general
            let accessToken = arrayParams?[0].split(whereSeparator: {$0 == "="}).last
            let expiresIn = arrayParams?[1].split(whereSeparator: {$0 == "="}).last
            let refresh = arrayParams?[3].split(whereSeparator: {$0 == "="}).last
            let username = arrayParams?[4].split(whereSeparator: {$0 == "="}).last
            let accountId = arrayParams?[5].split(whereSeparator: {$0 == "="}).last
        
            guard let username, let accountId, let expiresIn, let accessToken, let refresh else {
                return nil
            }
        
            return Account(userName: String(username), account_id: String(accountId), access_token: String(accessToken), expires_in: String(expiresIn), refresh_token: String(refresh))
        

            
//        }
    }
    
}

extension ImageItem {
    func toUIModel() -> ImageUIItem {
        return ImageUIItem(id: self.id, url: self.link, title: self.title ?? "Sin título", deleteHash: self.deletehash)
    }
}

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}

extension String {
    var isLogInUrl: Bool {
        let urlToMatch = "https://imageapp.com"
        return self.contains(urlToMatch)
    }
}

extension Bundle {
    static var loginUrl: String {
        let clientId = Bundle.main.object(forInfoDictionaryKey: "client_id")
        return "https://api.imgur.com/oauth2/authorize?client_id=\(clientId ?? "")&response_type=token&state=APPLICATION_STATE"
    }
}

extension View {
    func errorAlert(error: Binding<CustomError?>, buttonTitle: String = "OK") -> some View {
        return alert(isPresented: .constant(error.wrappedValue != nil), error: error.wrappedValue ) { _ in
                Button(buttonTitle) {
                    error.wrappedValue = nil
                }
            } message: { error in
                Text(error.errorDescription ?? "Unknown error")
            }
        }
}

