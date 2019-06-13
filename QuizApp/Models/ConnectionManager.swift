//
//  ConnectionManager.swift
//  QuizApp
//
//  Created by Lovro Pejic on 13/06/2019.
//  Copyright © 2019 Lovro Pejic. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class ConnectionManager{

    static let instance = ConnectionManager()
    private init() {}
    
    func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
