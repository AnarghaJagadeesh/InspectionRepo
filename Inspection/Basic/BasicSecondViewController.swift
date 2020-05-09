//
//  BasicSecondViewController.swift
//  Inspection
//
//  Created by Anpu S Anand on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData
import DropDown

enum Quality : String {
    case LIGHT = "Light"
    case MEDIUM = "Medium"
    case HEAVY = "Heavy"
    case NO = "No"
}

class BasicSecondViewController: UIViewController {
    @IBOutlet weak var rollNumberTxt: UITextField!
    
    @IBOutlet weak var end2EndShadingImgLight: UIImageView!
    
    @IBOutlet weak var end2EndShadingImgMediuim: UIImageView!
    
    @IBOutlet weak var end2EndShadingImgHeavy: UIImageView!
    
    @IBOutlet weak var end2EndShadingImgNo: UIImageView!
    
    @IBOutlet weak var side2SideShadingImgLight: UIImageView!
    
    @IBOutlet weak var side2SideShadingImgMedium: UIImageView!
    
    @IBOutlet weak var side2SideShadingImgHeavy: UIImageView!
    
    @IBOutlet weak var side2SideShadingImgNo: UIImageView!
    
    @IBOutlet weak var dropDownBottomView: UIView!
    var numberDropDown = DropDown()
    var numberArray = ["1","2","3","4","5"]
    @IBOutlet weak var side2CenterImgLight: UIImageView!
    
    @IBOutlet weak var side2CenterImgMedium: UIImageView!
    
    @IBOutlet weak var side2CenterImgHeavy: UIImageView!
    
    
    @IBOutlet weak var side2CenterImgNo: UIImageView!
    
    @IBOutlet weak var patternOkImg: UIImageView!
    @IBOutlet weak var patternNotOkImg: UIImageView!
    
    @IBOutlet weak var handFeelOkImg: UIImageView!
    @IBOutlet weak var handfeelNotOkImg: UIImageView!
    
    
    @IBOutlet weak var ticketLengthYdsTxt: UITextField!
    @IBOutlet weak var actualLengthtxt: UITextField!
    
    @IBOutlet weak var actualCutWidthFirstTxt: UITextField!
    @IBOutlet weak var actualCutWidthSecondTxt: UITextField!
    @IBOutlet weak var actualCutWidthThirdTxt: UITextField!
    
    @IBOutlet weak var skewTxt: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    
    var basicSecondDict = [String : Any]()
    var basicSecond = [NSManagedObject]()
    var basicStruct : BasicSecondStruct?
    var basicFirstStruct : BasicFirstStruct?
    
    var editType : EditType = .UPDATE
    
