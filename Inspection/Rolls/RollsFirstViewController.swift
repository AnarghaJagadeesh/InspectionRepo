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
    var subTotalStruct = RollStruct(dict: ["title" : "Sub Total", "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0, "id" : 0])
    var point4Array = [Int]()
    var point3Array = [Int]()
    var point2Array = [Int]()
    var point1Array = [Int]()
    var basicStructApi = [BasicFirstStruct]()

    var pickedImages = [UIImage]()
    
    var editType : EditType = .NEW
    
    
    var basicFirstModel : BasicFirstStruct?
    var basicSecondModel : BasicSecondStruct?
    var rollCount : Int = 0

    @IBOutlet weak var rollCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.editType == .UPDATE {
            self.fetchFromCoreData()
            self.fetchTotalFromCoreData()
        }
        self.populateRollsArray()
        rollCollectionView.dataSource = self
        rollCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func populateRollsArray() {
        rollsArray = []
        _ = AppSettings.getRollList().map({ (model) in
            rollsArray.append(RollStruct(dict: ["title" : model.title, "1 point" : 0, "2 point" : 0, "3 point" : 0, "4 point" : 0, "id" : Int(model.id)]))
        })
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
    
    func saveToCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
//        let rollFirstVal = NSManagedObject(entity: rollEntity,
//                                            insertInto: managedContext)
        
        // 3
        let rankArray = self.rollsArray.map { (rollModel) -> [String:Any] in
            var dict = [String:Any]()
            dict["id"] = rollModel.id
            dict["title"] = rollModel.titleText
            dict["1 point"] = rollModel.onePoint
            dict["2 point"] = rollModel.twoPoint
            dict["3 point"] = rollModel.threePoint
            dict["4 point"] = rollModel.fourPoint
            return dict
        }
        let rollFirstVal = RollFirst(context: managedContext)
        rollFirstVal.rankDict = rankArray as NSObject
        rollFirstVal.rollNo = Int32(Int(self.basicSecondModel?.rollNumber ?? "") ?? 0)
        rollFirstVal.inspectionNo = Int32(UserDefaults.standard.value(forKey: "inspectionNo") as! Int)
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
            self.rollsArray = []
            for data in result {
                let dataArray = (data.value(forKey: "rankDict")) as! [[String:Any]]
                self.rollsArray = dataArray.map({ (dict) -> RollStruct in
                    return RollStruct(dict: dict)
                })
            }
            
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
        rollFirstVal.setValue(UserDefaults.standard.value(forKey: "inspectionNo") as! Int, forKey: "inspectionNo")
        rollFirstVal.setValue(Int32(Int(self.basicSecondModel?.rollNumber ?? "") ?? 0), forKey: "rollNo")
    
        
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
    func updateTotalToCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollFirstSubTotal")
        fetchRequest.predicate = NSPredicate(format: "inspectionNo = %i", basicSecondModel?.inspectionNo ?? 0)
        
        // 3
        do {
            let rollsDictArray = try managedContext.fetch(fetchRequest)
            let objectToUpdate =  rollsDictArray.last
            objectToUpdate?.setValue(subTotalStruct.onePoint, forKey: "total1")
            objectToUpdate?.setValue(subTotalStruct.twoPoint, forKey: "total2")
            objectToUpdate?.setValue(subTotalStruct.threePoint, forKey: "total3")
            objectToUpdate?.setValue(subTotalStruct.fourPoint, forKey: "total4")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch {
            
        }
        
        // 4
    }
    func updateToCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollFirst")
        fetchRequest.predicate = NSPredicate(format: "inspectionNo = %i", basicSecondModel?.inspectionNo ?? 0)
        
        // 3
        do {
            let rollsDictArray = try managedContext.fetch(fetchRequest)
            let objectToUpdate =  rollsDictArray.last
            let rankArray = self.rollsArray.map { (rollModel) -> [String:Any] in
                var dict = [String:Any]()
                dict["id"] = rollModel.id
                dict["title"] = rollModel.titleText
                dict["1 point"] = rollModel.onePoint
                dict["2 point"] = rollModel.twoPoint
                dict["3 point"] = rollModel.threePoint
                dict["4 point"] = rollModel.fourPoint
                return dict
            }
            objectToUpdate?.setValue(rankArray, forKey: "rankDict")
            objectToUpdate?.setValue(Int32(Int(self.basicSecondModel?.rollNumber ?? "") ?? 0), forKey: "rollNo")
            objectToUpdate?.setValue(Int32(UserDefaults.standard.value(forKey: "inspectionNo") as! Int), forKey: "inspectionNo")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch {
            
        }
        
        // 4
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @IBAction func bkPressed(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    @IBAction func onTapNext(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rollsSecondVC = storyBoard.instantiateViewController(withIdentifier: "rollsSecondVC") as! RollsSecondViewController

        if self.editType == .NEW {
            self.createCoreDataPointArray()
//            for i in 0 ..< 20 {
//                self.saveToCoreData(point4Value: point4Array[i], point3Value: point3Array[i], point2Value: point2Array[i], point1Value: point1Array[i])
//            }
            self.saveToCoreData()
            self.saveTotalToCoreData()
        } else {
            self.createCoreDataPointArray()
            self.updateToCoreData()
            self.updateTotalToCoreData()
            rollsSecondVC.editType = .UPDATE
        }
        rollsSecondVC.basicFirstModel = self.basicFirstModel
        rollsSecondVC.basicSecondModel = self.basicSecondModel
        rollsSecondVC.rollFirstModel = self.subTotalStruct
        rollsSecondVC.pickedImages = self.pickedImages
        rollsSecondVC.rollCount = rollCount
        rollsSecondVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(rollsSecondVC, animated: true)

        
    }
    
    @IBAction func onTapCamera(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = .camera
        present(picker, animated: true)
    }
}

extension RollsFirstViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let userPickedImage = info[.originalImage] as? UIImage else { return }
        self.pickedImages.append(userPickedImage)
        picker.dismiss(animated: true)
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
                    self?.subTotalStruct.onePoint = (self?.subTotalStruct.onePoint ?? 0) + 1
                    self?.rollsArray[index].onePoint = value
                case .TWOPOINT:
                    self?.subTotalStruct.twoPoint = (self?.subTotalStruct.twoPoint ?? 0) + 2
                    self?.rollsArray[index].twoPoint = value
                case .THREEPOINT:
                    self?.subTotalStruct.threePoint = (self?.subTotalStruct.threePoint ?? 0) + 3
                    self?.rollsArray[index].threePoint = value
                default:
                    self?.subTotalStruct.fourPoint = (self?.subTotalStruct.fourPoint ?? 0) + 4
                    self?.rollsArray[index].fourPoint = value
                }
            } else {
                switch pointType {
                case .ONEPOINT:
                    self?.subTotalStruct.onePoint = self?.subTotalStruct.onePoint ?? 0 != 0 ? (self?.subTotalStruct.onePoint ?? 0) - 1 : 0
                    self?.rollsArray[index].onePoint = value
                case .TWOPOINT:
                    self?.subTotalStruct.twoPoint = self?.subTotalStruct.twoPoint ?? 0 != 0 ? (self?.subTotalStruct.twoPoint ?? 0) - 2 : 0
                    self?.rollsArray[index].twoPoint = value
                case .THREEPOINT:
                    self?.subTotalStruct.threePoint = (self?.subTotalStruct.threePoint ?? 0) - 3
                    self?.rollsArray[index].threePoint = value
                default:
                    self?.subTotalStruct.fourPoint = (self?.subTotalStruct.fourPoint ?? 0) - 4
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
