//
//  HomeViewModel.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import Foundation
import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    private var cancellables: Set<AnyCancellable> = []
    private let homeUseCase: HomeUseCase
    
    @Published var tourismPlaces = [TourismPlaceModel]()
    @Published var isLoading = false
    @Published var errorMessage: String = ""
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
    }
    
    func getTourismPlaces() {
        isLoading = true
        homeUseCase.getTourismPlaces()
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
