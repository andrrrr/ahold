//
//  ContentView.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 24/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import SwiftUI
import Combine

struct ContentView: View {

    @EnvironmentObject var artObjectStore: ArtObjectStore
    @State private var pageCount = 0
    @State private var tappedLink: String? = nil

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
        artObjectStore.loadMore(pageCount)
        pageCount += 1
    }

    private func link(for artObject: ArtObject) -> some View {
        let selection = Binding(get: { self.tappedLink },
            set: {
                UIApplication.shared.endEditing()
                self.tappedLink = $0
        })
        return NavigationLink(destination: DetailView(artObject: artObject), tag: artObject.title, selection: selection) {
            HStack(alignment: .bottom) {
                Text("\(artObject.title)").font(.footnote).foregroundColor(.gray)
                ImageViewContainer(imageURL: artObject.webImage.url)
            }
        }
    }


}

struct ImageViewContainer: View {
    @ObjectBinding var remoteImageURL: RemoteImageURL

    init(imageURL: String) {
        remoteImageURL = RemoteImageURL(imageURL: imageURL)
    }

    var body: some View {
        Image(uiImage: (remoteImageURL.data.isEmpty) ? UIImage(imageLiteralResourceName: "Switf") : UIImage(data: remoteImageURL.data)!)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 250, height: 250)
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
