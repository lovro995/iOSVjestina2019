//
//  CategoryImageService.swift
//  QuizApp
//
//  Created by Lovro Pejic on 07/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import UIKit

class CategoryImageService {
    // ova funkcija prima String i blok koda koja prima UIImage?
    // @escaping anotaciju zasada zanemariti
    func fetchCategoryImage(categoryImageString: String, completion: @escaping((UIImage?)-> Void)){
        let urlString = categoryImageString
        // ovdje stvaramo URL objekt kojeg mozemo stvoriti iz nekog stringa koji je url
        // ako string nije url onda ovaj failable konstruktor vraca nil
        if let url = URL(string: urlString) {
            
            // URLRequest objekt stvaramo iz URL objekta
           
            let request = URLRequest(url: url)
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                print("fetched image")
                if let data = data {
                    let image = UIImage(data: data)
                    
                    completion(image)
                   // print("completion called for image fetch")
                } else {
                    completion(nil)
                }
            }
            // kraj stvaranja dataTask-a
            
            print("resuming data task fetch category image")
            // Pokretanje dataTask-a, dohvacanje URL-a
            dataTask.resume()
        } else {
            completion(nil)
        }
    }
}
