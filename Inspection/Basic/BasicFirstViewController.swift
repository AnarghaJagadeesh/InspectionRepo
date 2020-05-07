//
//  BasicFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 07/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class BasicFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

    @IBAction func onTapNext(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicSecondVC = storyBoard.instantiateViewController(withIdentifier: "basicSecondVC") as! BasicSecondViewController
        self.navigationController?.pushViewController(basicSecondVC, animated: true)

    }
}
