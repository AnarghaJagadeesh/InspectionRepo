//
//  BasicFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 07/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData
import iOSDropDown

enum EditType {
    case UPDATE
    case NEW
}

class BasicFirstViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var txtFabricCategory: DropDown!
    @IBOutlet weak var txtPO: UITextField!
    @IBOutlet weak var txtContent: UITextField!
    @IBOutlet weak var txtConstruction: UITextField!
    @IBOutlet weak var txtPOCutWidth: UITextField!
    @IBOutlet weak var txtFactoryName: UITextField!
    @IBOutlet weak var dropDownFabricType: DropDown!
    @IBOutlet weak var txtOrderQty: UITextField!
    @IBOutlet weak var txtTotalQtyOffered: UITextField!
    @IBOutlet weak var txtWeightGSM: UITextField!
    @IBOutlet weak var txtColorName: UITextField!
    @IBOutlet weak var txtFinish: UITextField!
    @IBOutlet weak var dropDownName: DropDown!
    @IBOutlet weak var addReporterMainView: UIView!
    
    @IBAction func btnAddReporterView(_ sender: UIButton) {
        self.addReporterMainView.isHidden = false
    }
    @IBOutlet weak var txtAddReporter: UITextField!
    @IBAction func btnAddReporter(_ sender: Any) {
        if self.txtAddReporter.text != "" {
            self.saveAddReporterToCoreData()
            self.addReporterMainView.isHidden = true
        } else {
            Helper.showAlert(message:"Enter Reporter Name")
        }
    }
    
    @IBAction func btnCloseReporter(_ sender: UIButton) {
        self.addReporterMainView.isHidden = true
    }
    //    var basicFirst: [NSManagedObject] = []
    var basicStruct : BasicFirstStruct?
    var basicDict = [String:Any]()
    var editType : EditType = .UPDATE
    var fabricCategory = [String]()
    var fabricTypeArray = [String]()
    var reporterList = [String]()
    var basicStructApi = [BasicFirstStruct]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addReporterMainView.isHidden = true
        _ = AppSettings.getFabricType().map({ (model) in
            self.fabricTypeArray.append(model.title)
        })
        _ = AppSettings.getFabricCategory().map({ (model) in
            self.fabricCategory.append(model.title)
        })
        basicDict["fabricCategory"] = fabricCategory[0]
        basicDict["fabricType"] = fabricTypeArray[0]
        dropDownFabricType.optionArray = self.fabricTypeArray
        txtFabricCategory.optionArray = self.fabricCategory
        self.fetchAddReporterFromCoreData()
        dropDownName.optionArray = self.reporterList.count > 0 ? self.reporterList : []
        self.configureTextField()
        //        self.saveToCoreData()
        if editType == .UPDATE {
            self.fetchFromCoreData()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func configureTextField(){
        self.txtPO.delegate = self
        self.txtContent.delegate = self
        self.txtConstruction.delegate = self
        self.txtPOCutWidth.delegate = self
        self.txtFactoryName.delegate = self
        self.txtOrderQty.delegate = self
        self.txtTotalQtyOffered.delegate = self
        self.txtWeightGSM.delegate = self
        self.txtColorName.delegate = self
        self.txtFinish.delegate = self
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
        let basicEntity =
            NSEntityDescription.entity(forEntityName: "BasicFirst",
                                       in: managedContext)!
        let basicFirstVal = NSManagedObject(entity: basicEntity,
                                            insertInto: managedContext)
        
        // 3
        if let model = basicStruct {
            basicFirstVal.setValue(model.fabricCategory, forKeyPath: "fabricCategory")
            basicFirstVal.setValue(model.PONo, forKey: "poNo")
            basicFirstVal.setValue(model.content, forKeyPath: "content")
            basicFirstVal.setValue(model.construction, forKeyPath: "construction")
            basicFirstVal.setValue(model.POCutWidth, forKeyPath: "poCutWidth")
            basicFirstVal.setValue(model.factoryName, forKeyPath: "factoryName")
            basicFirstVal.setValue(model.fabricType, forKeyPath: "fabricType")
            basicFirstVal.setValue(model.orderQty, forKeyPath: "orderQty")
            basicFirstVal.setValue(model.totalQtyOffered, forKeyPath: "totalQtyOffered")
            basicFirstVal.setValue(model.weightGSM, forKeyPath: "weightGSM")
            basicFirstVal.setValue(model.colorName, forKeyPath: "colorName")
            basicFirstVal.setValue(model.finish, forKeyPath: "finish")
            basicFirstVal.setValue(model.reportToName, forKeyPath: "reportToName")
            basicFirstVal.setValue(model.inspectionNo, forKey: "inspectionNo")
            basicFirstVal.setValue(model.date, forKey: "date")
        }
        
        
        // 4
        do {
            try managedContext.save()
            //          basicFirst.append(basicFirstVal)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func dateToDayMonthYearDate(rawDate: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone =  TimeZone(abbreviation: "UTC")
        var calendar = Calendar.init(identifier: .gregorian)
        //cal.timeZone = TimeZone(abbreviation: "GMT+5:30")!
        //        cal.timeZone = TimeZone.current
        calendar.timeZone = TimeZone(abbreviation: "UTC")!
        
        var newDate = ""
        // Formate
        dateFormatter.dateFormat = "MMM \'\'yy"
        newDate = dateFormatter.string(from: rawDate)
        return newDate
    }
    func saveAddReporterToCoreData(){
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
        
        let reporterDict = ReporterList(context: managedContext)
        reporterDict.reporterName = self.txtAddReporter.text
        
        // 4
        do {
            try managedContext.save()
            //          basicFirst.append(basicFirstVal)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchAddReporterFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ReporterList")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            self.reporterList = []
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                self.reporterList.append(data.value(forKey: "reporterName") as! String)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BasicFirst")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                basicDict["fabricCategory"] = data.value(forKey: "fabricCategory") as! String
                basicDict["poNo"] = data.value(forKey: "poNo") as! String
                basicDict["content"] = data.value(forKey: "content") as! String
                basicDict["construction"] = data.value(forKey: "construction") as! String
                basicDict["poCutWidth"] = data.value(forKey: "poCutWidth") as! Float
                basicDict["fabricType"] = data.value(forKey: "fabricType") as! String
                basicDict["factoryName"] = data.value(forKey: "factoryName") as! String
                basicDict["orderQty"] = data.value(forKey: "orderQty") as! Int
                basicDict["totalQtyOffered"] = data.value(forKey: "totalQtyOffered") as! Int
                basicDict["weightGSM"] = data.value(forKey: "weightGSM") as! Float
                basicDict["colorName"] = data.value(forKey: "colorName") as! String
                basicDict["finish"] = data.value(forKey: "finish") as! String
                basicDict["reportToName"] = data.value(forKey: "reportToName") as! String
                basicDict["inspectionNo"] = data.value(forKey: "inspectionNo") as! Int
                basicDict["date"] = data.value(forKey: "date") as! String
                self.basicStruct = BasicFirstStruct(dict: basicDict)
                
                print(data.value(forKey: "fabricCategory") as! String)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if let model = basicStruct {
            self.txtPO.text = "\(model.PONo)"
            self.txtContent.text = "\(model.content)"
            self.txtConstruction.text = "\(model.construction)"
            self.txtPOCutWidth.text = "\(model.POCutWidth)"
            self.txtFactoryName.text = "\(model.factoryName)"
            self.txtOrderQty.text = "\(model.orderQty)"
            self.txtTotalQtyOffered.text = "\(model.totalQtyOffered)"
            self.txtWeightGSM.text = "\(model.weightGSM)"
            self.txtColorName.text = "\(model.colorName)"
            self.txtFinish.text = "\(model.finish)"
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
    @IBAction func bkPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapNext(_ sender: UIButton) {
        if  self.txtPO.text == "" || self.txtContent.text == "" || self.txtConstruction.text ==  "" || self.txtPOCutWidth.text == "" || self.txtFactoryName.text == "" || self.txtOrderQty.text == "" || self.txtTotalQtyOffered.text == "" || self.txtWeightGSM.text == "" || self.txtColorName.text == "" || self.txtFinish.text  == ""{
            Helper.showAlert(message: "Please fill all the fields")
        }
        else{
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let basicSecondVC = storyBoard.instantiateViewController(withIdentifier: "basicSecondVC") as! BasicSecondViewController
            if editType == .NEW {
                if fabricCategory.count > 0 {
                    if txtFabricCategory.selectedIndex == nil {
                        basicDict["fabricCategory"] = fabricCategory[0]
                    } else {
                        basicDict["fabricCategory"] = fabricCategory[txtFabricCategory.selectedIndex ?? 0]
                    }
                }
                if fabricTypeArray.count > 0 {
                    if dropDownFabricType.selectedIndex == nil {
                        basicDict["fabricType"] = fabricTypeArray[0]
                    } else {
                        basicDict["fabricType"] = fabricTypeArray[dropDownFabricType.selectedIndex ?? 0]
                    }

                }
                
                basicDict["reportToName"] = "Name Test"
                basicDict["date"] = self.dateToDayMonthYearDate(rawDate: Date())
                
                let inspectionNo = UserDefaults.standard.value(forKey: "inspectionNo") as! Int
                basicDict["inspectionNo"] = inspectionNo
                self.basicStruct = BasicFirstStruct(dict: basicDict)
                self.saveToCoreData()
            } else {
                basicSecondVC.editType = .UPDATE
            }
            
            basicSecondVC.basicFirstStruct = self.basicStruct
            basicSecondVC.basicStructApi = self.basicStructApi
            self.navigationController?.pushViewController(basicSecondVC, animated: true)
        }
    }
}

extension BasicFirstViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case txtPO:
            basicDict["poNo"] = textField.text ?? ""
        case txtContent :
            basicDict["content"] = textField.text ?? ""
        case txtConstruction:
            basicDict["construction"] = textField.text ?? ""
        case txtPOCutWidth:
            basicDict["poCutWidth"] = Float(textField.text ?? "") ?? 0.0
        case txtFactoryName:
            basicDict["factoryName"] = textField.text ?? ""
        case txtOrderQty:
            basicDict["orderQty"] = Int(textField.text ?? "") ?? 0
        case txtTotalQtyOffered:
            basicDict["totalQtyOffered"] = Int(textField.text ?? "") ?? 0
        case txtWeightGSM:
            basicDict["weightGSM"] = Float(textField.text ?? "") ?? 0.0
        case txtColorName:
            basicDict["colorName"] = textField.text ?? ""
        case txtFinish:
            basicDict["finish"] = textField.text ?? ""
        default:
            print("default")
        }
        
    }
}
