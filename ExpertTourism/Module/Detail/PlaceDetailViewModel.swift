//
//  PlaceDetailViewModel.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Foundation
import SwiftUI
import Combine

class PlaceDetailViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let detailUseCase: DetailUseCase
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var tourismPlace: TourismPlaceModel?
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    @Published var isFavorite = false
    @Published var alertMessage: String = ""
    @Published var showAlert: Bool = false

    init(detailUseCase: DetailUseCase, favoriteUseCase: FavoriteUseCase) {
        self.detailUseCase = detailUseCase
        self.favoriteUseCase = favoriteUseCase
    }
    
    func getTourismPlace(id: Int) {
        isLoading = true
        detailUseCase.getTourismPlace(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: { [weak self] place in
                self?.tourismPlace = place
                self?.checkFavoriteStatus(for: place.id)
            })
            .store(in: &cancellables)
    }
    
    private func checkFavoriteStatus(for id: Int) {
        favoriteUseCase.isFavoriteTourismPlace(id: id)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    self.errorMessage = String(describing: completion)
                case .finished:
                    self.isLoading = false
                }
            }, receiveValue: {  [weak self] status in
                self?.isFavorite = status
            })
            .store(in: &cancellables)
    }
    
    func toggleFavorite() {
        guard let place = tourismPlace else { return }
        
        let publisher = isFavorite
            ? favoriteUseCase.removeFavoriteTourismPlace(id: place.id)
            : favoriteUseCase.addFavoriteTourismPlace(from: place)
        
        publisher
            .receive(on: RunLoop.main)
            .sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure:
                        self.errorMessage = String(describing: completion)
                        self.showAlert = true
                    case .finished:
                        break
                    }
                },
                receiveValue: { [weak self] _ in
                    guard let self = self else { return }
                    self.isFavorite.toggle()

                    self.alertMessage = self.isFavorite
                        ? "Successfully added to favorite"
                        : "Removed from favorite"

                    self.showAlert = true
                }
            )
            .store(in: &cancellables)
    }
}
