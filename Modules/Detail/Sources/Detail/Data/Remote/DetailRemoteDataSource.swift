//
//  DetailRemoteDataSource.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine
import Foundation
import Alamofire

public protocol DetailRemoteDataSourceProtocol: AnyObject {
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceResponse, Error>
}

public class DetailRemoteDataSource: DetailRemoteDataSourceProtocol {
    
    public init() {}
    
    public func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceResponse, Error> {
        return Future<TourismPlaceResponse, Error> { completion in
            if let url = URL(string: "https://tourism-api.dicoding.dev/detail/\(id)") {
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
