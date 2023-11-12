//
//  FakeImageRepository.swift
//  ImageAppTests
//
//  Created by Radostina Tachova Chergarska on 12/11/23.
//

import Foundation
import Combine

@testable import ImageApp

struct FakeImageRepository: ImageRepository {
    
    var images: [ImageUIItem]
    
    init(images: [ImageUIItem]) {
        self.images = images
    }
    
    func getImages() -> AnyPublisher<[ImageApp.ImageUIItem], ImageApp.CustomError> {
        return Just(images)
            .setFailureType(to: ImageApp.CustomError.self)
            .eraseToAnyPublisher()
    }
    
    func uploadImage(base64: String) -> AnyPublisher<ImageApp.ImageUIItem, ImageApp.CustomError> {
        //
        let imageToUpload = ImageUIItem(id: "4", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs4")
        return Just(imageToUpload)
            .setFailureType(to: CustomError.self)
            .eraseToAnyPublisher()
        
    }
    
    func deleteImage(withHash hash: String) -> AnyPublisher<Bool, ImageApp.CustomError> {
        return Just(true)
            .setFailureType(to: CustomError.self)
            .eraseToAnyPublisher()
    }
}

struct TestsData {
    static var images = [ImageUIItem(id: "1", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs1"),
                          ImageUIItem(id: "2", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs2"),
                          ImageUIItem(id: "3", url: "https://landonhotel.com/images/hotel/dining_lattes.jpg", title: "Imagen 1", deleteHash: "dfs3")]
    
}
