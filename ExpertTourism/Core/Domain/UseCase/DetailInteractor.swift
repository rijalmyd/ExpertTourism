//
//  DetailInteractor.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Combine

protocol DetailUseCase {
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error>
}

final class DetailInteractor: DetailUseCase {

    private let tourismPlaceRepository: TourismPlaceRepositoryProtocol
    
    init(tourismPlaceRepository: TourismPlaceRepositoryProtocol) {
        self.tourismPlaceRepository = tourismPlaceRepository
    }
    
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error> {
        return tourismPlaceRepository.getTourismPlace(id: id)
    }
}
