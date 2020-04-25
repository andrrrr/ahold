//
//  ImageContainer.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 25/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import SwiftUI
import Combine

struct ImageViewContainer: View {
    @ObservedObject var remoteImageURL: RemoteImageURL

    init(imageURL: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageURL)
    }

    var body: some View {
        Image(uiImage: (remoteImageURL.data.isEmpty) ? UIImage(imageLiteralResourceName: "Swift") : UIImage(data: remoteImageURL.data)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}

class RemoteImageURL: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()

    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }

            DispatchQueue.main.async {
                self.data = data
            }

        }.resume()
    }
}
