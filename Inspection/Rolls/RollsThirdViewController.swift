//
//  RollsThirdViewController.swift
//  Inspection
//
//  Created by Anpu S Anand on 06/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData

class RollsThirdViewController: UIViewController {
    @IBOutlet weak var rollLbl: UILabel!
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var fourPointsLbl: UILabel!
    @IBOutlet weak var threePointsLbl: UILabel!
    
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var twoPointsLbl: UILabel!
    @IBOutlet weak var onePointsLbl: UILabel!
    
    @IBOutlet weak var gradeLbl: UILabel!
    @IBOutlet weak var yardLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    
    
    
    @IBOutlet weak var mainView: UIView!
    
    var basicFirstModel : BasicFirstStruct?
    var basicSecondModel : BasicSecondStruct?
    var rollFirstModel : RollStruct?
    var isValid = [Bool]()
    var remarkText = ""
    var rollCount : Int = 0
    var basicStructApi = [BasicFirstStruct]()

    
    var editType : EditType = .NEW

    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        self.populatingPoints()
        self.validation()
        if editType == .UPDATE {
            self.fetchFromCoreData()
        }
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
        mainView.layer.cornerRadius = 15
    }
    
    func validation() {
        if let basicFirst = basicFirstModel {
            if let basicSecond = basicSecondModel {
                if (basicSecond.actualWeightGSM >= basicFirst.weightGSM - 5.0) && (basicSecond.actualWeightGSM <= basicFirst.weightGSM + 5.0) {
                    isValid.append(true)
                } else {
                    isValid.append(false)
                    remarkText = "Failed for Actual Weight"
                }
                if basicSecond.endToEnd == Quality.NO.rawValue {
                    isValid.append(false)
                    remarkText = remarkText == "" ? "Failed for End to End Shading" : "\(remarkText)\nFailed for End to End Shading"
                } else {
                    isValid.append(true)
                }
                if basicSecond.sideToSide == Quality.NO.rawValue {
                    isValid.append(false)
                    remarkText = remarkText == "" ? "Failed for Side to Side Shading" : "\(remarkText)\nFailed for Side to Side Shading"
                } else {
                    isValid.append(true)
                }
                if basicSecond.sideToCenter == Quality.NO.rawValue {
                    isValid.append(false)
                    remarkText = remarkText == "" ? "Failed for Side to Center Shading" : "\(remarkText)\nFailed for Side to Center Shading"
                } else {
                    isValid.append(true)
                }
            }
        }
        if isValid.contains(false) {
            self.resultLbl.text = "FAILED"
            self.txtView.text = self.remarkText
        } else {
            self.resultLbl.text = "PASS"
            self.txtView.text = ""
        }
        
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

        let rollVal = RollThird(context: managedContext)
        rollVal.inspectionNo = Int32(self.basicSecondModel?.inspectionNo ?? 0)
        rollVal.totalPoints = Int16(Int(self.totalPointsLbl.text ?? "") ?? 0)
        rollVal.status = self.resultLbl.text == "PASS" ? true : false
        rollVal.rollNo = Int32(self.basicSecondModel?.rollNumber ?? "") ?? 0
        rollVal.remarks = self.remarkText
        rollVal.grade = self.gradeLbl.text
        rollVal.yardValue = Double(self.yardLbl.text ?? "")!
        if let rollModel = self.rollFirstModel {
            var dict = [String:Any]()
            dict["1 point"] = rollModel.onePoint
            dict["2 point"] = rollModel.twoPoint
            dict["3 point"] = rollModel.threePoint
            dict["4 point"] = rollModel.fourPoint
            dict["title"] = rollModel.titleText
            dict["id"] = rollModel.id
            rollVal.pointsDict = dict as NSObject
        }
        

        //        rollFirstVal.setValue(point1Value, forKeyPath: "points1")
        //        rollFirstVal.setValue(point2Value, forKeyPath: "points2")
        //        rollFirstVal.setValue(point3Value, forKeyPath: "points3")
        //        rollFirstVal.setValue(point4Value, forKeyPath: "points4")



        // 4
        do {
            try managedContext.save()
            //          basicFirst.append(basicFirstVal)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
//
    func fetchFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }

        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext

        // 2

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollThird")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")

        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                if data.value(forKey: "inspectionNo") as? Int == self.basicSecondModel?.inspectionNo && data.value(forKey: "rollNo") as? Int == Int(self.basicSecondModel?.rollNumber ?? "") {
                    let pointDict = data.value(forKey: "pointsDict") as! [String:Any]
                    self.fourPointsLbl.text = "\(pointDict["4 point"] as! Int)"
                    self.threePointsLbl.text = "\(pointDict["3 point"] as! Int)"
                    self.twoPointsLbl.text = "\(pointDict["2 point"] as! Int)"
                    self.onePointsLbl.text = "\(pointDict["1 point"] as! Int)"
                    self.totalPointsLbl.text = "\(data.value(forKey: "totalPoints") as! Int)"
                    self.txtView.text = data.value(forKey: "remarks") as? String
                    self.yardLbl.text = "\(data.value(forKey: "yardValue") as! Double)"
                    self.gradeLbl.text = data.value(forKey: "grade") as? String
                }
            }

        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    
    func populatingPoints(){
        self.rollLbl.text = "\(self.basicSecondModel?.rollNumber ?? "")"
        if let rollModel = self.rollFirstModel {
            self.fourPointsLbl.text = "\(rollModel.fourPoint)"
            self.threePointsLbl.text = "\(rollModel.threePoint)"
            self.twoPointsLbl.text = "\(rollModel.twoPoint)"
            self.onePointsLbl.text = "\(rollModel.onePoint)"
            let total = rollModel.fourPoint + rollModel.threePoint + rollModel.twoPoint + rollModel.onePoint
            self.totalPointsLbl.text = "\(total)"
            self.yardLbl.text = "\(total*25)"
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
// MARK: - Button Action
    @IBAction func editPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicSecondVC = storyBoard.instantiateViewController(withIdentifier: "basicSecondVC") as! BasicSecondViewController
        basicSecondVC.editType = .UPDATE
        basicSecondVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(basicSecondVC, animated: true)
    }
    
    @IBAction func finisheRollPressed(_ sender: Any) {
        if self.editType == .NEW {
            self.saveToCoreData()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryFirstVC = storyBoard.instantiateViewController(withIdentifier: "summaryFirstVC") as! SummaryFirstViewController
        summaryFirstVC.basicFirstModel = self.basicFirstModel
        summaryFirstVC.editType = self.editType
        summaryFirstVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(summaryFirstVC, animated: true)
    }
    
    @IBAction func AddMorePressed(_ sender: Any) {
        if self.editType == .NEW {
            self.saveToCoreData()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicSecondVC = storyBoard.instantiateViewController(withIdentifier: "basicSecondVC") as! BasicSecondViewController
        self.rollCount = self.rollCount + 1
        basicSecondVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(basicSecondVC, animated: true)
    }
    @IBAction func bkPressed(_ sender: Any) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if self.editType == .NEW {
            self.saveToCoreData()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryFirstVC = storyBoard.instantiateViewController(withIdentifier: "summaryFirstVC") as! SummaryFirstViewController
        summaryFirstVC.basicFirstModel = self.basicFirstModel
        summaryFirstVC.editType = self.editType
        summaryFirstVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(summaryFirstVC, animated: true)

    }
    
}
