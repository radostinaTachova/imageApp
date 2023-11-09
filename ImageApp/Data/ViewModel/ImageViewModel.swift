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
    
    
}
