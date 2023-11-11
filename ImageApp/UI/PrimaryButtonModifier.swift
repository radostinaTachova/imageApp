//
//  PrimaryButtonModifier.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 11/11/23.
//

import Foundation
import SwiftUI

struct PrimaryButtonModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .foregroundColor(Color("textColor", bundle: nil))
            .frame(maxWidth: .infinity)
            .background(Color("mainColor", bundle: nil), in: RoundedRectangle(cornerRadius: 10))
            .padding([.leading, .trailing])
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
}

extension View {
    func primaryButton() -> some View {
        self.modifier(PrimaryButtonModifier())
    }
}
