//
//  RollStruct.swift
//  Inspection
//
//  Created by Beegins on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

struct RollStruct {
    var titleText : String = ""
    var onePoint : Int = 0
    var twoPoint : Int = 0
    var threePoint : Int = 0
    var fourPoint : Int = 0
    
    init(dict : [String : Any]) {
        titleText = dict["title"] as! String
        onePoint = dict["1 point"] as! Int
        twoPoint = dict["2 point"] as! Int
        threePoint = dict["3 point"] as! Int
        fourPoint = dict["4 point"] as! Int
    }
}

struct SubjectStruct {
    var titleText : String = ""
    var value : String = ""
    
    init(dict : [String : Any]) {
        titleText = dict["title"] as! String
        value = dict["value"] as! String
    }
}

