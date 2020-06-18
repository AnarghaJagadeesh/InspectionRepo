//
//  SummaryFirstCollectionViewCell.swift
//  Inspection
//
//  Created by Beegins on 06/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class SummaryFirstCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    var subjectModel : SubjectStruct? {
        didSet {
            if let model = subjectModel {
                self.lblSubject.text = model.titleText.localiz()
                self.lblValue.text = model.value
            }
        }
    }
}
