//
//  CheckFavoriteTourismPlaceUseCase.swift
//  Detail
//
//  Created by Rijal Muhyidin on 29/11/25.
//

import Core
import Combine

public protocol CheckFavoriteTourismPlaceUseCase {
    func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, Error>
}

public class CheckFavoriteTourismPlaceInteractor: CheckFavoriteTourismPlaceUseCase {
    
    private let detailRepository: DetailRepositoryProtocol
    
    public init(detailRepository: DetailRepositoryProtocol) {
        self.detailRepository = detailRepository
    }
    
    public func isFavoriteTourismPlace(id: Int) -> AnyPublisher<Bool, any Error> {
        return self.detailRepository.isFavoriteTourismPlace(id: id)
    }
}

