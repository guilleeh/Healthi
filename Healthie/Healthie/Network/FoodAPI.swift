//
//  FoodAPI.swift
//  Healthie
//
//  Created by Memo on 1/23/20.
//  Copyright © 2020 Healthie. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

enum NetworkError: Error {
    case failure
    case success
}

class APIRequestFetcher {
    var searchResults = [JSON]()
    
    func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkError) -> ()) {
        
        // –––––––– Add API URL
        let urlToSearch: String = ""
        
        // –––––––– GET Response
        Alamofire.request(urlToSearch).responseJSON { response in
            // Error: response is nil (i.e. network error)
            guard let data = response.data else {
                completionHandler(nil, .failure)
                return
            }
            
            // Error: response is empty
            let json = try? JSON(data: data)
            let results = json?["blah"]["blah"].arrayValue
            guard let empty = results?.isEmpty, !empty else {
                completionHandler(nil, .failure)
                return
            }
            
            // Success
            completionHandler(results, .success)
        }
    }
    
    func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkError) -> ()) {
        Alamofire.request(url).responseData { responseData in
            
            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }
            
            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }
            
            completionHandler(image, .success)
        }
    }
}


