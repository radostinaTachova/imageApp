//
//  ImgurRepository.swift
//  ImageApp
//
//  Created by Radostina Tachova Chergarska on 2/11/23.
//

import Foundation
import Combine

struct ImgurRepository: ImageRepository {
    
    private var session = URLSession.shared
    private let baseURL = "https://api.imgur.com/3/"
    
    
    func getImages() -> AnyPublisher<[ImageUIItem], CustomError> {
        
        //TODO: maybe a auth class / api calls class / CredentialsManager (?¿)
        guard let userNameData = KeyChainHelper.retrieve(service: "userName") else {
            return AnyPublisher(Fail<[ImageUIItem], CustomError>(error: CustomError.generalError(errorMessage: "df"))) //TODO: handle the errors or change the flow
        }
        
        guard let userName = String(data: userNameData, encoding: .utf8) else {
            return AnyPublisher(Fail<[ImageUIItem], CustomError>(error: CustomError.generalError(errorMessage: "df"))) //TODO: handle the errors or change the flow
        }
        
        let url = baseURL + "account/\(userName)/images"
        let request = RequestWrapper(url: url, withAccessToken: true)

        return session.dataTaskPublisher(for: request.get())
            .tryMap { data, response in
                if let httpResoonse = response as? HTTPURLResponse {
                    if httpResoonse.statusCode != 200 {
                        throw CustomError.generalError(errorMessage: httpResoonse.description)
                    }
                }
                
                let images = try? JSONDecoder().decode(Result<[ImageItem]>.self, from: data)
                return images?.data.map({ $0.toUIModel() }) ?? []
            }
            .mapError { error -> CustomError in CustomError.generalError(errorMessage: error.localizedDescription) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func uploadImage(base64: String) -> AnyPublisher<ImageUIItem, CustomError>  {
        let url = baseURL + "image"
        var request = RequestWrapper(url: url, withAccessToken: true)
        request.addBodyForm(with: "image", value: base64)
  
        return session.dataTaskPublisher(for: request.get())
            .tryMap { data, response in
                if let httpResoonse = response as? HTTPURLResponse {
                    if httpResoonse.statusCode != 200 {
                        throw CustomError.generalError(errorMessage: httpResoonse.description)
                    }
                }
                let result = try? JSONDecoder().decode(Result<ImageItem>.self, from: data)
                guard let uimodel = result?.data.toUIModel() else {
                    throw CustomError.generalError(errorMessage: "Unknown error")
                }
                return uimodel
            }
            .mapError { error -> CustomError in CustomError.generalError(errorMessage: error.localizedDescription) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func deleteImage(withHash hash: String) -> AnyPublisher<Bool, CustomError> {
        let url = baseURL + "image/\(hash)"
        var request = RequestWrapper(url: url, withAccessToken: true)
        request.setDeleteRequest()
        
        return session.dataTaskPublisher(for: request.get())
            .tryMap { data, response in
                if let httpResoonse = response as? HTTPURLResponse {
                    if httpResoonse.statusCode != 200 {
                        throw CustomError.generalError(errorMessage: httpResoonse.description)
                    }
                }
                let result = try? JSONDecoder().decode(Result<Bool>.self, from: data)
                guard let success = result?.success else {
                    throw CustomError.generalError(errorMessage: "No se ha podido eliminar")
                }
                return success
            }
            .mapError { error -> CustomError in CustomError.generalError(errorMessage: error.localizedDescription) }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
 
}

