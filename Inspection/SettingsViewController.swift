//
//  SettingsViewController.swift
//  Inspection
//
//  Created by Beegins on 01/06/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import iOSDropDown
import LanguageManager_iOS

class SettingsViewController: UIViewController {

    var selectedIndex = 0;
    @IBOutlet weak var languageDropDown: DropDown!
    override func viewDidLoad() {
        super.viewDidLoad()
        languageDropDown.optionArray = ["English","Chinese"]
        languageDropDown.didSelect { (value, index1, index2) in
            self.selectedIndex = index1
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTapSave(_ sender: UIButton) {
        let selectedLanguage : Languages = self.selectedIndex == 0 ? .en : .zhHans
        LanguageManager.shared.setLanguage(language: selectedLanguage)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
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
