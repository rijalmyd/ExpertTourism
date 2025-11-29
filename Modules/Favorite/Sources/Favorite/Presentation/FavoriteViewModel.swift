//
//  FavoriteViewModel.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Foundation
import SwiftUI
import Combine
import Core

public class FavoriteViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let getFavoriteTourismPlacesUseCase: GetFavoriteTourismPlacesUseCase
    
    @Published var tourismPlaces = [TourismPlaceModel]()
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    
    public init(
        getFavoriteTourismPlacesUseCase: GetFavoriteTourismPlacesUseCase
    ) {
        self.getFavoriteTourismPlacesUseCase = getFavoriteTourismPlacesUseCase
    }
    
    func getFavoriteTourismPlaces() {
        isLoading = true
        getFavoriteTourismPlacesUseCase.getFavoriteTourismPlaces()
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

