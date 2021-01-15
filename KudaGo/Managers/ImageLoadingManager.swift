//
//  LoadManager.swift
//  KudaGo
//
//  Created by Николаев Никита on 14.01.2021.
//

import UIKit

class ImageLoadingManager {
    static let shared = ImageLoadingManager()
    var loadedImages = [String: UIImage?]()
    
    private init() {}
    
    func getImageFromURL(urlString: String)-> UIImage? {
        if let image = loadedImages[urlString] {
            return image
        }
        if let url = URL(string: urlString),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            loadedImages[urlString] = image
            return image
        } else {
            loadedImages[urlString] = nil
            return nil
        }
    }
    
    
}
