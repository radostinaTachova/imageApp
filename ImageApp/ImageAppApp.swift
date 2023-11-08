//
//  ImageAppApp.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import SwiftUI

@main
struct ImageAppApp: App {
    @StateObject var viewModel = ImageViewModel(ImgurRepository())
    @StateObject var loginViewModel = LoginViewModel(LoginRepositoryImpl())

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel, loginViewModel: loginViewModel)
        }
    }
}
