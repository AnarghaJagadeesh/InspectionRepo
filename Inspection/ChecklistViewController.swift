//
//  ChecklistViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 20/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import M13Checkbox

class ChecklistViewController: UIViewController {

    @IBOutlet var yesCheckbox: M13Checkbox!
    @IBOutlet var noCheckBox: M13Checkbox!
    @IBOutlet var remarkTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yesCheckbox.boxType = .circle
        yesCheckbox.checkState = .unchecked
        yesCheckbox.markType = .checkmark
        yesCheckbox.secondaryCheckmarkTintColor = .white
        yesCheckbox.secondaryTintColor = .darkGray
        yesCheckbox.tintColor = .darkGray
        yesCheckbox.stateChangeAnimation = .fill
        yesCheckbox.checkmarkLineWidth = 1.5
        noCheckBox.boxType = .circle
        noCheckBox.checkState = .unchecked
        noCheckBox.markType = .checkmark
        noCheckBox.secondaryCheckmarkTintColor = .white
        noCheckBox.secondaryTintColor = .darkGray
        noCheckBox.stateChangeAnimation = .fill
        noCheckBox.tintColor = .darkGray
        // Do any additional setup after loading the view.
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
