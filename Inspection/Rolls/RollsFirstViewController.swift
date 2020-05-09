//
//  RollsFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData

class RollsFirstViewController: UIViewController {
    
    var rollsArray = [RollStruct]()
    var subTotalStruct = RollStruct(dict: ["title" : "Sub Total", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0])
    var point4Array = [Int]()
    var point3Array = [Int]()
    var point2Array = [Int]()
    var point1Array = [Int]()
    
    var editType : EditType = .UPDATE

    @IBOutlet weak var rollCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.editType == .UPDATE {
            self.fetchFromCoreData()
            self.fetchTotalFromCoreData()
        }
        rollCollectionView.dataSource = self
        rollCollectionView.delegate = self
        self.populateRollsArray()
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
        if editType == .UPDATE {
            _ = self.point1Array.enumerated().map({ (index, value) in
                self.rollsArray[index].onePoint = value
            })
            _ = self.point2Array.enumerated().map({ (index, value) in
                self.rollsArray[index].twoPoint = value
            })
            _ = self.point3Array.enumerated().map({ (index, value) in
                self.rollsArray[index].threePoint = value
            })
            _ = self.point4Array.enumerated().map({ (index, value) in
                self.rollsArray[index].fourPoint = value
            })
        }

    }
    func createCoreDataPointArray() {
        self.point1Array = []
        self.point2Array = []
        self.point3Array = []
        self.point4Array = []
        point1Array = self.rollsArray.map({ (rollStruct) -> Int in
            return rollStruct.onePoint
        })
        point2Array = self.rollsArray.map({ (rollStruct) -> Int in
            return rollStruct.twoPoint
        })
        point3Array = self.rollsArray.map({ (rollStruct) -> Int in
            return rollStruct.threePoint
        })
        point4Array = self.rollsArray.map({ (rollStruct) -> Int in
            return rollStruct.fourPoint
        })
    }
    
    func saveToCoreData(point4Value : Int, point3Value : Int, point2Value : Int, point1Value : Int){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let rollEntity =
            NSEntityDescription.entity(forEntityName: "RollFirst",
                                       in: managedContext)!
        let rollFirstVal = NSManagedObject(entity: rollEntity,
                                            insertInto: managedContext)
        
        // 3
       
        rollFirstVal.setValue(point1Value, forKeyPath: "points1")
        rollFirstVal.setValue(point2Value, forKeyPath: "points2")
        rollFirstVal.setValue(point3Value, forKeyPath: "points3")
        rollFirstVal.setValue(point4Value, forKeyPath: "points4")
        
    
        
        // 4
        do {
            try managedContext.save()
            //          basicFirst.append(basicFirstVal)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollFirst")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            self.point1Array = []
            self.point2Array = []
            self.point3Array = []
            self.point4Array = []
            for data in result {
                self.point1Array.append(data.value(forKey: "points1") as! Int)
                self.point2Array.append(data.value(forKey: "points2") as! Int)
                self.point3Array.append(data.value(forKey: "points3") as! Int)
                self.point4Array.append(data.value(forKey: "points4") as! Int)
            }
            print(point1Array)
            print(point2Array)
            print(point3Array)
            print(point4Array)
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    func saveTotalToCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let rollEntity =
            NSEntityDescription.entity(forEntityName: "RollFirstSubTotal",
                                       in: managedContext)!
        let rollFirstVal = NSManagedObject(entity: rollEntity,
                                            insertInto: managedContext)
        
        // 3
       
        rollFirstVal.setValue(subTotalStruct.onePoint, forKeyPath: "total1")
        rollFirstVal.setValue(subTotalStruct.twoPoint, forKeyPath: "total2")
        rollFirstVal.setValue(subTotalStruct.threePoint, forKeyPath: "total3")
        rollFirstVal.setValue(subTotalStruct.fourPoint, forKeyPath: "total4")
        
    
        
        // 4
        do {
            try managedContext.save()
            //          basicFirst.append(basicFirstVal)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchTotalFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollFirstSubTotal")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                self.subTotalStruct.onePoint = data.value(forKey: "total1") as! Int
                self.subTotalStruct.twoPoint = data.value(forKey: "total2") as! Int
                self.subTotalStruct.threePoint = data.value(forKey: "total3") as! Int
                self.subTotalStruct.fourPoint = data.value(forKey: "total4") as! Int
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func onTapNext(_ sender: UIButton) {
        if self.editType == .NEW {
            self.createCoreDataPointArray()
            for i in 0 ..< 20 {
                self.saveToCoreData(point4Value: point4Array[i], point3Value: point3Array[i], point2Value: point2Array[i], point1Value: point1Array[i])
                self.saveTotalToCoreData()
            }
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rollsThirdVC = storyBoard.instantiateViewController(withIdentifier: "rollThirdVC") as! RollsThirdViewController
        self.navigationController?.pushViewController(rollsThirdVC, animated: true)
        
    }
    
    @IBAction func onTapCamera(_ sender: Any) {
    }
    
    
    
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
