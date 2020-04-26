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
                    placeholder: Text("Loading image...").font(.footnote).foregroundColor(.gray),
                    cache: self.cache,
                    width: 400,
                    height: 400
                )
                Spacer()

            }
            Text(artObject.title)
        }
    }
}


