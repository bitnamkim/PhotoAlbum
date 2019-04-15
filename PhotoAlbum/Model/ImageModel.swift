//
//  ImageModel.swift
//  PhotoAlbum
//
//  Created by Pigman on 16/04/2019.
//  Copyright © 2019 Pigman. All rights reserved.
//

import Foundation

struct ImageModel: Decodable {
    let albumId: Int
    let id: Int
    let title: String
    let url: String
    let thumbnailUrl: String
}

struct Album {
    let albumId: Int
    let images: [ImageModel]
}
