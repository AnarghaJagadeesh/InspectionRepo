//
//  ChecklistViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 20/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import M13Checkbox
import CoreData
import IHProgressHUD

class ChecklistViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextView!
    
    var checkList = [CheckListStruct]()
    let viewModel = CheckListViewModel()
    var summaryStruct : SummaryDataStruct?
    var basicFirstModel : BasicFirstStruct?
    var basicStructApi = [BasicFirstStruct]()

    
    var editType : EditType = .NEW
    var statusArray = [Bool]()
    var count = 0
    var rollCount = 0


    
    @IBOutlet weak var checkListCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel.rootVC = self
        if editType == .UPDATE {
            self.fetchFromCoreData()
        }
        self.populateArray()
        self.checkListCollectionView.dataSource = self
        self.checkListCollectionView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func populateArray(){
        checkList.append(CheckListStruct(title : "Packing List Available?", remark: ""))
        checkList.append(CheckListStruct(title : "Inspect roll # Qty Match to PL?", remark: ""))
        checkList.append(CheckListStruct(title : "SNS face Stamp on Both End?", remark: ""))
        checkList.append(CheckListStruct(title : "Roll Marking?", remark: ""))
        checkList.append(CheckListStruct(title : "Shipping Mark Mentioned on top of the Bale?", remark: ""))
        checkList.append(CheckListStruct(title : "Shrinkage SMPL Taken for every 3000 Yds?", remark: ""))
        checkList.append(CheckListStruct(title : "Shrinkage / Torque Measured yourself after washing?", remark: ""))
        checkList.append(CheckListStruct(title : "Width / GSM Checked by yourself?", remark: ""))
        checkList.append(CheckListStruct(title : "Skewing / Bowing Checked By yourself?", remark: ""))
        checkList.append(CheckListStruct(title : "Color checked With Appd Sample?", remark: ""))
        checkList.append(CheckListStruct(title : "Checked Color Shading Btw Head end and Tail end?", remark: ""))
        checkList.append(CheckListStruct(title : "Checked Shading in inspected rolls?", remark: ""))
        checkList.append(CheckListStruct(title : "Handfeel Checked against Samples?", remark: ""))
        checkList.append(CheckListStruct(title : "Solid White - Part Inspection on Table?", remark: ""))
        checkList.append(CheckListStruct(title : "Length Cross Checked on Table?", remark: ""))
        checkList.append(CheckListStruct(title : "Roll Shortage Observed?", remark: ""))
        checkList.append(CheckListStruct(title : "Any marks Other Than SNS Face Stamp?", remark: ""))
        checkList.append(CheckListStruct(title : "Did Inspection report Signed by Mill?", remark: ""))
        if editType == .UPDATE {
            _ = statusArray.enumerated().map({ (index, value) in
                self.checkList[index].isChecked = value
            })
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
    @IBAction func bkPressed(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
    
    @IBAction func saveBtnPressed(_ sender: Any) {
        //         Helper.showAlert(message: "Saved successfully")
        print(checkList)
        if editType == .NEW {
            if self.commentTextField.text == "" {
                Helper.showAlert(message: "Enter comments")
                return
            }
            self.saveToCoreData()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
        self.navigationController?.pushViewController(homeVC, animated: true)
        
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
        
        let checkDictArray = self.checkList.map { (model) -> [String : Any] in
            var dict = [String : Any]()
            dict["title"] = model.titleText
            dict["remarks"] = model.remark
            dict["status"] = model.isChecked
            return dict
        }
        let checkDict = CheckList(context: managedContext)
        checkDict.remarkDict = checkDictArray as NSObject
        checkDict.comments = self.commentTextField.text
        checkDict.inspectionNo = Int32(UserDefaults.standard.value(forKey: "inspectionNo") as! Int)
        
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CheckList")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        self.statusArray = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            self.checkList = []
            for data in result {
                if data.value(forKey: "inspectionNo") as? Int == self.basicFirstModel?.inspectionNo {
                    let dictArray = data.value(forKey: "remarkDict") as! [[String:Any]]
                    self.checkList = dictArray.map({ (model) -> CheckListStruct in
                        return CheckListStruct(dict: model)
                    })
                    self.commentTextField.text = data.value(forKey: "comments") as? String
                }
            }
            self.checkListCollectionView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    @IBAction func onTapSubmit(_ sender: UIButton) {
        if editType == .NEW {
            if self.commentTextField.text == "" {
                Helper.showAlert(message: "Enter Comments")
                return
            }
            self.saveToCoreData()
        }
        
        self.viewModel.fetchBasicFromCoreData()
        self.viewModel.fetchRollFromCoreData()
        self.viewModel.fetchRollPointsFromCoreData()
        self.viewModel.fetchRollSummaryFromCoreData()
        self.viewModel.fetchRollImageFromCoreData()
        self.viewModel.fetchSummaryFromCoreData()
        self.viewModel.fetchChecklistFromCoreData()
        print("Basic:\(self.viewModel.basicFirstModel)")
        print("Roll:\(self.viewModel.basicSecondModel)")
        print("Roll points :\(self.viewModel.rollModel)")
        print("Roll Images : \(self.viewModel.rollImagesModel)")
        print("Roll Summary : \(self.viewModel.rollSummaryModel)")
        print("Summary : \(self.viewModel.summaryModel)")
        print("Checklist : \(self.viewModel.checkListModel)")
        IHProgressHUD.show()
        count = 0
        self.apiCall()

//            let basicSecondModel = self.viewModel.basicSecondModel.filter{$0.inspectionNo == basicModel.inspectionNo}
//            let rollModel = self.viewModel.rollModel.filter{$0.inspectionNo == basicModel.inspectionNo}
//            let rollSummaryModel = self.viewModel.rollSummaryModel.filter{$0.inspectionNo == basicModel.inspectionNo}
//            let summaryModel = self.viewModel.summaryModel.filter{$0.inspectionNo == basicModel.inspectionNo}
//            let checkListModel = self.viewModel.summaryModel.filter{$0.inspectionNo == basicModel.inspectionNo}
//            if basicSecondModel.count > 0 && rollModel.count > 0 && rollSummaryModel.count > 0 && summaryModel.count > 0 && checkListModel.count > 0 {
//                self.viewModel.performAddInspection(selInspectionNo: basicModel.inspectionNo) { responseData in
//                    if let status = responseData["status"] as? String {
//                        if status == StatusCode.success.rawValue {
//                            DispatchQueue.main.async {
//                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                                let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
//                                self.navigationController?.pushViewController(homeVC, animated: true)
//                                Helper.showAlert(message: "Inspections added successfully")
//
//                            }
//                        } else {
//                            Helper.showAlert(message: "\(responseData["message"] as? String ?? "")")
//                        }
//                    }  else {
//                        Helper.showAlert(message: "Oops! Something went wrong. Please try again")
//                    }
//                    IHProgressHUD.dismiss()
//                }
//            }
    }
    
    func apiCall(){
        if count < self.viewModel.basicFirstModel.count {
            let selInspectionNo = self.viewModel.basicFirstModel[count].inspectionNo
            let basicSecondModel = self.viewModel.basicSecondModel.filter{$0.inspectionNo == selInspectionNo}
            let rollModel = self.viewModel.rollModel.filter{$0.inspectionNo == selInspectionNo}
            let rollSummaryModel = self.viewModel.rollSummaryModel.filter{$0.inspectionNo == selInspectionNo}
            let summaryModel = self.viewModel.summaryModel.filter{$0.inspectionNo == selInspectionNo}
            let checkListModel = self.viewModel.summaryModel.filter{$0.inspectionNo == selInspectionNo}
            if basicSecondModel.count > 0 && rollModel.count > 0 && rollSummaryModel.count > 0 && summaryModel.count > 0 && checkListModel.count > 0 {
                let rollImagesModel = self.viewModel.rollImagesModel.filter{$0.inspectionNo == selInspectionNo}
                if rollImagesModel.count > 0 {
                    self.viewModel.imageDataArray = self.viewModel.commpressImage(inspectionNo: self.viewModel.basicFirstModel[count].inspectionNo)
                    self.rollCount = 0
                    self.viewModel.imageResponse = []
                    if self.viewModel.imageDataArray[rollCount].count > 0 {
                        self.imageApiCall(selInspectionNo: selInspectionNo)
                    } else {
                        self.viewModel.performAddInspection(selInspectionNo: selInspectionNo) { responseData in
                            if let status = responseData["status"] as? String {
                                if status == StatusCode.success.rawValue {
                                    self.count += 1
                                    self.apiCall()
                                } else {
                                    Helper.showAlert(message: "\(responseData["message"] as? String ?? "")")
                                }
                            }  else {
                                Helper.showAlert(message: "Oops! Something went wrong. Please try again")
                            }
                            IHProgressHUD.dismiss()
                        }
                    }
                } else {
                    self.viewModel.performAddInspection(selInspectionNo: selInspectionNo) { responseData in
                        if let status = responseData["status"] as? String {
                            if status == StatusCode.success.rawValue {
                                self.count += 1
                                self.apiCall()
                            } else {
                                Helper.showAlert(message: "\(responseData["message"] as? String ?? "")")
                            }
                        }  else {
                            Helper.showAlert(message: "Oops! Something went wrong. Please try again")
                        }
                        IHProgressHUD.dismiss()
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
                homeVC.basicStructApi = self.basicStructApi
                self.navigationController?.pushViewController(homeVC, animated: true)
                Helper.showAlert(message: "Inspections added successfully")
                
            }
        }
    }
    
    func imageApiCall(selInspectionNo : Int) {
        let rollModel = self.viewModel.rollModel.filter{$0.inspectionNo == selInspectionNo}
        if rollCount < self.viewModel.imageDataArray.count {
            self.viewModel.performImageApi(rollNo: rollModel[rollCount].rollNo, dataArray: self.viewModel.imageDataArray[rollCount]) { (imgResponse) in
                self.rollCount += 1
                if self.viewModel.imageDataArray[self.rollCount].count > 0 {
                    self.imageApiCall(selInspectionNo: selInspectionNo)
                }
            }
        } else {
            self.viewModel.performAddInspection(selInspectionNo: selInspectionNo) { responseData in
                if let status = responseData["status"] as? String {
                    if status == StatusCode.success.rawValue {
                        self.count += 1
                        self.apiCall()
                    } else {
                        Helper.showAlert(message: "\(responseData["message"] as? String ?? "")")
                    }
                }  else {
                    Helper.showAlert(message: "Oops! Something went wrong. Please try again")
                }
                IHProgressHUD.dismiss()
            }
            
        }
    }

}

extension ChecklistViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.checkList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "checkListCell", for: indexPath) as! CheckListCollectionViewCell
        cell.setupView()
        cell.currentIndex = indexPath.item
        cell.checkListStruct = self.checkList[indexPath.item]
        cell.didTapCheckBox = { [weak self] (index,status) in
            self?.checkList[index].isChecked = status
            self?.checkListCollectionView.reloadData()
        }
        cell.didEditRemarks = { [weak self] (index, value) in
            self?.checkList[index].remark = value
            self?.checkListCollectionView.reloadData()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 130)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
