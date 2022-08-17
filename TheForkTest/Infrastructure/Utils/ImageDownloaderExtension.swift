//
//  ImageDownloaderExtension.swift
//  TheForkTest
//
//  Created by Max Ward on 16/08/2022.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView
{
    func loadImageFromUrl(urlString: String, placeholder: String? = nil) async {
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromDisk = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromDisk
            return
        }
        
        if placeholder != nil {
            image = UIImage(named: placeholder!)
        }
        do {
            let (imageData, _) = try await URLSession.shared.data(from: url)
            
            DispatchQueue.main.async {
                if let imageToCache = UIImage(data: imageData) {
                    imageCache.setObject(imageToCache, forKey: NSString(string: urlString))
                    self.image = imageToCache
                }
            }
            
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
