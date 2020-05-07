//
//  SummaryRollDetailsCollectionViewCell.swift
//  Inspection
//
//  Created by Anpu S Anand on 07/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class SummaryRollDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addNewMainView: UIView!
    
    @IBOutlet weak var shrinkageResultTxt: UITextField!
    @IBOutlet weak var rollNumberTxt: UITextField!
    
    @IBOutlet weak var torqueTxt: UITextField!
    
    func initialSetUp(){
        addNewMainView.layer.cornerRadius = 17
        
    }
    
}
