//
//  WebService.swift
//  Test
//
//  Created by Abhishek Rathore on 06/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation
import SwiftyJSON

class Webservice {
    
    private let sourceURL = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")!
    
    static let sharedInstance = Webservice()
    
    func loadData(completion :@escaping ([DetailedDescription]?, String?, String?) -> ()) {
        
        var arrDetailedDescription: [DetailedDescription] = []
        
        URLSession.shared.dataTask(with: sourceURL) { (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                completion(nil, nil, error!.localizedDescription)
            }
            
            guard let responseData = data else {
                //UIViewController.removeHUD(hud)
                completion(nil, nil, nil)
                return
            }
            
            let responseStrInISOLatin = String(data: responseData, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                completion(nil, nil, "could not convert data to UTF-8 format")
                return
            }
            
            do {
                let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format)
                let json = JSON(responseJSONDict)
                
                for item in json["rows"].arrayValue {
                    let detailedDescriptionData = DetailedDescription.init(title: item["title"].stringValue, description: item["description"].stringValue, mediaPath: item["imageHref"].stringValue)
                    arrDetailedDescription.append(detailedDescriptionData)
                }
                
                completion(arrDetailedDescription, json["title"].stringValue, nil)
            } catch {
                completion(nil, nil, error.localizedDescription)
            }
            
            }.resume()
        
    }
    
}
