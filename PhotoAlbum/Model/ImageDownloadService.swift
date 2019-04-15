//
//  ImageDownloadService.swift
//  PhotoAlbum
//
//  Created by Pigman on 16/04/2019.
//  Copyright © 2019 Pigman. All rights reserved.
//

import Foundation
import UIKit

class ImageDownloadService {
    static let instance = ImageDownloadService()
    
    let imageCache = NSCache<AnyObject, AnyObject>()
    
    func loadImageUsingCacheWithUrlString(_ urlString: String, handler: @escaping (_ image: UIImage?) ->()) {
        imageCache.countLimit = 100
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            handler(cachedImage)
            return
        }
        
        guard let url = URL(string: urlString) else {
            print("Error of creating URL")
            handler(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error?.localizedDescription ?? "!!!error downloading Image!!!")
                handler(nil)
                return
            }
            
            DispatchQueue.main.async {
                guard let downloadedImage = UIImage(data: data!) else { return }
                self.imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
                handler(downloadedImage)
            }
            }.resume()
    }
}
