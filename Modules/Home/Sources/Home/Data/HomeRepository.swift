//
//  HomeRepository.swift
//  Home
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol HomeRepositoryProtocol {
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
}

public class HomeRepository: HomeRepositoryProtocol {
    
    private let remoteDataSource: HomeRemoteDataSourceProtocol
    
    public init(remoteDataSource: HomeRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error> {
        return self.remoteDataSource.getTourismPlaces()
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
