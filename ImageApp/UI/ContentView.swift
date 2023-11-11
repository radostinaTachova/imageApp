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
        }).errorAlert(error: $viewModel.error)
        .errorAlert(error: $loginViewModel.error)
                  
    }
    
    var buttons: some View {
        HStack {
            if #available(iOS 16, *) {
                ImageLibraryPickeriOS16(image: self.$image)
                    .primaryButton()

            } else {
                Button(action: {
                    self.source = SourceType.photolibrary
                    showSheet = true
                }, label: {
                    Label(
                        title: { Text("Galería") },
                        icon: { Image(systemName: "photo.on.rectangle.angled") }
                    )
                    .primaryButton()

                })
                
            }
            Button(action: {
                self.source = SourceType.opencamera
                showSheet = true
            }, label: {
                Label(
                    title: { Text("Cámara") },
                    icon: { Image(systemName: "camera") }
                )
                .primaryButton()

            })
        }
    }
    
    var logoutButton: some View {
        HStack {
            Spacer()
            Button(action: {
                loginViewModel.logOut()
            }, label: {
                Label(
                    title: { Text("Log out") },
                    icon: { Image(systemName: "rectangle.portrait.and.arrow.right") }
                )
                .padding()
                .foregroundColor(Color("mainColor", bundle: nil))
                .padding(.trailing)
            })
        }
    }
    
    @ViewBuilder
    var getLoginOrGallery: some View  {
        switch loginViewModel.isLoggedIn {
        case false:
            WebView(url: URL(string: Bundle.loginUrl)!) { loginURL in
                loginViewModel.saveAccount(loginURL)
            }.ignoresSafeArea()
        default:
            VStack {
                logoutButton
              
                GalleryView(images: viewModel.images) { image in
                    viewModel.deleteImage(image)
                }
               
                buttons
            }
        }
    }
}



#Preview {
    ContentView(viewModel: ImageViewModel(ImgurRepository()), loginViewModel: LoginViewModel(LoginRepositoryImpl()))
}


