//
//  RemoteFetchService.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 24/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import Foundation

class RemoteFetchService {

    static let key = "0fiuZFh4"

    static func fetchData(page: Int, success: @escaping ([ArtObject]) -> Void) {
        let url = URL(string: "https://www.rijksmuseum.nl/api/en/collection?key=\(key)&p=\(page)&ps=20")!

        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(String(describing: response))")
                    return
            }

            do {

                let result = try JSONDecoder().decode(ArtObjectsData.self, from: data!)
                success(result.artObjects)
            } catch {
                print(error)
            }
        })
        task.resume()
    }
}
