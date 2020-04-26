//
//  ContentView.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 24/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var artObjectStore: ArtObjectStore
    @State private var pageCount = 1
    @State private var tappedLink: String? = nil
    @Environment(\.imageCache) var cache: ImageCache

    var body: some View {
        NavigationView {
            Form {

                Section(header: Text("Rijksmuseum")) {

                    List {
                        ForEach(artObjectStore.artObjects, id: \.self) { artObject in
                            self.link(for: artObject)

                        }
                        Button(action: loadMore) {
                            Text("")
                        }
                        .onAppear {
                            DispatchQueue.global(qos: .background).asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 10)) {
                                self.loadMore()
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Art objects")
        }
        .onAppear(perform: loadMore)

    }

    func loadMore() {
        pageCount += 1
        artObjectStore.loadMore(pageCount)
    }

    private func link(for artObject: ArtObject) -> some View {
        let selection = Binding(get: { self.tappedLink },
            set: {
                UIApplication.shared.endEditing()
                self.tappedLink = $0
        })

        return NavigationLink(destination: DetailView(artObject: artObject, cache: self.cache),
                              tag: artObject.id,
                              selection: selection) {
            HStack(alignment: .center) {
                VStack(alignment: .leading){
                    Text("\(artObject.title)").font(.system(size: 12))
                    Text("\(artObject.principalOrFirstMaker)").font(.system(size: 9)).foregroundColor(.gray)
                }
                Spacer()
                AsyncImage(
                    url: URL(string: artObject.headerImage.url)!,
                    cache: self.cache,
                    width: 200,
                    height: 50
                )
            }
        }
    }
}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
