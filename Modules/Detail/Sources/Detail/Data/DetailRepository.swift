//
//  DetailRepository.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol DetailRepositoryProtocol {
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error>
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error>
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

public class DetailRepository: DetailRepositoryProtocol {

    private let remoteDataSource: DetailRemoteDataSourceProtocol
    private let localDataSource: DetailLocalDataSourceProtocol
    
    public init(remoteDataSource: DetailRemoteDataSourceProtocol, localDataSource: DetailLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    public func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error> {
        return self.localDataSource.addFavoriteTourismPlace(from: tourismPlace.toEntity())
            .eraseToAnyPublisher()
    }
    
    public func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error> {
        return self.localDataSource.isFavoriteTourismPlace(id: id)
            .eraseToAnyPublisher()
    }
    
    public func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error> {
        return self.localDataSource.removeFavoriteTourismPlace(id: id)
            .eraseToAnyPublisher()
    }
    
    public func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error> {
        return self.remoteDataSource.getTourismPlace(id: id)
            .map { $0.toDomain() }
            .eraseToAnyPublisher()
    }
}
