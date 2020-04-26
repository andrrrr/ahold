//
//  ImageContainer.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 25/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {

    let objectWillChange = ObservableObjectPublisher()

    private var cancellable: AnyCancellable?
    @Published var image: UIImage? {
        willSet {
            print("image set")
//            objectWillChange.send()
        }
    }


    private let url: URL

    private var cache: ImageCache?

    init(url: URL, cache: ImageCache? = nil) {
        self.url = url
        self.cache = cache
    }

    deinit {
        cancellable?.cancel()
    }

    private func cache(_ image: UIImage?) {
        image.map { cache?[url] = $0 }
    }

    func load() {
        if let image = cache?[url] {
            self.image = image
            return
        }

//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .receive(on: DispatchQueue.main)
//            .replaceError(with: nil)
//            .sink(receiveValue: { [weak self] in self?.cache($0) })

//        cancellable = URLSession.shared.dataTaskPublisher(for: url)
//            .map { UIImage(data: $0.data) }
//            .receive(on: DispatchQueue.main)
//            .replaceError(with: nil)
//            .sink(receiveValue: { image in
//                self.cache(image)
//            })


        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { [weak self] in self?.cache($0) })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)


    }

    func cancel() {
        cancellable?.cancel()
    }
}


struct AsyncImage: View {
    @ObservedObject private var loader: ImageLoader
    private let width: CGFloat?
    private let height: CGFloat?
    @State var spin = false

    init(url: URL, cache: ImageCache? = nil, width: CGFloat? = nil, height: CGFloat? = nil) {
        loader = ImageLoader(url: url, cache: cache)
        self.width = width
        self.height = height
    }

    var body: some View {
        image
            .onAppear(perform: loader.load)
            .onDisappear(perform: loader.cancel)
    }

    private var image: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width, height: height)
            } else {
                Image("loadingCircle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .rotationEffect(.degrees(spin ? 360 : 0))
                    .animation(Animation.linear(duration: 0.8).repeatForever(autoreverses: false))
                    .onAppear() {
                        self.spin.toggle()
                }
            }
        }
    }
}

protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}

struct TemporaryImageCache: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}


struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: ImageCache = TemporaryImageCache()
}

extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
