//
//  CheckListCollectionViewCell.swift
//  Inspection
//
//  Created by Beegins on 23/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import M13Checkbox

class CheckListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var yesCheckbox: M13Checkbox!
    @IBOutlet weak var noCheckbox: M13Checkbox!
    
    var currentIndex : Int?
    
    var didTapCheckBox : ((Int,Bool)->Void)?
    var didEditRemarks : ((Int,String)->Void)?
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var txtRemarks: UITextField!
    @IBAction func noBox(_ sender: Any) {
        yesCheckbox.checkState = .unchecked
        if let index = currentIndex {
            didTapCheckBox?(index,false)
        }
    }
    @IBAction func yesBox(_ sender: Any) {
        noCheckbox.checkState = .unchecked
        if let index = currentIndex {
            didTapCheckBox?(index,true)
        }
    }
    
    var checkListStruct : CheckListStruct? {
        didSet {
            if let model = checkListStruct {
                self.lblTitle.text = model.titleText
                self.txtRemarks.text = model.remark
                if model.isChecked {
                    yesCheckbox.checkState = .checked
                    noCheckbox.checkState = .unchecked
                } else {
                    yesCheckbox.checkState = .unchecked
                    noCheckbox.checkState = .checked
                }
            }
        }
    }
    
    func setupView() {
        yesCheckbox.boxType = .circle
        yesCheckbox.checkState = .unchecked
        yesCheckbox.markType = .checkmark
        yesCheckbox.secondaryCheckmarkTintColor = .white
        yesCheckbox.secondaryTintColor = .darkGray
        yesCheckbox.tintColor = .darkGray
        yesCheckbox.stateChangeAnimation = .fill
        yesCheckbox.checkmarkLineWidth = 1.5
        noCheckbox.boxType = .circle
        noCheckbox.checkState = .unchecked
        noCheckbox.markType = .checkmark
        noCheckbox.secondaryCheckmarkTintColor = .white
        noCheckbox.secondaryTintColor = .darkGray
        noCheckbox.stateChangeAnimation = .fill
        noCheckbox.tintColor = .darkGray
        self.txtRemarks.delegate = self
    }
}

extension CheckListCollectionViewCell : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            self.didEditRemarks?(currentIndex ?? 0,textField.text ?? "")
        }
        
    }
}
