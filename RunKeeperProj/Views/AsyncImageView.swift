//
//  AsyncImageView.swift
//  RunKeeperProj
//
//  Created by Christopher Campanelli on 2020-09-25.
//  Copyright © 2020 Chris Campanelli. All rights reserved.
//

import UIKit

class ImageCache {
    
    private let imageCache = NSCache<NSString, UIImage>()
    static let shared = ImageCache()
    
    func getImage(forKey key: String) -> UIImage? {
        return imageCache.object(forKey: NSString(string: key))
    }
    
    func imageExists(forKey key: String) -> Bool {
        return imageCache.object(forKey: NSString(string: key)) != nil
    }
    
    func set(image: UIImage, forKey key: String) {
        imageCache.setObject(image, forKey: NSString(string: key))
    }
    
}

class AsyncImageView: UIImageView {

    private let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    func setImage(_ URLString: String, placeHolder: UIImage?, completion:((UIImage?) -> Void)? = nil) {

        activityIndicator.frame  = self.bounds
        activityIndicator.color = UIColor.black
        activityIndicator.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        self.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        self.image = placeHolder
        if let cachedImage =  ImageCache.shared.getImage(forKey: URLString) {
            self.image = cachedImage
            self.activityIndicator.stopAnimating()
            return
        }
        
        if let url = URL.init(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
                    DispatchQueue.main.async { [weak self] in
                        self?.activityIndicator.stopAnimating()
                        self?.image = placeHolder
                        completion?(nil)
                    }
                    return
                }
                DispatchQueue.main.async { [weak self] in
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self?.image = downloadedImage
                            ImageCache.shared.set(image: downloadedImage, forKey: URLString)
                            self?.activityIndicator.stopAnimating()
                            completion?(downloadedImage)
                        }
                    }
                }
            }).resume()
        }
    }
}
