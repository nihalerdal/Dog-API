//
//  DogAPI.swift
//  Randog
//
//  Created by Nihal Erdal on 4/1/21.
//

import Foundation
import UIKit

class DogAPI{
    enum Endpoint: String{
        case randomImageFromAllDogsCollection = "https://dog.ceo/api/breeds/image/random"
        
        var url : URL {
            return URL(string: self.rawValue)!
            
            
        }
        
        
    }
    
    class func requestImageFile(url:URL, completionHandler: @escaping (UIImage?, Error?) -> Void){

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}

            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)

        }

        task.resume()
    }
    

        
}
