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

struct SummaryDataStruct {
    var isAccepted : Bool
    var comments : String
    var inspectionNo : Int
    var acceptedRolls : Int
    var rejectedRolls : Int
    var avgPoints : Int
    
    init(status : Bool , comm : String, inspectionNo : Int, accepRolls : Int, rejRolls : Int,avgPoints : Int) {
        self.isAccepted = status
        self.comments = comm
        self.inspectionNo = inspectionNo
        self.acceptedRolls = accepRolls
        self.rejectedRolls = rejRolls
        self.avgPoints = avgPoints
    }
}
