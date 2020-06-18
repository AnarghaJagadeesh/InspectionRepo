//
//  SummaryBottomCollectionViewCell.swift
//  Inspection
//
//  Created by Anpu S Anand on 09/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import M13Checkbox

class SummaryBottomCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var yesBtn: M13Checkbox!
    
    
    @IBOutlet weak var noBtn: M13Checkbox!
    @IBOutlet weak var cmtTxtView: UITextView!
    var didEnterComment : ((String)->Void)?
    var  didTapFactoryAccepted : ((Bool)->Void)?
    
    var isAccepted : Bool? {
        didSet {
            if let status = isAccepted {
                if status {
                    yesBtn.checkState = .checked
                    noBtn.checkState = .unchecked
                }  else {
                    yesBtn.checkState = .unchecked
                    noBtn.checkState = .checked
                }
            }
        }
    }
    @IBAction func onTapNoBox(_ sender: M13Checkbox) {
        yesBtn.checkState = .unchecked
        self.didTapFactoryAccepted?(false)
    }
    
    @IBAction func onTapYesBox(_ sender: M13Checkbox) {
        noBtn.checkState = .unchecked
        self.didTapFactoryAccepted?(true)
    }
    func initialSetup(){
        cmtTxtView.layer.borderColor = UIColor.lightGray.cgColor
        cmtTxtView.layer.borderWidth = 0.5
        yesBtn.boxType = .circle
        yesBtn.checkState = .unchecked
        yesBtn.markType = .checkmark
        yesBtn.secondaryCheckmarkTintColor = .white
        yesBtn.secondaryTintColor = .darkGray
        yesBtn.tintColor = .darkGray
        yesBtn.stateChangeAnimation = .fill
        yesBtn.checkmarkLineWidth = 1.5
        noBtn.boxType = .circle
        noBtn.checkState = .unchecked
        noBtn.markType = .checkmark
        noBtn.secondaryCheckmarkTintColor = .white
        noBtn.secondaryTintColor = .darkGray
        noBtn.stateChangeAnimation = .fill
        noBtn.tintColor = .darkGray
    }
}

extension SummaryBottomCollectionViewCell : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.didEnterComment?(textView.text ?? "")
    }
}
