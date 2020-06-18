//
//  AppSettings.swift
//  Inspection
//
//  Created by Beegins on 20/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

open class AppSettings: NSObject {
    
    class func getCurrentUser() -> AppUserStruct {
        if let userDict = UserDefaults.standard.value(forKey: "userData") as? [String : Any] {
            return AppUserStruct(dict: userDict)
        }
        return AppUserStruct(dict: [:])
    }
    
    class func getFabricType() -> [GeneralStruct] {
        var fabricTypeArray = [GeneralStruct]()
        if let fabricArray = UserDefaults.standard.value(forKey: "fabricType") as? [[String : Any]] {
            _ = fabricArray.map({ (fabricDict) in
                fabricTypeArray.append(GeneralStruct(dict: fabricDict))
            })
        }
        return fabricTypeArray
    }
    class func getFabricCategory() -> [GeneralStruct] {
        var fabricTypeArray = [GeneralStruct]()
        if let fabricArray = UserDefaults.standard.value(forKey: "fabricCategory") as? [[String : Any]] {
            _ = fabricArray.map({ (fabricDict) in
                fabricTypeArray.append(GeneralStruct(dict: fabricDict))
            })
        }
        return fabricTypeArray
    }
    class func getRollList() -> [GeneralStruct] {
        var rollArray = [GeneralStruct]()
        if let rollListArray = UserDefaults.standard.value(forKey: "rollList") as? [[String : Any]] {
            _ = rollListArray.map({ (rollDict) in
                rollArray.append(GeneralStruct(dict: rollDict))
            })
        }
        return rollArray
    }


}
