//
//  ArtObject.swift
//  AholdDelhaize
//
//  Created by Andrei Nevar on 24/04/2020.
//  Copyright © 2020 Andrei Nevar. All rights reserved.
//

import Foundation

struct ArtObjectsData : Decodable {
    let artObjects : [ArtObject]
}

struct ArtObject: Decodable, Hashable {

    var id: String
    var objectNumber: String
    var title: String
    var hasImage: Bool
    var principalOrFirstMaker: String
    var longTitle: String
    var showImage: Bool
    var permitDownload: Bool
    var webImage: WebImage
    var headerImage: HeaderImage
    var productionPlaces: [String]

    static func == (lhs: ArtObject, rhs: ArtObject) -> Bool {
        return lhs.id == rhs.id && lhs.objectNumber == rhs.objectNumber
    }
}

struct WebImage: Decodable, Hashable {
    var guid: String
    var offsetPercentageX: Int
    var offsetPercentageY: Int
    var width: Int
    var height: Int
    var url: String

    static func == (lhs: WebImage, rhs: WebImage) -> Bool {
        return lhs.guid == rhs.guid
    }
}

struct HeaderImage: Decodable, Hashable {
    var guid: String
    var offsetPercentageX: Int
    var offsetPercentageY: Int
    var width: Int
    var height: Int
    var url: String

    static func == (lhs: HeaderImage, rhs: HeaderImage) -> Bool {
        return lhs.guid == rhs.guid
    }
}




