//
//  FavoriteRepository.swift
//  Favorite
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Combine
import Core

public protocol FavoriteRepositoryProtocol {
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
}

public class FavoriteRepository: FavoriteRepositoryProtocol {
    
    private let localDataSource: FavoriteLocalDataSourceProtocol
    
    public init(localDataSource: FavoriteLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }
    
    public func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error> {
        return self.localDataSource.getFavoriteTourismPlaces()
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
