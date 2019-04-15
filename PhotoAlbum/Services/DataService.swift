//
//  DataService.swift
//  PhotoAlbum
//
//  Created by Pigman on 16/04/2019.
//  Copyright © 2019 Pigman. All rights reserved.
//

import Foundation

class DataService {
    func fetchDataFromJSON(completion: @escaping (_ album:[Album]?)-> ()) {
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    completion(nil)
                    return
                }
                
                var imageModelArray = [ImageModel]()
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    imageModelArray = try decoder.decode([ImageModel].self, from: data)
                    
                    let album = self.creatAlbumsFrom(imageModelArray)
                    completion(album)
                } catch let jsonError {
                    print(jsonError.localizedDescription)
                    completion(nil)
                    return
                }
            }
        }.resume()
    }
    
    func creatAlbumsFrom(_ imageModelArray: [ImageModel]) -> [Album]? {
        guard let lastAlbumID = imageModelArray.last?.albumId else { return nil }
        var albumsArray = [Album]()
        
        for albumID in 1...lastAlbumID {
            let imagesForAlbum = imageModelArray.filter({ $0.albumId == albumID })
            albumsArray.append(Album(albumId: albumID, images: imagesForAlbum))
        }
        return albumsArray
    }
}
