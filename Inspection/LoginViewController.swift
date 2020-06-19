//
//  ViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 16/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import iOSDropDown
import IHProgressHUD
import LanguageManager_iOS

class LoginViewController: UIViewController {

    @IBOutlet var languageDropDown: DropDown!
    @IBOutlet var employeeIDTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        languageDropDown.optionArray = ["English", "Chinese"]
        setLangauge()
        languageDropDown.didSelect { (value, index1, index2) in
            let selectedLanguage : Languages = index1 == 0 ? .en : .zhHans
            LanguageManager.shared.setLanguage(language: selectedLanguage)
            self.setLangauge()
        }
        // Do any additional setup after loading the view.
    }
    
    func setLangauge(){
        self.employeeIDTextField.placeholder = "Employee Id".localiz()
        self.passwordTextField.placeholder = "Password".localiz()
    }
    
    
    func validate() {
        if employeeIDTextField.text == "" || passwordTextField.text == "" {
            Helper.showAlert(message: "Please enter Employer ID and Password")
            return
        } else {
            IHProgressHUD.show()
             var isDoneArray = [Bool]()
            self.viewModel.performLoginApi(username: self.employeeIDTextField.text ?? "", password: self.passwordTextField.text ?? "") { (responseData) in
                print(responseData)
                if let status = responseData["status"] as? String {
                    if  status == StatusCode.success.rawValue {
                        var userDic = [String:Any]()
                        userDic["token"] = responseData["token"]
                        userDic["user_id"] = responseData["user_id"] as! Int
                        userDic["username"] = responseData["username"]
                        UserDefaults.standard.set(userDic, forKey: "userData")
                          print(AppSettings.getCurrentUser())
                       
                        self.viewModel.performFetchFabricApi { (isDone) in
                            isDoneArray.append(isDone)
                            if isDoneArray.count == 4 {
                                self.goToHome()
                                IHProgressHUD.dismiss()
                            }
                        }
                        self.viewModel.performFetchFabricCategoryApi { (isDone) in
                            isDoneArray.append(isDone)
                            if isDoneArray.count == 4 {
                                self.goToHome()
                                IHProgressHUD.dismiss()
                            }
                            
                        }
                        self.viewModel.performRollListApi { (isDone) in
                            isDoneArray.append(isDone)
                            if isDoneArray.count == 4 {
                                self.goToHome()
                                IHProgressHUD.dismiss()
                            }
                        }
                        
                        self.viewModel.performInspectionListApi { (isDone) in
                            isDoneArray.append(isDone)
                            if isDoneArray.count == 4 {
                                self.goToHome()
                                 IHProgressHUD.dismiss()
                                
                            }
                        }
                    } else {
                        Helper.showAlert(message: "Login failed")
                        IHProgressHUD.dismiss()
                    }
                }
                else {
                    Helper.showAlert(message: "Login failed")
                    IHProgressHUD.dismiss()
                }
                
              
            }
        }
    }
    func goToHome() {
        DispatchQueue.main.async {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homeVC = storyBoard.instantiateViewController(withIdentifier: "HomeVC") as! HomeViewController
            homeVC.basicStructApi = self.viewModel.basicFirstModel
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    @IBAction func onTapLogin(_ sender: UIButton) {
        self.validate()
    }
    
}

