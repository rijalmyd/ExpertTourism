//
//  HomeRemoteDataSource.swift
//  Home
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Alamofire
import Combine
import Core
import Foundation

public protocol HomeRemoteDataSourceProtocol: AnyObject {
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceResponse], Error>
}

public class HomeRemoteDataSource: HomeRemoteDataSourceProtocol {
    
    public init() {}
    
    public func getTourismPlaces() -> AnyPublisher<[TourismPlaceResponse], Error> {
        return Future<[TourismPlaceResponse], Error> { completion in
            if let url = URL(string: "https://tourism-api.dicoding.dev/list") {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: TourismPlacesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.places))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}
