//
//  DetailView.swift
//  BackbaseAssignment
//
//  Created by Andrei Nevar on 21/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import SwiftUI
import MapKit

struct DetailView: View {
    let artObject: ArtObject
    let cache: ImageCache
    var body: some View {
        NavigationView {

            VStack(alignment: .leading) {
                Text("\(artObject.title)").font(.system(size: 14))
                Text("\(artObject.principalOrFirstMaker)").font(.system(size: 12)).foregroundColor(.gray)

                AsyncImage(
                    url: URL(string: artObject.webImage.url)!,
                    cache: self.cache
                )
                Text(artObject.longTitle).font(.system(size: 12)).foregroundColor(.gray)
                if !artObject.productionPlaces.isEmpty {
                    Text(" ")
                    Text("Production places: ").font(.system(size: 12)).foregroundColor(.gray)
                    ForEach(artObject.productionPlaces, id: \.self) { place in
                        Text(place).font(.system(size: 12)).foregroundColor(.gray)
                    }
                }
                Spacer()

            }

        }
    }
}


