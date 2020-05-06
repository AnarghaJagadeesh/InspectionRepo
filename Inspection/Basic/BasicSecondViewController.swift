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
    
}
