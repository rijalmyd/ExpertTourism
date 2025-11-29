//
//  GetTourismPlaceUseCase.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol GetTourismPlaceUseCase {
    func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error>
}

public class GetTourismPlaceInteractor: GetTourismPlaceUseCase {
    
    private let detailRepository: DetailRepositoryProtocol
    
    public init(detailRepository: DetailRepositoryProtocol) {
        self.detailRepository = detailRepository
    }
    
    public func getTourismPlace(id: Int) -> AnyPublisher<TourismPlaceModel, Error> {
        return self.detailRepository.getTourismPlace(id: id)
    }
}
