//
//  Category.swift
//  QuizApp
//
//  Created by Lovro Pejic on 06/04/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import UIKit
import Foundation

enum Category: String {
    case sports
    case science
    
    var color: UIColor {
        switch self {
        case .sports:
            return UIColor.blue
        case .science:
            return UIColor.green
        }
    }

    init?(categoryString : String){
        switch categoryString {
        case "SCIENCE":
            self = .science
        case "SPORTS":
            self = .sports
        default:
            return nil
        }
    }

}



