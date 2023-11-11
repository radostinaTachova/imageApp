//
//  ImageViewModel.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import Foundation
import Combine


class ImageViewModel: ObservableObject {
    
    private var respository: ImageRepository
        
    @Published var images: [ImageUIItem] = []
    
    var cancellableSet = Set<AnyCancellable>()
    
    init(_ imageRepository: ImageRepository) {
        self.respository = imageRepository
    }
    
    
    //MARK: - Images
    
    func getImages() {
        let _ = respository.getImages()
            .sink(receiveCompletion: {
                print("RTC = received completion \($0)")
            }, receiveValue: { [unowned self] images in
                self.images = images
            })
            .store(in: &cancellableSet)
    }
    
    func uploadImage(base64: String) {
        let _ = respository.uploadImage(base64: base64)
            .sink(receiveCompletion: {
                print("RTC = uploadImage received completion \($0)")
            }, receiveValue: { [unowned self] upladedImage in
                print("RTC = uploadImage = success ")
                self.images.append(upladedImage)
            })
            .store(in: &cancellableSet)
    }
    
}