    var rollCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        if editType == .UPDATE {
            self.fetchFromCoreData()
        }
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
        rollNumberTxt.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 5, height: 5))
        let image = UIImage(named: "DownArrow")
        imageView.image = image
        rollNumberTxt.rightView = imageView
        dropDownSetup()
        
        self.rollNumberTxt.delegate = self
        self.ticketLengthYdsTxt.delegate = self
        self.actualLengthtxt.delegate = self
        self.actualCutWidthFirstTxt.delegate = self
        self.actualCutWidthSecondTxt.delegate = self
        self.actualCutWidthThirdTxt.delegate = self
        self.skewTxt.delegate = self
        self.weightTxt.delegate = self
    }
    func dropDownSetup(){
        numberDropDown.anchorView = dropDownBottomView
        numberDropDown.dataSource = numberArray
        numberDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.rollNumberTxt.text = item
             self.basicSecondDict["rollNumber"] = item
            self.numberDropDown.hide()
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
    // MARK: - ButtonAction
    @IBAction func dropDownPressed(_ sender: Any) {
        numberDropDown.show()
    }
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        if editType == .NEW {
            self.basicSecondDict["inspectionNo"] = UserDefaults.standard.value(forKey: "inspectionNo") as! Int
            self.basicStruct = BasicSecondStruct(dict: basicSecondDict)
            self.saveToCoreData()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rollsFirstVC = storyBoard.instantiateViewController(withIdentifier: "rollFirstVC") as! RollsFirstViewController
        rollsFirstVC.basicFirstModel = self.basicFirstStruct
        rollsFirstVC.basicSecondModel = self.basicStruct
        rollsFirstVC.rollCount = self.rollCount
        self.navigationController?.pushViewController(rollsFirstVC, animated: true)
    }
    
    @IBAction func end2EndShadingPressed(_ sender: UIButton) {
        end2EndShadingImgLight.image = UIImage(named: "UnSelect")
        end2EndShadingImgMediuim.image = UIImage(named: "UnSelect")
        end2EndShadingImgHeavy.image = UIImage(named: "UnSelect")
        end2EndShadingImgNo.image = UIImage(named: "UnSelect")
        
        
        if sender.tag == 0 {
            end2EndShadingImgLight.image = UIImage(named: "Select")
            basicSecondDict["endToEnd"] = Quality.LIGHT.rawValue
        }
        if sender.tag == 1 {
            end2EndShadingImgMediuim.image = UIImage(named: "Select")
            basicSecondDict["endToEnd"] = Quality.MEDIUM.rawValue
        }
        if sender.tag == 2 {
            end2EndShadingImgHeavy.image = UIImage(named: "Select")
            basicSecondDict["endToEnd"] = Quality.HEAVY.rawValue
        }
        if sender.tag == 3 {
            end2EndShadingImgNo.image = UIImage(named: "Select")
            basicSecondDict["endToEnd"] = Quality.NO.rawValue
        }
    }
    @IBAction func side2EndShadingPressed(_ sender: UIButton) {
        side2SideShadingImgLight.image = UIImage(named: "UnSelect")
        side2SideShadingImgMedium.image = UIImage(named: "UnSelect")
        side2SideShadingImgHeavy.image = UIImage(named: "UnSelect")
        side2SideShadingImgNo.image = UIImage(named: "UnSelect")
        
        
        if sender.tag == 0 {
            side2SideShadingImgLight.image = UIImage(named: "Select")
            basicSecondDict["sideToSide"] = Quality.LIGHT.rawValue
        }
        if sender.tag == 1 {
            side2SideShadingImgMedium.image = UIImage(named: "Select")
            basicSecondDict["sideToSide"] = Quality.MEDIUM.rawValue
        }
        if sender.tag == 2 {
            side2SideShadingImgHeavy.image = UIImage(named: "Select")
            basicSecondDict["sideToSide"] = Quality.HEAVY.rawValue
        }
        if sender.tag == 3 {
            side2SideShadingImgNo.image = UIImage(named: "Select")
            basicSecondDict["sideToSide"] = Quality.NO.rawValue
        }
    }
    
    @IBAction func side2CenterShadingPressed(_ sender: UIButton) {
        side2CenterImgLight.image = UIImage(named: "UnSelect")
        side2CenterImgMedium.image = UIImage(named: "UnSelect")
        side2CenterImgHeavy.image = UIImage(named: "UnSelect")
        side2CenterImgNo.image = UIImage(named: "UnSelect")
        if sender.tag == 0 {
            side2CenterImgLight.image = UIImage(named: "Select")
            basicSecondDict["sideToCenter"] = Quality.LIGHT.rawValue
        }
        if sender.tag == 1 {
            side2CenterImgMedium.image = UIImage(named: "Select")
            basicSecondDict["sideToCenter"] = Quality.MEDIUM.rawValue
        }
        if sender.tag == 2 {
            side2CenterImgHeavy.image = UIImage(named: "Select")
            basicSecondDict["sideToCenter"] = Quality.HEAVY.rawValue
        }
        if sender.tag == 3 {
            side2CenterImgNo.image = UIImage(named: "Select")
            basicSecondDict["sideToCenter"] = Quality.NO.rawValue
        }
    }
    
    @IBAction func patternPressed(_ sender: UIButton) {
        patternOkImg.image = UIImage(named: "UnSelect")
        patternNotOkImg.image = UIImage(named: "UnSelect")
        
        if sender.tag == 0 {
            patternOkImg.image = UIImage(named: "Select")
            basicSecondDict["pattern"] = true
        }
        if sender.tag == 1 {
            patternNotOkImg.image = UIImage(named: "Select")
            basicSecondDict["pattern"] = false
        }
    }
    @IBAction func bkPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func handFeelPressed(_ sender: UIButton) {
        handFeelOkImg.image = UIImage(named: "UnSelect")
        handfeelNotOkImg.image = UIImage(named: "UnSelect")
        
        if sender.tag == 0 {
            handFeelOkImg.image = UIImage(named: "Select")
            basicSecondDict["handFeel"] = true
        }
        if sender.tag == 1 {
            handfeelNotOkImg.image = UIImage(named: "Select")
            basicSecondDict["handFeel"] = false
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
        let basicEntity =
            NSEntityDescription.entity(forEntityName: "BasicSecond",
                                       in: managedContext)!
        let basicFirstVal = NSManagedObject(entity: basicEntity,
                                            insertInto: managedContext)
        
        // 3
        if let model = basicStruct {
            basicFirstVal.setValue(model.rollNumber, forKeyPath: "rollNumber")
            basicFirstVal.setValue(model.ticketLength, forKey: "ticketLength")
            basicFirstVal.setValue(model.actualLength, forKeyPath: "actualLength")
            basicFirstVal.setValue(model.actualCutWidthOne, forKeyPath: "actualCutWidthOne")
            basicFirstVal.setValue(model.actualCutWidthTwo, forKeyPath: "actualCutWidthTwo")
            basicFirstVal.setValue(model.actualCutWidthThree, forKeyPath: "actualCutWidthThree")
            basicFirstVal.setValue(model.endToEnd, forKeyPath: "endToEnd")
            basicFirstVal.setValue(model.sideToSide, forKeyPath: "sideToSide")
            basicFirstVal.setValue(model.sideToCenter, forKeyPath: "sideToCenter")
            basicFirstVal.setValue(model.skewBowing, forKeyPath: "skewBowing")
            basicFirstVal.setValue(model.pattern, forKeyPath: "pattern")
            basicFirstVal.setValue(model.actualWeightGSM, forKeyPath: "actualWeightGSM")
            basicFirstVal.setValue(model.handFeel, forKeyPath: "handFeel")
            basicFirstVal.setValue(model.inspectionNo, forKey: "inspectionNo")
        }
        
        
        // 4
        do {
            try managedContext.save()
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BasicSecond")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                basicSecondDict["rollNumber"] = data.value(forKey: "rollNumber") as! String
                basicSecondDict["ticketLength"] = data.value(forKey: "ticketLength") as! Float
                basicSecondDict["actualLength"] = data.value(forKey: "actualLength") as! Float
                basicSecondDict["actualCutWidthOne"] = data.value(forKey: "actualCutWidthOne") as! Float
                basicSecondDict["actualCutWidthTwo"] = data.value(forKey: "actualCutWidthTwo") as! Float
                basicSecondDict["actualCutWidthThree"] = data.value(forKey: "actualCutWidthThree") as! Float
                basicSecondDict["endToEnd"] = data.value(forKey: "endToEnd") as! String
                basicSecondDict["sideToSide"] = data.value(forKey: "sideToSide") as! String
                basicSecondDict["sideToCenter"] = data.value(forKey: "sideToCenter") as! String
                basicSecondDict["skewBowing"] = data.value(forKey: "skewBowing") as! String
                basicSecondDict["pattern"] = data.value(forKey: "pattern") as! Bool
                basicSecondDict["actualWeightGSM"] = data.value(forKey: "actualWeightGSM") as! Float
                basicSecondDict["handFeel"] = data.value(forKey: "handFeel") as! Bool
                basicSecondDict["inspectionNo"] = data.value(forKey: "inspectionNo") as! Int
                self.basicStruct = BasicSecondStruct(dict: basicSecondDict)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        if let model = basicStruct {
            self.rollNumberTxt.text = model.rollNumber
            self.ticketLengthYdsTxt.text = "\(model.ticketLength)"
            self.actualLengthtxt.text = "\(model.actualLength)"
            self.actualCutWidthFirstTxt.text = "\(model.actualCutWidthOne)"
            self.actualCutWidthSecondTxt.text = "\(model.actualCutWidthTwo)"
            self.actualCutWidthThirdTxt.text = "\(model.actualCutWidthThree)"
            self.skewTxt.text = model.skewBowing
            self.weightTxt.text = "\(model.actualWeightGSM)"
            let endToEndBtn = UIButton()
            switch model.endToEnd {
            case Quality.LIGHT.rawValue:
                endToEndBtn.tag = 0
            case Quality.MEDIUM.rawValue :
                endToEndBtn.tag = 1
            case Quality.HEAVY.rawValue :
                endToEndBtn.tag = 2
            case Quality.NO.rawValue:
                endToEndBtn.tag = 3
            default:
                print("default")
            }
            self.end2EndShadingPressed(endToEndBtn)
            let sideToSide = UIButton()
            switch model.sideToSide {
            case Quality.LIGHT.rawValue:
                sideToSide.tag = 0
            case Quality.MEDIUM.rawValue :
                sideToSide.tag = 1
            case Quality.HEAVY.rawValue :
                sideToSide.tag = 2
            case Quality.NO.rawValue:
                sideToSide.tag = 3
            default:
                print("default")
            }
            self.side2EndShadingPressed(sideToSide)
            let sideToCenter = UIButton()
            switch model.sideToCenter {
            case Quality.LIGHT.rawValue:
                sideToCenter.tag = 0
            case Quality.MEDIUM.rawValue :
                sideToCenter.tag = 1
            case Quality.HEAVY.rawValue :
                sideToCenter.tag = 2
            case Quality.NO.rawValue:
                sideToCenter.tag = 3
            default:
                print("default")
            }
            self.side2CenterShadingPressed(sideToCenter)
            let patterBtn = UIButton()
            switch model.pattern {
            case true:
                patterBtn.tag = 0
            case false :
                patterBtn.tag = 1
            default:
                print("default")
            }
            self.patternPressed(patterBtn)
            let handFeelBtn = UIButton()
            switch model.handFeel {
            case true:
                handFeelBtn.tag = 0
            case false :
                handFeelBtn.tag = 1
            default:
                print("default")
            }
            self.handFeelPressed(handFeelBtn)
        }
    }

}

extension BasicSecondViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value : String = textField.text ?? ""
        switch textField {
        case ticketLengthYdsTxt:
            self.basicSecondDict["ticketLength"] = Float(value)
        case actualLengthtxt:
            self.basicSecondDict["actualLength"] = Float(value)
        case actualCutWidthFirstTxt:
            self.basicSecondDict["actualCutWidthOne"] = Float(value)
        case actualCutWidthSecondTxt:
            self.basicSecondDict["actualCutWidthTwo"] = Float(value)
        case actualCutWidthThirdTxt:
            self.basicSecondDict["actualCutWidthThree"] = Float(value)
        case skewTxt:
            self.basicSecondDict["skewBowing"] = value
        case weightTxt:
            self.basicSecondDict["actualWeightGSM"] = Float(value)
        default:
            print("Default")
        }
    }
}
