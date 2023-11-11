//
//  ImagePickerView.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 9/11/23.
//

import SwiftUI
import PhotosUI

struct PickerSheet: ViewModifier {
    @Binding var isPresented: Bool
    var source: SourceType
    @Binding var image: UIImage
    

    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, content: {
                ImagePicker(sourceType: source.value, selectedImage: self.$image)
            })
    }
}

extension View {
    func pickerSheet(isPresented: Binding<Bool>, source: SourceType, image: Binding<UIImage>) -> some View {
        modifier(PickerSheet(isPresented: isPresented, source: source, image: image))
    }
}


enum SourceType {
    case photolibrary
    case opencamera
    
    var value: UIImagePickerController.SourceType {
        switch self {
        case .opencamera: return UIImagePickerController.SourceType.camera
        case .photolibrary: return UIImagePickerController.SourceType.photoLibrary
        }
    }
}
