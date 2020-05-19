//
//  HomeCollectionViewCell.swift
//  Inspection
//
//  Created by Anpu S Anand on 09/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var poNumberTxt: UILabel!
    @IBOutlet weak var customerTxt: UILabel!
    @IBOutlet weak var dateTxt: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    var basicStruct : BasicFirstStruct? {
        didSet {
            if let model = basicStruct {
                customerTxt.text = model.reportToName
                dateTxt.text = model.date
                poNumberTxt.text = model.PONo
            }
        }
    }
    
    var didTapAction : ((BasicFirstStruct)->Void)?
    
    @IBAction func actionBtnPressed(_ sender: Any) {
        if let model = basicStruct {
            self.didTapAction?(model)
        }
    }
    
    
}
