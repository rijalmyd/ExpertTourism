//
//  AboutMeView.swift
//  About
//
//  Created by Rijal Muhyidin on 20/11/25.
//

import SwiftUI
import SDWebImageSwiftUI

public struct AboutMeView: View {
    
    private let imageUrl: String
    private let name: String
    private let email: String
    
    public init(
        imageUrl: String = "https://assets.cdn.dicoding.com/small/avatar/dos:f35080cab26989fa74f9278f23ab95bb20230811053458.png",
        name: String = "Rijal Muhyidin",
        email: String = "muhyidinrijal@gmail.com"
    ) {
        self.imageUrl = imageUrl
        self.name = name
        self.email = email
    }
    
    public var body: some View {
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
