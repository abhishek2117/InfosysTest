//
//  WebService.swift
//  Test
//
//  Created by Abhishek Rathore on 06/03/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation
import SwiftyJSON

class WebService {
    
    private let sourceURL = URL(string: Constant.urlCountryDetail)!
    
    static let sharedInstance = WebService()
    
    func loadData(completion: @escaping ([CountryDetails]?, String?, String?) -> ()) {
        
        var arrDetailedDescription: [CountryDetails] = []
        
        URLSession.shared.dataTask(with: sourceURL) { (data, response, error) in
            
            if error != nil {
                debugPrint(error!.localizedDescription)
                completion(nil, nil, error!.localizedDescription)
            }
            
            guard let responseData = data else {
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
                    let detailedDescriptionData = CountryDetails.init(title: item[CountryDetailsJsonConstant.title].stringValue, description: item[CountryDetailsJsonConstant.description].stringValue, mediaPath: item[CountryDetailsJsonConstant.imageHref].stringValue)
                    
                    if detailedDescriptionData.title != "" || detailedDescriptionData.description != "" || detailedDescriptionData.mediaPath != "" {
                        arrDetailedDescription.append(detailedDescriptionData)
                    }
                }
                
                completion(arrDetailedDescription, json[CountryDetailsJsonConstant.title].stringValue, nil)
            } catch {
                completion(nil, nil, error.localizedDescription)
            }
            
            }.resume()
        
    }
    
}
