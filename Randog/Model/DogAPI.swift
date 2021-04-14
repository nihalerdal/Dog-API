//
//  DogAPI.swift
//  Randog
//
//  Created by Nihal Erdal on 4/1/21.
//

import Foundation
import UIKit

class DogAPI{
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url : URL {
            return URL(string: self.stringValue)!
        }
        
        var stringValue: String{
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
        
    }
    
    class func requestBreedList(completionHandler: @escaping ([String], Error?) -> Void){
       
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, response, error) in
            
            guard let data = data else { return }
            completionHandler([], error)
            
            
            let decoder = JSONDecoder()
            let breedResponse = try! decoder.decode(BreedListResponse.self, from: data)
            let breeds = breedResponse.message.keys.map({$0})
            completionHandler(breeds, error)
        }
        
        task.resume()
    }
    
    
    class func requestImageFile(url:URL, completionHandler: @escaping (UIImage?, Error?) -> Void){

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {return}

            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)

        }

        task.resume()
    }
    
    
    class func requestRandomImage(breed: String, completionHandler: @escaping (DogImage?, Error?) -> Void ){
        
        let randomImageEndpoint = DogAPI.Endpoint.randomImageForBreed(breed).url
               
        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
            guard let data = data else {return}
//            if it's not successful
            completionHandler(nil, error)
           
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(DogImage.self, from: data)
            print(imageData)
//            if it's successfull
            completionHandler(imageData, nil)
        }
        task.resume()
    }
}
