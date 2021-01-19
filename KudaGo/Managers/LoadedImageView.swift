//
//  LoadedImageView.swift
//  KudaGo
//
//  Created by Николаев Никита on 19.01.2021.
//

import UIKit

class LoadedImageView: UIImageView {
    static let imageCache = NSCache<NSURL, UIImage>()
    var task: URLSessionTask!
    
    func loadImage(from url: URL) {
        image = nil
        if let task = task {
            task.cancel()
        }
        if let imageFromCache = LoadedImageView.imageCache.object(forKey: url as NSURL) {
            image = imageFromCache
            return
        }
        task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data,
                  let newImage = UIImage(data: data) else { return }
            LoadedImageView.imageCache.setObject(newImage, forKey: url as NSURL)
            DispatchQueue.main.async {
                self.alpha = 0
                self.image = newImage
                UIView.animate(withDuration: 1,
                               delay: 0,
                               options: .curveEaseIn,
                               animations: { self.alpha = 1 } )
            }
        }
        task.resume()
    }

}
