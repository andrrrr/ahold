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

    static private let key = "0fiuZFh4"
    let url = "https://www.rijksmuseum.nl/api/en/collection?key=\(key)&p=[PAGE]&ps=20"

    private let session: URLSessionProtocol
    private let httpClient: HttpClient

    init(session: URLSessionProtocol) {
        self.session = session
        self.httpClient = HttpClient(session: session)// RemoteFetchService(session: session)
        loadMore(1)
    }

    func loadMore(_ page: Int) {
        print("load \(page)")
        guard let urlWithPage = URL(string: url.replacingOccurrences(of: "[PAGE]", with: "\(page)")) else { return }
        httpClient.get(url: urlWithPage) { (data, error) in
            do {
                if let data  = data {
                    let result = try JSONDecoder().decode(ArtObjectsData.self, from: data)
                    DispatchQueue.main.async {
                        self.artObjects += result.artObjects
                    }
                }
            } catch {
                print("error decoding")
            }
        }
    }
}
