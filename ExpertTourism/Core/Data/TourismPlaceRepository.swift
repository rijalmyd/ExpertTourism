//
//  TourismPlaceRepository.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import Foundation
import Combine

protocol TourismPlaceRepositoryProtocol {
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error>
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error>
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

class TourismPlaceRepository: TourismPlaceRepositoryProtocol {
    
    private let remoteDataSource: RemoteDataSourceProtocol
    private let localDataSource: LocalDataSourceProtocol
    
    init(remoteDataSource: RemoteDataSourceProtocol, localDataSource: LocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error> {
        return localDataSource.getFavoriteTourismPlaces()
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error> {
        return localDataSource.addFavoriteTourismPlace(from: tourismPlace.toEntity())
            .eraseToAnyPublisher()
    }
    
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error> {
        return localDataSource.isFavoriteTourismPlace(id: id)
            .eraseToAnyPublisher()
    }
    
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error> {
        return localDataSource.removeFavoriteTourismPlace(id: id)
            .eraseToAnyPublisher()
    }
    
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error> {
        return self.remoteDataSource.getTourismPlaces()
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
    
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error> {
        return self.remoteDataSource.getTourismPlace(id: id)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}


