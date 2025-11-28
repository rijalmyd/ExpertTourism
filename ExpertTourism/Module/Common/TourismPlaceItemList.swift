//
//  TourismPlaceItemList.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import SwiftUI

struct TourismPlaceItemList: View {
    
    var places = [TourismPlaceModel]()
    
    var body: some View {
        List(self.places, id: \.id) { place in
            NavigationLink(
                destination: PlaceDetailView(id: place.id)
                    .toolbar(.hidden, for: .tabBar)
            ) {
                TourismPlaceItemRow(place: place)
            }
        }
    }
}

#Preview {
    TourismPlaceItemList()
}
