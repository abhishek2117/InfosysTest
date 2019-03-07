//
//  ImageCache.swift
//  Test
//
//  Created by Abhishek Rathore on 07/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import Foundation


class ImageCache {
    
    private let cache = NSCache<AnyObject, UIImage>()
    private var observer: NSObjectProtocol!
    
    static let shared = ImageCache()
    
    private init() {
        // make sure to purge cache on memory pressure
        observer = NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: nil) { [weak self] notification in
            self?.cache.removeAllObjects()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(observer)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as AnyObject)
    }
    
    func save(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func remove(forKey key: String) {
        cache.removeObject(forKey: key as AnyObject)
    }
}
