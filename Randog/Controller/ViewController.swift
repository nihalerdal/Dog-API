//
//  ViewController.swift
//  Randog
//
//  Created by Nihal Erdal on 4/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var breeds : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        DogAPI.requestBreedList(completionHandler: handleBreedListResponse(breeds:error:))
        
        //GET
        
//        let randomImageEndpoint = DogAPI.Endpoint.randomImageFromAllDogsCollection.url
        
//        let task = URLSession.shared.dataTask(with: randomImageEndpoint) { (data, response, error) in
//            guard let data = data else {return}
            
            
            //           2.parsing via codable
            
//            let decoder = JSONDecoder()
//            let imageData = try! decoder.decode(DogImage.self, from: data)
//            print(imageData)
            
            // parsing burada bitti tum key-value lari aldim. simdi ilk requestin outputlariyla yeni req olusturcam. fotolari getirebilmek icin tekrar data task.
    
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
    
    func handleBreedListResponse(breeds: [String], error: Error?){
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }

   
}

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        breeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        DogAPI.requestRandomImage(breed: breeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
}

