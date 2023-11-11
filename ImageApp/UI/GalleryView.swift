//
//  GalleryView.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import SwiftUI

struct GalleryView: View {
    
    var images: [ImageUIItem]
    
    var onDeleteClick: (ImageUIItem) -> ()
    
    var body: some View {
        
        ScrollView {
            //TODO: check values and move them to constats
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 120))], spacing: 0, content: {
                ForEach(images) { image in
                    VStack {
                        deleteButton(withImage: image)
                        getImageView(withUrl: image.url)
                    }
                    .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 20))
                    .padding([.bottom], 10)
                }
            })
        }
    }
    
    func getImageView(withUrl url: String) -> some View {
        AsyncImage(url: URL(string: url)) { imagen in
            
            imagen.resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(5)
                .frame(height: 150)
            
        } placeholder: {
            ProgressView()
        }
    }
    
    func deleteButton(withImage image: ImageUIItem) -> some View {
        HStack {
            Spacer()
            Button(action: {
                onDeleteClick(image)
            }, label: {
                Image(systemName: "trash")
                    .foregroundStyle(Color("mainColor", bundle: nil))
            })
        }.padding([.top, .trailing])
    }
}

#Preview {
    let images = [ImageUIItem(id: "1", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs"),
        ImageUIItem(id: "2", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs"),
        ImageUIItem(id: "3", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs"),
        ImageUIItem(id: "4", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs")]
    
    return GalleryView(images: images) {_ in 
        print("On delete")
    }
}
