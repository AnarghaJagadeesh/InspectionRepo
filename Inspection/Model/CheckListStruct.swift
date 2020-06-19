//
//  CheckListStruct.swift
//  Inspection
//
//  Created by Beegins on 23/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

struct CheckListMainStruct {
    var checkListData : [CheckListStruct]
    var inspectionNo : Int
    var comments : String
    
    init(inspectionNo : Int, model : [CheckListStruct], comm : String) {
        self.checkListData = model
        self.inspectionNo = inspectionNo
        self.comments = comm
    }
}

struct CheckListStruct {
    var titleText : String
    var isChecked : Bool
    var remark : String
    var inspectionNo : Int = 0
    
    init(title: String, remark : String, isChecked : Bool = false) {
        self.titleText = title
        self.isChecked = false
        self.remark = remark
    }
    
    init(dict: [String : Any]) {
        self.titleText = dict["title"] as! String
        self.remark = dict["remarks"] as! String
        self.isChecked = dict["status"] as! Bool
    }
}

