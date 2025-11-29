//
//  AddFavoriteTourismPlaceUseCase.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol AddFavoriteTourismPlaceUseCase {
    func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error>
}

public class AddFavoriteTourismPlaceInteractor: AddFavoriteTourismPlaceUseCase {
    
    private let detailRepository: DetailRepositoryProtocol
    
    public init(detailRepository: DetailRepositoryProtocol) {
        self.detailRepository = detailRepository
    }
    
    public func addFavoriteTourismPlace(from tourismPlace: TourismPlaceModel) -> AnyPublisher<Bool, Error> {
        return self.detailRepository.addFavoriteTourismPlace(from: tourismPlace)
    }
}
