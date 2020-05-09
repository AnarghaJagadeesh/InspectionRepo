//
//  RollsFirstCollectionViewCell.swift
//  Inspection
//
//  Created by Beegins on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

enum PointType {
    case ONEPOINT
    case TWOPOINT
    case THREEPOINT
    case FOURPOINT
}

class RollsFirstFooterCell : UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblOnePoint: UILabel!
    @IBOutlet weak var lblTwoPoint: UILabel!
    @IBOutlet weak var lblThreePoint: UILabel!
    @IBOutlet weak var lblFourPoint: UILabel!
    
    
    var rollModel : RollStruct? {
        didSet {
            if let model = rollModel {
                self.lblTitle.text = model.titleText
                self.lblFourPoint.text = "\(model.fourPoint)"
                self.lblThreePoint.text = "\(model.threePoint)"
                self.lblTwoPoint.text = "\(model.twoPoint)"
                self.lblOnePoint.text = "\(model.onePoint)"
            }
        }
    }
}

class RollsFirstCollectionViewCell: UICollectionViewCell {
    
    var didTapMinusPlus : ((Bool,PointType,Int,Int)->Void)?
    
    var rollModel : RollStruct? {
        didSet {
            if let model = rollModel {
                self.lblOnePoint.text = "\(model.onePoint)"
                self.lblTwoPoint.text = "\(model.twoPoint)"
                self.lblThreePoint.text = "\(model.threePoint)"
                self.lblFourPoint.text = "\(model.fourPoint)"
                self.lblTitle.text = model.titleText
            }
        }
    }
    
    var currentIndex : Int? {
        didSet {
            if let index = currentIndex {
                if index == 0 {
                    self.lblOneTitle.isHidden = false
                     self.lblTwoTitle.isHidden = false
                     self.lblThreeTitle.isHidden = false
                     self.lblFourTitle.isHidden = false
                } else {
                    self.lblOneTitle.isHidden = true
                     self.lblTwoTitle.isHidden = true
                     self.lblThreeTitle.isHidden = true
                     self.lblFourTitle.isHidden = true

                }
            }
        }
    }
    
    @IBAction func onTapOneMinusPlus(_ sender: UIButton) {
        var value : Int = Int(self.lblOnePoint.text ?? "") ?? 0
         let isPlus = sender.tag == 0 ? false : true
        if sender.tag == 0 {
            if value != 0 {
                value = value - 1
                self.didTapMinusPlus?(isPlus,PointType.ONEPOINT,value,currentIndex ?? 0)
            }
        } else {
            value = value + 1
            self.didTapMinusPlus?(isPlus,PointType.ONEPOINT,value,currentIndex ?? 0)
        }
       
        self.lblOnePoint.text = "\(value)"
    }
    @IBAction func onTapTwoMinusPlus(_ sender: UIButton) {
        let isPlus = sender.tag == 0 ? false : true
        var value : Int = Int(self.lblTwoPoint.text ?? "") ?? 0
        if sender.tag == 0 {
            if value != 0 {
                value = value - 1
                self.didTapMinusPlus?(isPlus,PointType.TWOPOINT,value,currentIndex ?? 0)

            }
        } else {
            value = value + 1
            self.didTapMinusPlus?(isPlus,PointType.TWOPOINT,value,currentIndex ?? 0)

        }
        
        self.lblTwoPoint.text = "\(value)"

    }
    @IBAction func onTapThreeMinusPlus(_ sender: UIButton) {
        let isPlus = sender.tag == 0 ? false : true
        var value : Int = Int(self.lblThreePoint.text ?? "") ?? 0
        if sender.tag == 0 {
            if value != 0 {
                value = value - 1
                self.didTapMinusPlus?(isPlus,PointType.THREEPOINT,value,currentIndex ?? 0)

            }
        } else {
            value = value + 1
            self.didTapMinusPlus?(isPlus,PointType.THREEPOINT,value,currentIndex ?? 0)

        }
        
        self.lblThreePoint.text = "\(value)"

    }
  
    @IBAction func onTapFourMinusPlus(_ sender: UIButton) {
        let isPlus = sender.tag == 0 ? false : true
        var value : Int = Int(self.lblFourPoint.text ?? "") ?? 0
        if sender.tag == 0 {
            if value != 0 {
                value = value - 1
                self.didTapMinusPlus?(isPlus,PointType.FOURPOINT,value,currentIndex ?? 0)
            }
        } else {
            value = value + 1
            self.didTapMinusPlus?(isPlus,PointType.FOURPOINT,value,currentIndex ?? 0)
        }
        
        self.lblFourPoint.text = "\(value)"

    }
    @IBOutlet weak var lblOnePoint: UILabel!
    @IBOutlet weak var lblTwoPoint: UILabel!
    @IBOutlet weak var lblThreePoint: UILabel!
    
    @IBOutlet weak var lblFourPoint: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var lblOneTitle: UILabel!
    @IBOutlet weak var lblTwoTitle: UILabel!
    @IBOutlet weak var lblThreeTitle: UILabel!
    @IBOutlet weak var lblFourTitle: UILabel!
    
    
}
