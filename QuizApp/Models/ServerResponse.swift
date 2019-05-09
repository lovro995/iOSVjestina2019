//
//  ServerResponse.swift
//  QuizApp
//
//  Created by Lovro Pejic on 08/05/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation

enum ServerResponse: String {
    case unauthorized
    case forbidden
    case notFound
    case bedRequest
    case ok
    
    var code: Int {
        switch self {
        case .unauthorized:
            return 401
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .bedRequest:
            return 400
        case .ok:
            return 200
        }
    }
    
    init?(code : Int){
        switch code {
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 400:
            self = .bedRequest
        case 200:
            self = .ok
        default:
            return nil
        }
    }
}
