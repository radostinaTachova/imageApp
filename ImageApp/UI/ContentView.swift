//
//  ContentView.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ImageViewModel
    
    //MARK: temporal
    @State private var isPresentWebView = true
    
    //MARK: temporal
    let url = "https://api.imgur.com/oauth2/authorize?client_id=3a6a531dc50e73b&response_type=token&state=APPLICATION_STATE"

    
    var body: some View {
        //TODO: nevigation
        VStack {
            Text("ContentView")
            Text("Hola \(viewModel.account?.userName ?? "sin user")")
            
            Spacer()
            
            Button("Log out", action: {
                viewModel.logOut()
            })
            
        }.sheet(isPresented: $viewModel.showLoginView) {
            //Login
            WebView(url: URL(string:url)!) { loginURL in
                print("RTC = isLoggin \(loginURL)")
                
                viewModel.saveAccount(loginURL)
                
            }
                    .ignoresSafeArea()
                    .navigationTitle("Login")
                    .navigationBarTitleDisplayMode(.inline)
        }.onAppear {
            viewModel.checkLogin()
        }
    }
}

#Preview {
    ContentView(viewModel: ImageViewModel(ImgurRepository(), LoginRepositoryImpl()))
}
