//
//  GetTourismPlacesUseCase.swift
//  Home
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol GetTourismPlacesUseCase {
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
}

public class GetTourismPlacesInteractor: GetTourismPlacesUseCase {
    
    private let homeRepository: HomeRepositoryProtocol
    
    public init(homeRepository: HomeRepositoryProtocol) {
        self.homeRepository = homeRepository
    }

    public func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error> {
        return self.homeRepository.getTourismPlaces()
    }
}
