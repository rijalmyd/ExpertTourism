//
//  TourismPlaceModel.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

struct TourismPlaceModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let image: String?
    let address: String?
    let latitude: Double?
    let longitude: Double?
    let like: Int
}
