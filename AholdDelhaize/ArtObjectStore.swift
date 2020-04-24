//
//  ArtObjectStore.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 24/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import Foundation
import Combine

class ArtObjectStore: ObservableObject {

    @Published private(set) var artObjects: [ArtObject] = []


    init() {
        loadMore(0)
    }

    func loadMore(_ page: Int) {
        RemoteFetchService.fetchData(page: page, success: { artObjects in
            DispatchQueue.main.async {
                self.artObjects += artObjects
            }
        })
    }
}
