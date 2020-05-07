//
//  RollsFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class RollsFirstViewController: UIViewController {
    
    var rollsArray = [RollStruct]()
    var subTotalStruct = RollStruct(dict: ["title" : "Sub Total", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0])

    @IBOutlet weak var rollCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateRollsArray()
        rollCollectionView.dataSource = self
        rollCollectionView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func populateRollsArray() {
        rollsArray = []
        rollsArray.append(RollStruct(dict: ["title" : "PO Number", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Inspection Check List", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Packing List Available?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Inspect roll # Qty Match to PL?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "SNS face Stamp on Both End?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Roll Marking?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Shipping Mark Mentioned on top of the Bale?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Shrinkage SMPL Taken for every 3000 Yds?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Shrinkage / Torque Measured yourself after washing?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Width / GSM Checked by yourself?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Skewing / Bowing Checked By yourself?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Color checked With Appd Sample?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Checked Color Shading Btw Head end and Tail end?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Checked Shading in inspected rolls?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Handfeel Checked against Samples?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Solid White - Part Inspection on Table?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Length Cross Checked on Table?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Roll Shortage Observed?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Any marks Other Than SNS Face Stamp?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
        rollsArray.append(RollStruct(dict: ["title" : "Did Inspection report Signed by Mill?", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0]))
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RollsFirstViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rollsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rollCell", for: indexPath) as! RollsFirstCollectionViewCell
        cell.currentIndex = indexPath.item
        cell.rollModel = self.rollsArray[indexPath.item]
        cell.didTapMinusPlus = { [weak self] (isPlus, pointType, value, index) in
            if isPlus {
                switch pointType {
                case .ONEPOINT:
                    self?.subTotalStruct.onePoint = (self?.subTotalStruct.onePoint ?? 0) + value
                    self?.rollsArray[index].onePoint = value
                case .TWOPOINT:
                    self?.subTotalStruct.twoPoint = (self?.subTotalStruct.twoPoint ?? 0) + value
                    self?.rollsArray[index].twoPoint = value
                case .THREEPOINT:
                    self?.subTotalStruct.threePoint = (self?.subTotalStruct.threePoint ?? 0) + value
                    self?.rollsArray[index].threePoint = value
                default:
                    self?.subTotalStruct.fourPoint = (self?.subTotalStruct.fourPoint ?? 0) + value
                    self?.rollsArray[index].fourPoint = value
                }
            } else {
                switch pointType {
                case .ONEPOINT:
                    self?.subTotalStruct.onePoint = (self?.subTotalStruct.onePoint ?? 0) - value
                    self?.rollsArray[index].onePoint = value
                case .TWOPOINT:
                    self?.subTotalStruct.twoPoint = (self?.subTotalStruct.twoPoint ?? 0) - value
                    self?.rollsArray[index].twoPoint = value
                case .THREEPOINT:
                    self?.subTotalStruct.threePoint = (self?.subTotalStruct.threePoint ?? 0) - value
                    self?.rollsArray[index].threePoint = value
                default:
                    self?.subTotalStruct.fourPoint = (self?.subTotalStruct.fourPoint ?? 0) - value
                    self?.rollsArray[index].fourPoint = value
                }
            }
            self?.rollCollectionView.reloadData()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return indexPath.item == 0 ? CGSize(width: collectionView.frame.width, height: 75) : CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "roolsFooterCell", for: indexPath) as? RollsFirstFooterCell {
            footerView.rollModel = self.subTotalStruct
            return footerView
        }
        return UICollectionViewCell()
    }
    
}
