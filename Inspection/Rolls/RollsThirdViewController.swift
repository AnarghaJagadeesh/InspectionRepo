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
    
    @IBOutlet weak var fourPointsLbl: UILabel!
    @IBOutlet weak var threePointsLbl: UILabel!
    
    @IBOutlet weak var resultLbl: UILabel!
    @IBOutlet weak var twoPointsLbl: UILabel!
    @IBOutlet weak var onePointsLbl: UILabel!
    
    @IBOutlet weak var gradeLbl: UILabel!
    @IBOutlet weak var yardLbl: UILabel!
    @IBOutlet weak var totalPointsLbl: UILabel!
    
    
    
    @IBOutlet weak var mainView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
   initialSetup()
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
        mainView.layer.cornerRadius = 15
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
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryFirstVC = storyBoard.instantiateViewController(withIdentifier: "summaryFirstVC") as! SummaryFirstViewController
        self.navigationController?.pushViewController(summaryFirstVC, animated: true)

    }
    
}
