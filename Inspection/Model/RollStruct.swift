//
//  RollStruct.swift
//  Inspection
//
//  Created by Beegins on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

struct RollMainStruct {
    var inspectionNo : Int
    var rankArray : [RollStruct]
    var rollNo : Int
    
    init(inspectionNo : Int, rankArr : [RollStruct], rollNo : Int) {
        self.inspectionNo = inspectionNo
        self.rankArray = rankArr
        self.rollNo = rollNo
    }
}

struct RollStruct {
    var titleText : String = ""
    var id : Int = 0
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
        id = dict["id"] as! Int
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

struct RollSummaryStruct {
    var totalPoints : Int = 0
    var status : Bool = false
    var inspectionNo : Int = 0
    var rollNo : Int = 0
    var yardValue : Double = 0.0
    var remarks : String = ""
    var grade : String = ""
    var pointDict : RollStruct
    
    init(dict: [String : Any]) {
        inspectionNo = dict["inspectionNo"] as! Int
        totalPoints = dict["totalPoints"] as! Int
        status = dict["status"] as! Bool
        rollNo = dict["rollNo"] as! Int
        yardValue = dict["yardValue"] as! Double
        remarks = dict["remarks"] as! String
        grade = dict["grade"] as! String
        pointDict = RollStruct(dict: dict["pointDict"] as! [String:Any])
    }
}

struct RollImgaesStruct {
    var rollImages : [Data]
    var rollNo : Int
    var inspectionNo : Int
    
    init(img : [Data], inspecNo : Int, rollNo : Int) {
        self.rollImages = img
        self.rollNo = rollNo
        self.inspectionNo = inspecNo
    }
}
