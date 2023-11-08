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
        let url = baseURL + "account/radostTest/images" //TODO: remove user
        var request = URLRequest(url: URL(string: url)!)
        
        //TODO: maybe a auth class / api calls class
        guard let accessTokenData = KeyChainHelper.retrieve(service: "access_token") else {
            return AnyPublisher(Fail<[ImageUIItem], Error>(error: URLError(URLError.Code.unknown))) //TODO: handle the errors or change the flow
        }
        guard let accessToken = String(data: accessTokenData, encoding: .utf8) else {
            return AnyPublisher(Fail<[ImageUIItem], Error>(error: URLError(URLError.Code.unknown))) //TODO: handle the errors or change the flow
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        //
       
        return session.dataTaskPublisher(for: request)
            .tryMap { data, response in
                //TODO: handle the errors
                
                let images = try? JSONDecoder().decode(Result<ImageItem>.self, from: data)
                return images?.data.map({ $0.toUIModel() }) ?? []
                
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
 
    
}
