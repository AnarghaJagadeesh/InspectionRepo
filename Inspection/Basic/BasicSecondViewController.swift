//
//  BasicSecondViewController.swift
//  Inspection
//
//  Created by Anpu S Anand on 05/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import DropDown

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
        rollNumberTxt.rightViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: -10, y: 0, width: 5, height: 5))
        let image = UIImage(named: "DownArrow")
        imageView.image = image
        rollNumberTxt.rightView = imageView
        dropDownSetup()
    }
    func dropDownSetup(){
        numberDropDown.anchorView = dropDownBottomView
        numberDropDown.dataSource = numberArray
        numberDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.rollNumberTxt.text = item
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
    }
    
    @IBAction func end2EndShadingPressed(_ sender: UIButton) {
        end2EndShadingImgLight.image = UIImage(named: "UnSelect")
        end2EndShadingImgMediuim.image = UIImage(named: "UnSelect")
        end2EndShadingImgHeavy.image = UIImage(named: "UnSelect")
        end2EndShadingImgNo.image = UIImage(named: "UnSelect")
        
        
        if sender.tag == 0 {
            end2EndShadingImgLight.image = UIImage(named: "Select")
        }
        if sender.tag == 1 {
            end2EndShadingImgMediuim.image = UIImage(named: "Select")
        }
        if sender.tag == 2 {
            end2EndShadingImgHeavy.image = UIImage(named: "Select")
        }
        if sender.tag == 3 {
            end2EndShadingImgNo.image = UIImage(named: "Select")
        }
    }
    @IBAction func side2EndShadingPressed(_ sender: UIButton) {
        side2SideShadingImgLight.image = UIImage(named: "UnSelect")
        side2SideShadingImgMedium.image = UIImage(named: "UnSelect")
        side2SideShadingImgHeavy.image = UIImage(named: "UnSelect")
        side2SideShadingImgNo.image = UIImage(named: "UnSelect")
        
        
        if sender.tag == 0 {
            side2SideShadingImgLight.image = UIImage(named: "Select")
        }
        if sender.tag == 1 {
            side2SideShadingImgMedium.image = UIImage(named: "Select")
        }
        if sender.tag == 2 {
            side2SideShadingImgHeavy.image = UIImage(named: "Select")
        }
        if sender.tag == 3 {
            side2SideShadingImgNo.image = UIImage(named: "Select")
        }
    }
    
    @IBAction func side2CenterShadingPressed(_ sender: UIButton) {
        side2CenterImgLight.image = UIImage(named: "UnSelect")
        side2CenterImgMedium.image = UIImage(named: "UnSelect")
        side2CenterImgHeavy.image = UIImage(named: "UnSelect")
        side2CenterImgNo.image = UIImage(named: "UnSelect")
        
        
        if sender.tag == 0 {
            side2CenterImgLight.image = UIImage(named: "Select")
        }
        if sender.tag == 1 {
            side2CenterImgMedium.image = UIImage(named: "Select")
        }
        if sender.tag == 2 {
            side2CenterImgHeavy.image = UIImage(named: "Select")
        }
        if sender.tag == 3 {
            side2CenterImgNo.image = UIImage(named: "Select")
        }
    }
    
    @IBAction func patternPressed(_ sender: UIButton) {
        patternOkImg.image = UIImage(named: "UnSelect")
        patternNotOkImg.image = UIImage(named: "UnSelect")
        
        if sender.tag == 0 {
            patternOkImg.image = UIImage(named: "Select")
        }
        if sender.tag == 1 {
            patternNotOkImg.image = UIImage(named: "Select")
        }
    }
    
    @IBAction func handFeelPressed(_ sender: UIButton) {
        handFeelOkImg.image = UIImage(named: "UnSelect")
        handfeelNotOkImg.image = UIImage(named: "UnSelect")
        
        if sender.tag == 0 {
            handFeelOkImg.image = UIImage(named: "Select")
        }
        if sender.tag == 1 {
            handfeelNotOkImg.image = UIImage(named: "Select")
        }
        
    }
}
