//
//  LoginRepository.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation
import Combine

protocol ImageRepository {
    
    func getImages() -> AnyPublisher<[ImageUIItem], Error>
  
    
}
