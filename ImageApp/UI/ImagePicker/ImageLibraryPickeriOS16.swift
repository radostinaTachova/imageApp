//
//  ImageLibraryPickeriOS16.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 10/11/23.
//

import SwiftUI
import PhotosUI

@available(iOS 16.0, *)
struct ImageLibraryPickeriOS16: View {    
    @State private var imageItem: PhotosPickerItem?
    @Binding var image: UIImage

    var body: some View {
        VStack {
            PhotosPicker("Importar imagen", selection: $imageItem, matching: .images)
            
        }.onChange(of: imageItem) { _ in
            Task {
                if let data = try? await imageItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        image = uiImage
                        return
                    }
                }
            }
        }
    }
}
