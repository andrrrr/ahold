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
    var body: some View {
        NavigationView {
            Text(artObject.title)
        }
    }
}


