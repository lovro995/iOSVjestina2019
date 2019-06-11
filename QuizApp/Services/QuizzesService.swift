//
//  QuestionsService.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import UIKit

class QuizzesService {
    
    var urlString = "https://iosquiz.herokuapp.com/api/quizzes"
    
    func fetchQuizzes(completion: @escaping ((Quizzes?) -> Void)) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
          
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    
                    do {
                       
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        //print(json)
                        let quizzes = Quizzes(json: json)
                        
                        completion(quizzes)
                    } catch {
                        completion(nil)
                    }
                
                } else {
                    completion(nil)
                }
            }
            print("pokrecem dataTask...")
            dataTask.resume()
        } else {
            completion(nil)
        }
        
    }

}
