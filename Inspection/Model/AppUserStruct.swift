//
//  AppUserStruct.swift
//  Inspection
//
//  Created by Beegins on 20/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

struct AppUserStruct {
    var token : String = ""
    var userId : Int = 0
    var userName : String = ""
    
    init(dict:[String : Any]) {
        if let token = dict["token"] as? String {
            self.token = token
        }
        if let userId = dict["user_id"] as? Int {
            self.userId = userId
        }
        if let userName = dict["username"] as? String {
            self.userName = userName
        }
    }
}
