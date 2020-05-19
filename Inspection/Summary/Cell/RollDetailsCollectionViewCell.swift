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
    
    var rollsArray : [SummaryFirstStruct]? {
        didSet {
            self.rollCollectionView.dataSource = self
            self.rollCollectionView.delegate = self
            self.rollCollectionView.reloadData()
        }
    }
    
    @IBAction func onTapAdd(_ sender: UIButton) {
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 0 {
            return CGSize(width: 316, height: 159)
        } else {
            return CGSize(width: 100, height: 159)
        }
    }
    
}
