//
//  SummaryBottomCollectionViewCell.swift
//  Inspection
//
//  Created by Anpu S Anand on 08/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import M13Checkbox

class SummaryBottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var yesBtn: M13Checkbox!
    
    
    @IBOutlet weak var noBtn: M13Checkbox!
    @IBOutlet weak var cmtTxtView: UITextView!
    
    
    func initialSetup(){
        cmtTxtView.layer.borderColor = UIColor.lightGray.cgColor
        cmtTxtView.layer.borderWidth = 0.5
        
    }
    
   
}
