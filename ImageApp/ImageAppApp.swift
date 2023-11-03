//
//  ImageAppApp.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import SwiftUI

@main
struct ImageAppApp: App {
    var body: some Scene {
        @StateObject var viewModel = ImageViewModel()
        WindowGroup {
            ContentView(viewModel: viewModel)
        }
    }
}
