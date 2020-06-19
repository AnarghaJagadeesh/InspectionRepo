//
//  RollDetailsCollectionViewCell.swift
//  Inspection
//
//  Created by Beegins on 09/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class RollDetailsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var shrinkageText: UITextField!
    @IBOutlet weak var rollCollectionView: UICollectionView!
    @IBOutlet weak var rollNumberText: UITextField!
    @IBOutlet weak var torqueText: UITextField!
    
    var heightConst : HeightConst?
    var didTapExpand : ((HeightConst)->Void)?
    var didEditContent : ((SummaryFirstStruct,Int,Bool)->Void)?
    
    var rollsArray : [SummaryFirstStruct]? {
        didSet {
            self.rollCollectionView.dataSource = self
            self.rollCollectionView.delegate = self
            self.rollCollectionView.reloadData()
        }
    }
    
    @IBAction func onTapExpand(_ sender: UIButton) {
        if heightConst?.isMax == false {
            heightConst?.isMax.toggle()
            if let const = self.heightConst {
                didTapExpand?(const)
            }
        }
    }
    @IBAction func onTapAdd(_ sender: UIButton) {
        if heightConst?.isMax == true {
            heightConst?.isMax.toggle()
            if let const = self.heightConst {
                didTapExpand?(const)
            }
            var summaryDict = [String : Any]()
            summaryDict["rollNumber"] = self.rollNumberText.text
            summaryDict["shrinkage"] = Double(self.shrinkageText.text ?? "")
            summaryDict["torque"] = Double(self.torqueText.text ?? "")
            var selectedIndex = 0
            var isPresent : Bool = false
            _ = rollsArray?.enumerated().map({ (index, summaryModel) in
                if summaryModel.rollNumber == self.rollNumberText.text {
                    selectedIndex = index
                    isPresent = true
                }
            })
            didEditContent?(SummaryFirstStruct(dict: summaryDict),selectedIndex,isPresent)
        }
    }
}

extension RollDetailsCollectionViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rollsArray?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "detailCell", for: indexPath) as! SummaryRollDetailsCollectionViewCell
        if indexPath.row == 0 {
            cell.rollNumberTitle.isHidden = false
            cell.shrinkageTitle.isHidden = false
            cell.torqueTitle.isHidden = false
        } else {
            cell.rollNumberTitle.isHidden = true
            cell.shrinkageTitle.isHidden = true
            cell.torqueTitle.isHidden = true
        }
        if let model = rollsArray?[indexPath.item] {
            cell.lblRollNumber.text = model.rollNumber
            cell.lblShrinkage.text = "\(model.shrinkage)"
            cell.lblTorque.text = "\(model.torque)"
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 316, height: 159)
        } else {
            return CGSize(width: 90, height: 159)
        }
    }
    
}
