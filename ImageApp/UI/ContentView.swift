//
//  ContentView.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ImageViewModel
    
    @ObservedObject var loginViewModel: LoginViewModel
    
    //MARK: temporal
    let url = "https://api.imgur.com/oauth2/authorize?client_id=3a6a531dc50e73b&response_type=token&state=APPLICATION_STATE"

    
    var body: some View {
        //TODO: nevigation
        VStack {
            getLoginOrGallery
            Spacer()
            
            Button("Log out", action: {
                loginViewModel.logOut()
            })
            
        }.onAppear {
            if loginViewModel.isLoggedIn {
                viewModel.getImages()
            }
        }
    }
    
    
    @ViewBuilder
    var getLoginOrGallery: some View  {
        switch loginViewModel.isLoggedIn {
        case false:
            WebView(url: URL(string:url)!) { loginURL in
                print("RTC = isLoggin \(loginURL)")
                loginViewModel.saveAccount(loginURL)
            }.ignoresSafeArea()
        default:
            GalleryView(images: viewModel.images)
        }
    }
    
    
    
}

#Preview {
    ContentView(viewModel: ImageViewModel(ImgurRepository()), loginViewModel: LoginViewModel(LoginRepositoryImpl()))
}
