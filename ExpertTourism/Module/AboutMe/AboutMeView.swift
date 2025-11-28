//
//  AboutMeView.swift
//  ExpertTourism
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct AboutMeView: View {
    
    var imageUrl = "https://assets.cdn.dicoding.com/small/avatar/dos:f35080cab26989fa74f9278f23ab95bb20230811053458.png"
    var name = "Rijal Muhyidin"
    var email = "muhyidinrijal@gmail.com"
    
    var body: some View {
        NavigationStack {
            VStack {
                WebImage(url: URL(string: self.imageUrl))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 224, height: 224)
                    .clipShape(.circle)

                Text(self.name)
                    .font(.title)
                    .fontWeight(.bold)
                Text(self.email)
                    .font(.subheadline)
            }
            .navigationBarTitle(Text("About Me"), displayMode: .inline)
        }
    }
}

#Preview {
    AboutMeView()
}
