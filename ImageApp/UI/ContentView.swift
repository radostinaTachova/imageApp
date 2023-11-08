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
    @State private var isPresentWebView = true
    
    //MARK: temporal
    let url = "https://api.imgur.com/oauth2/authorize?client_id=3a6a531dc50e73b&response_type=token&state=APPLICATION_STATE"

    
    var body: some View {
        //TODO: nevigation
        VStack {
            Text("ContentView")
            Text("Hola \(loginViewModel.account?.userName ?? "sin user")")
            
            Spacer()
            
            Button("Log out", action: {
                loginViewModel.logOut()
            })
            
            Button("GET IMAGES: TEST") {
                viewModel.getImages()
            }
            
        }.sheet(isPresented: $loginViewModel.showLoginView) {
            //Login
            WebView(url: URL(string:url)!) { loginURL in
                print("RTC = isLoggin \(loginURL)")
                
                loginViewModel.saveAccount(loginURL)
                
            }
                    .ignoresSafeArea()
                    .navigationTitle("Login")
                    .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            loginViewModel.checkLogin()
        }
    }
}

#Preview {
    ContentView(viewModel: ImageViewModel(ImgurRepository()), loginViewModel: LoginViewModel(LoginRepositoryImpl()))
}
