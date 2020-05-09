//
//  BasicFirstStruct.swift
//  Inspection
//
//  Created by Beegins on 07/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

struct BasicFirstStruct {
    
    var fabricCategory : String = "Group 1"
    var PONo : String = ""
    var content : String = ""
    var construction : String = ""
    var POCutWidth : Float = 0.0
    var factoryName : String = ""
    var fabricType : String = "Woven"
    var orderQty : Int = 0
    var totalQtyOffered : Int = 0
    var weightGSM : Float = 0.0
    var colorName : String = ""
    var finish : String = ""
    var reportToName : String = ""
    var inspectionNo : Int = 0
    
    init(dict:[String : Any]) {
        self.fabricCategory = dict["fabricCategory"] as! String
        self.PONo = dict["poNo"] as! String
        self.content = dict["content"] as! String
        self.construction = dict["construction"] as! String
        self.POCutWidth = dict["poCutWidth"] as! Float
        self.factoryName = dict["factoryName"] as! String
        self.fabricType = dict["fabricType"] as! String
        self.orderQty = dict["orderQty"] as! Int
        self.totalQtyOffered = dict["totalQtyOffered"] as! Int
        self.weightGSM = dict["weightGSM"] as! Float
        self.colorName = dict["colorName"] as! String
        self.finish = dict["finish"] as! String
        self.reportToName = dict["reportToName"] as! String
        self.inspectionNo = dict["inspectionNo"] as! Int
    }
}

struct BasicSecondStruct {
    var rollNumber : String = ""
    var ticketLength : Float = 0.0
    var actualLength : Float = 0.0
    var actualCutWidthOne : Float = 0.0
    var actualCutWidthTwo : Float = 0.0
    var actualCutWidthThree : Float = 0.0
    var endToEnd : String = ""
    var sideToSide : String = ""
    var sideToCenter : String = ""
    var skewBowing : String = ""
    var pattern : Bool = true
    var actualWeightGSM : Float = 0.0
    var handFeel : Bool = false
    var inspectionNo : Int = 0
    
    init(dict : [String : Any]) {
        self.rollNumber = dict["rollNumber"] as! String
        self.ticketLength = dict["ticketLength"] as! Float
        self.actualLength = dict["actualLength"] as! Float
        self.actualCutWidthOne = dict["actualCutWidthOne"] as! Float
        self.actualCutWidthTwo = dict["actualCutWidthTwo"] as! Float
        self.actualCutWidthThree = dict["actualCutWidthThree"] as! Float
        self.endToEnd = dict["endToEnd"] as! String
        self.sideToSide = dict["sideToSide"] as! String
        self.sideToCenter = dict["sideToCenter"] as! String
        self.skewBowing = dict["skewBowing"] as! String
        self.pattern = dict["pattern"] as! Bool
        self.actualWeightGSM = dict["actualWeightGSM"] as! Float
        self.handFeel = dict["handFeel"] as! Bool
        self.inspectionNo = dict["inspectionNo"] as! Int
    }
    
}
