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

    //TODO: temporal, make a imagepicker wrapper view
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var source: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        //TODO: nevigation
        VStack {
            getLoginOrGallery
        }.onAppear {
            if loginViewModel.isLoggedIn {
                viewModel.getImages()
            }
        }.sheet(isPresented: $showSheet, content: {
            ImagePicker(sourceType: $source, selectedImage: self.$image)
        })
    }
    
    var buttons: some View {
        HStack {
            Button("Importar Imagen") {
                print("RTC = importar imagen")
                source = .photoLibrary
                showSheet = true
            }
            Spacer()
            Button("Cámara") {
                print("RTC = camera")
                source = .camera
                showSheet = true
                
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
            VStack {
                GalleryView(images: viewModel.images)
                Button("Log out", action: {
                    loginViewModel.logOut()
                })
                buttons.padding()
            }
        }
    }
}



#Preview {
    ContentView(viewModel: ImageViewModel(ImgurRepository()), loginViewModel: LoginViewModel(LoginRepositoryImpl()))
}
