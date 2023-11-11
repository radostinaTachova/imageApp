//
//  ImageViewModel.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 3/11/23.
//

import Foundation
import Combine


class ImageViewModel: ObservableObject {
    
    private var repository: ImageRepository
        
    @Published var images: [ImageUIItem] = []
    
    @Published var error: CustomError? = nil
    
    var cancellableSet = Set<AnyCancellable>()
    
    init(_ imageRepository: ImageRepository) {
        self.repository = imageRepository
    }
        
    func updateImages() {
        let _ = repository.getImages()
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished: break
                case .failure(let error): 
                    self.error = error
                }
                
            }, receiveValue: { [unowned self] images in
                self.images = images
            })
            .store(in: &cancellableSet)
    }
    
    func uploadImage(base64: String) {
        let _ = repository.uploadImage(base64: base64)
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.error = error
                }
            }, receiveValue: { [unowned self] upladedImage in
                self.images.append(upladedImage)
            })
            .store(in: &cancellableSet)
    }
    
    func deleteImage(_ image: ImageUIItem) {
        guard let deleteHash = image.deleteHash else {
            self.error = CustomError.generalError(errorMessage: "No se puede borrar la imagen, falta el deletehash")
            return
        }
        let _ = repository.deleteImage(withHash: deleteHash)
            .sink(receiveCompletion: { [unowned self] completion in
                switch completion {
                case .finished: break
                case .failure(let error):
                    self.error = error
                }
            }, receiveValue: { [unowned self] result in
                if result {
                    self.images.removeAll(where: { $0.id == image.id})
                }
            })
            .store(in: &cancellableSet)
    }
    
}
