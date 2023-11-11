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
    
    
    func getImages() -> AnyPublisher<[ImageUIItem], Error> {
        
        //TODO: maybe a auth class / api calls class / CredentialsManager (?¿)
        guard let userNameData = KeyChainHelper.retrieve(service: "userName") else {
            return AnyPublisher(Fail<[ImageUIItem], Error>(error: URLError(URLError.Code.unknown))) //TODO: handle the errors or change the flow
        }
        
        guard let userName = String(data: userNameData, encoding: .utf8) else {
            return AnyPublisher(Fail<[ImageUIItem], Error>(error: URLError(URLError.Code.unknown))) //TODO: handle the errors or change the flow
        }
        print("RTC = getImages with userName = \(userName)")
        
        let url = baseURL + "account/\(userName)/images"
        var request = RequestWrapper(url: url, withAccessToken: true)

        return session.dataTaskPublisher(for: request.get())
            .tryMap { data, response in
                //TODO: handle the errors
                let images = try? JSONDecoder().decode(Result<[ImageItem]>.self, from: data)
                return images?.data.map({ $0.toUIModel() }) ?? []
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func uploadImage(base64: String) -> AnyPublisher<ImageUIItem, Error>  {
        let url = baseURL + "image"
        var request = RequestWrapper(url: url, withAccessToken: true)
        request.addBodyForm(with: "image", value: base64)
  
        return session.dataTaskPublisher(for: request.get())
            .tryMap { data, response in
                //TODO: handle errors
                let result = try? JSONDecoder().decode(Result<ImageItem>.self, from: data)
               
                return (result?.data.toUIModel())! //TODO: REMOOOOVE !
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
 
}
