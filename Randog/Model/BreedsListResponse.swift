//
//  BreedsListResponse.swift
//  Randog
//
//  Created by Nihal Erdal on 4/13/21.
//

import Foundation

struct BreedListResponse: Codable {
    let status : String
    let message: [String : [String] ]
}
