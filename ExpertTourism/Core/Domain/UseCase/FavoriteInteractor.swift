//
//  FavoriteInteractor.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Combine

protocol FavoriteUseCase {
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error>
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

final class FavoriteInteractor: FavoriteUseCase {
    
    private let tourismPlaceRepository: TourismPlaceRepositoryProtocol
    
    init(tourismPlaceRepository: TourismPlaceRepositoryProtocol) {
        self.tourismPlaceRepository = tourismPlaceRepository
    }
    
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], any Error> {
        return tourismPlaceRepository.getFavoriteTourismPlaces()
    }
    
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, any Error> {
        return tourismPlaceRepository.addFavoriteTourismPlace(from: tourismPlace)
    }
    
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
        return tourismPlaceRepository.isFavoriteTourismPlace(id: id)
    }
    
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
        return tourismPlaceRepository.removeFavoriteTourismPlace(id: id)
    }
}

