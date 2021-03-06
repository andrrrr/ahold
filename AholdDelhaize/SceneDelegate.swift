//
//  SceneDelegate.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 24/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        if let windowScene = scene as? UIWindowScene {

            let window = UIWindow(windowScene: windowScene)
            let session = URLSession.shared
            let store = ArtObjectStore(session: session)
            window.rootViewController = UIHostingController(
                rootView: ContentView().environmentObject(store)
            )
            self.window = window
            window.makeKeyAndVisible()
        }
    }


}

