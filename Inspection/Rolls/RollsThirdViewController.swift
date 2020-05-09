//
//  RollsThirdViewController.swift
//  Inspection
//
//  Created by Anpu S Anand on 06/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

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
    var isValid = [false]
    var remarkText = ""
    var rollCount : Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
   initialSetup()
        self.populatingPoints()
        self.validation()
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
        mainView.layer.cornerRadius = 15
    }
    
    func validation() {
        if let basicFirst = basicFirstModel {
            if let basicSecond = basicSecondModel {
                if (basicSecond.actualWeightGSM >= basicFirst.weightGSM + 5.0) && (basicSecond.actualWeightGSM <= basicFirst.weightGSM + 5.0) {
                    isValid.append(true)
                } else {
                    isValid.append(false)
                    remarkText = "Failed for Actual Weight"
                }
                if basicSecond.endToEnd == Quality.NO.rawValue {
                    isValid.append(false)
                    remarkText = remarkText == "" ? "Failed for End to End Shading" : "\nFailed for End to End Shading"
                } else {
                    isValid.append(true)
                }
                if basicSecond.sideToSide == Quality.NO.rawValue {
                    isValid.append(false)
                    remarkText = remarkText == "" ? "Failed for Side to Side Shading" : "\nFailed for Side to Side Shading"
                } else {
                    isValid.append(true)
                }
                if basicSecond.sideToCenter == Quality.NO.rawValue {
                    isValid.append(false)
                    remarkText = remarkText == "" ? "Failed for Side to Center Shading" : "\nFailed for Side to Center Shading"
                } else {
                    isValid.append(true)
                }
            }
        }
        if isValid.contains(false) {
            self.resultLbl.text = "FAILED"
        } else {
            self.resultLbl.text = "PASS"
        }
        
    }
    
    func populatingPoints(){
        self.rollLbl.text = "\(rollCount)"
        if let rollModel = self.rollFirstModel {
            self.fourPointsLbl.text = "\(rollModel.fourPoint)"
            self.threePointsLbl.text = "\(rollModel.threePoint)"
            self.twoPointsLbl.text = "\(rollModel.twoPoint)"
            self.onePointsLbl.text = "\(rollModel.onePoint)"
            let total = rollModel.fourPoint + rollModel.threePoint + rollModel.twoPoint + rollModel.onePoint
            self.totalPointsLbl.text = "\(total)"
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
    }
    
    @IBAction func finisheRollPressed(_ sender: Any) {
    }
    
    @IBAction func AddMorePressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicSecondVC = storyBoard.instantiateViewController(withIdentifier: "basicSecondVC") as! BasicSecondViewController
        self.rollCount = self.rollCount + 1
        self.navigationController?.pushViewController(basicSecondVC, animated: true)
    }
    @IBAction func bkPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryFirstVC = storyBoard.instantiateViewController(withIdentifier: "summaryFirstVC") as! SummaryFirstViewController
        summaryFirstVC.basicFirstModel = self.basicFirstModel
        self.navigationController?.pushViewController(summaryFirstVC, animated: true)

    }
    
}
