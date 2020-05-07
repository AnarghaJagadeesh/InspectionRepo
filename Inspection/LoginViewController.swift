//
//  ViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 16/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import iOSDropDown

class LoginViewController: UIViewController {

    @IBOutlet var languageDropDown: DropDown!
    @IBOutlet var employeeIDTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageDropDown.optionArray = ["English", "Hindi", "Malayalam"]
        // Do any additional setup after loading the view.
    }

    @IBAction func onTapLogin(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicFirstVC = storyBoard.instantiateViewController(withIdentifier: "basicFirstVC") as! BasicFirstViewController
        self.navigationController?.pushViewController(basicFirstVC, animated: true)
    }
    
}

