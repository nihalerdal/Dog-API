//
//  ViewController.swift
//  Randog
//
//  Created by Nihal Erdal on 4/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //GET
        
//        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
//        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
//            guard let data = data else {return}
            
            
            //           2.parsing via codable
            
//            let decoder = JSONDecoder()
//            let imageData = try! decoder.decode(DogImage.self, from: data)
//            print(imageData)
            
            // parsing burada bitti tum key-value lari aldim. simdi ilk requestin outputlariyla yeni req olusturcam. fotolari getirebilmek icin tekrar data task.
        
        DogAPI.requestRandomImage(completionHandler: handleRandomImageResponse(imageData:error:))
    }
//        task.resume()
         
        //          1.parsing via JSON Serialization
        
        //            do {
        //                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        //                let url = json["message"] as! String
        //                print(url)
        //            } catch{
        //                print(error)
        //            }
        
        
    
    
    func handleImageFileResponse(image: UIImage?, error: Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }

    func handleRandomImageResponse(imageData: DogImage?, error: Error?){
        guard let imageUrl = URL(string: imageData?.message ?? "" ) else {return}
        
        DogAPI.requestImageFile(url: imageUrl, completionHandler: handleImageFileResponse(image:error:))
    }

}


