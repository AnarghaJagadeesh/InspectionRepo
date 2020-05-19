//
//  SummaryStruct.swift
//  Inspection
//
//  Created by Beegins on 18/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import Foundation


struct SummaryFirstStruct {
    var rollNumber : String
    var shrinkage : Double
    var torque : Double
    
    init(dict : [String : Any]) {
        rollNumber = dict["rollNumber"] as! String
        shrinkage = dict["shrinkage"] as! Double
        torque = dict["torque"] as! Double
    }
}
