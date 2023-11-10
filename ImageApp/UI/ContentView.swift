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

    //TODO: temporal
    @State private var image = UIImage()
    @State private var showSheet = false
    @State private var source: SourceType = .opencamera
    
    var body: some View {
        VStack {
            getLoginOrGallery
            Spacer()
        }.onAppear {
            if loginViewModel.isLoggedIn {
                viewModel.getImages()
            }
        }
        .pickerSheet(isPresented: $showSheet, source: source, image: self.$image)
        .onChange(of: image, perform: { value in
            if let imageBase64 = value.base64 {
                viewModel.uploadImage(base64: imageBase64)
            }
        })
    }
    
    var buttonsPrueba: some View {
        HStack {
            if #available(iOS 16, *) {
                ImageLibraryPickeriOS16(image: self.$image)
            } else {
                Button("Importar Imagen") {
                    print("RTC = iOS, importar")
                    self.source = SourceType.photolibrary
                    showSheet = true
                }
            }
            Spacer()
            Button(action: {
                print("RTC = iOS, camera")
                self.source = SourceType.opencamera
                showSheet = true
            }, label: {
                Text("Camera")
            })
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
                buttonsPrueba
            }
        }
    }
}



#Preview {
    ContentView(viewModel: ImageViewModel(ImgurRepository()), loginViewModel: LoginViewModel(LoginRepositoryImpl()))
}
