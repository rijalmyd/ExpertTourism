//
//  TourismPlaceItemRow.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 18/11/25.
//

import SwiftUI
import SDWebImage
import SDWebImageSwiftUI

struct TourismPlaceItemRow: View {
    
    var place: TourismPlaceModel
    
    var body: some View {
        HStack(spacing: 16) {
            WebImage(url: URL(string: place.image ?? ""))
                .renderingMode(.original)
                .resizable()
                .indicator(.activity)
                .aspectRatio(contentMode: .fill)
                .frame(width: 128, height: 96, alignment: .center)
                .cornerRadius(4)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(place.name)
                    .lineLimit(2)
                    .font(.title3)
                
                Text(place.address ?? "-")
                    .font(.subheadline)
                    .fontWeight(.light)
                
            }.padding(.vertical, 8)
        }
    }
}
