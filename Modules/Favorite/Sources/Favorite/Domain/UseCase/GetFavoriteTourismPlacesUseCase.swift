//
//  GetFavoriteTourismPlacesUseCase.swift
//  Favorite
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol GetFavoriteTourismPlacesUseCase {
    func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
}

public class GetFavoriteTourismPlacesInteractor: GetFavoriteTourismPlacesUseCase {
    
    private let favoriteRepository: FavoriteRepositoryProtocol
    
    public init(favoriteRepository: FavoriteRepositoryProtocol) {
        self.favoriteRepository = favoriteRepository
    }
    
    public func getFavoriteTourismPlaces() -> AnyPublisher<[TourismPlaceModel], any Error> {
        return self.favoriteRepository.getFavoriteTourismPlaces()
    }
}
