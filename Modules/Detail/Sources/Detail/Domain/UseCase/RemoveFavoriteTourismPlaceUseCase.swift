//
//  RemoveFavoriteTourismPlaceUseCase.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol RemoveFavoriteTourismPlaceUseCase {
    func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

public class RemoveFavoriteTourismPlaceInteractor: RemoveFavoriteTourismPlaceUseCase {
    
    private let detailRepository: DetailRepositoryProtocol
    
    public init(detailRepository: DetailRepositoryProtocol) {
        self.detailRepository = detailRepository
    }
    
    public func removeFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error> {
        return self.detailRepository.removeFavoriteTourismPlace(id: id)
    }
}
