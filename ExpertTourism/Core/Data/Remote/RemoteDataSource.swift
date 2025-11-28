//
//  RemoteDataSource.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import Combine
import Foundation
import Alamofire

protocol RemoteDataSourceProtocol: AnyObject {
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceResponse], Error>
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceResponse, Error>
}

class RemoteDataSource: RemoteDataSourceProtocol {
    
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceResponse], Error> {
        return Future<[TourismPlaceResponse], Error> { completion in
            if let url = URL(string: Endpoints.Gets.list.url) {
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
    
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceResponse, any Error> {
        return Future<TourismPlaceResponse, Error> { completion in
            if let url = URL(string: Endpoints.Gets.detail(id: id).url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailTourismPlaceResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            completion(.success(value.place))
                        case .failure(let error):
                            completion(.failure(error))
                        }
                    }
            }
        }.eraseToAnyPublisher()
    }
}

