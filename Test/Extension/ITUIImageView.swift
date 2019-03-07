//
//  UIImage.swift
//  Test
//
//  Created by Abhishek Rathore on 06/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import UIKit
import Foundation

private var activityIndicatorAssociationKey: UInt8 = 0

extension UIImageView {
    
    @IBInspectable var activityIndicator : UIActivityIndicatorView! {
        
        get {
            return objc_getAssociatedObject(self, &activityIndicatorAssociationKey) as? UIActivityIndicatorView
        }
        
        set(newValue) {
            objc_setAssociatedObject(self, &activityIndicatorAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        
    }
    
    func showActivityIndicator() {
        
        if self.activityIndicator == nil {
            self.activityIndicator = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
            self.activityIndicator.frame = CGRect.init(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.center = CGPoint.init(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
            
            self.activityIndicator.isUserInteractionEnabled = false
            
            OperationQueue.main.addOperation {
                self.addSubview(self.activityIndicator)
                self.bringSubviewToFront(self.activityIndicator)
                self.activityIndicator.startAnimating()
            }
        }
    }
    
    func hideActivityIndicator() {
        OperationQueue.main.addOperation {
            self.activityIndicator.stopAnimating()
        }
    }
    
    func loadImage(fromUrl urlString: String) {
        
        showActivityIndicator()
        
        if !urlString.isEmpty {
            
            // check cache
            if let cachedImage = ImageCache.shared.image(forKey: urlString) {
                self.hideActivityIndicator()
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }
            
            guard let imageUrl = URL(string: urlString) else {
                return
            }
            
            let request = URLRequest(url: imageUrl, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: Constant.webServiceTimeOut)
            let task = URLSession.shared.dataTask(with: request){ data, response, error in
                
                self.hideActivityIndicator()
                
                guard error == nil else {
                    debugPrint(error!)
                    return
                }
                
                guard let responseData = data else {
                    debugPrint("Error: did not receive data")
                    return
                }
                
                if let image = UIImage(data: responseData) {
                    ImageCache.shared.save(image: image, forKey: (response?.url?.absoluteString)!)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
                
            }
            task.resume()
        }
    }
}
