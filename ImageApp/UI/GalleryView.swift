//
//  GalleryView.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import SwiftUI

struct GalleryView: View {
    
    var images: [ImageUIItem]
    
    var body: some View {
        
        ScrollView {
            Text("Galería")
            //TODO: check values and move them to constats
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150, maximum: 180))], content: {
                ForEach(images) { image in
                    getImageView(withUrl: image.url)
                }
            })
        }
    }
    
    func getImageView(withUrl url: String) -> some View {
        AsyncImage(url: URL(string: url)) { imagen in
            imagen.resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 15)
            
        } placeholder: {
            ProgressView()
        }
    }
    
}

#Preview {
    let images = [ImageUIItem(id: "1", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", tittle: "Imagen 1"),
        ImageUIItem(id: "2", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", tittle: "Imagen 1"),
        ImageUIItem(id: "3", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", tittle: "Imagen 1"),
        ImageUIItem(id: "4", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", tittle: "Imagen 1")]
    
    return GalleryView(images: images)
}
