//
//  FavoriteViewModel.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Foundation
import SwiftUI
import Combine

class FavoriteViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var tourismPlaces = [TourismPlaceModel]()
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getFavoriteTourismPlaces() {
        isLoading = true
        favoriteUseCase.getFavoriteTourismPlaces()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] tourismPlaces in
                self?.tourismPlaces = tourismPlaces
            })
            .store(in: &cancellables)
    }
}

