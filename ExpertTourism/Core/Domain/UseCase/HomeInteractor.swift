//
//  HomeInteractor.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 19/11/25.
//

import Combine

protocol HomeUseCase {
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error>
}

class HomeInteractor: HomeUseCase {
    
    private let tourismPlaceRepository: TourismPlaceRepositoryProtocol
    
    required init(tourismPlaceRepository: TourismPlaceRepositoryProtocol) {
        self.tourismPlaceRepository = tourismPlaceRepository
    }
    
    func getTourismPlaces() -> AnyPublisher<[TourismPlaceModel], Error> {
        return tourismPlaceRepository.getTourismPlaces()
    }
}
