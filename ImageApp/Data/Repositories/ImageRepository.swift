//
//  LoginRepository.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation
import Combine

protocol ImageRepository {
    func getImages() -> AnyPublisher<[ImageUIItem], CustomError>
    func uploadImage(base64: String) -> AnyPublisher<ImageUIItem, CustomError>
    func deleteImage(withHash hash: String) -> AnyPublisher<Bool, CustomError> 
}
