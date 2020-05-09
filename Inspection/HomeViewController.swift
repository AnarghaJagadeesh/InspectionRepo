//
//  HomeViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 18/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class HomeViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var homeCol: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

       initialSetup()
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
      
        bottomView.layer.cornerRadius = 20
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = UIColor.lightGray.cgColor
       // bottomView.dropShadow()
    }
 

    
     @IBAction func searchPressed(_ sender: Any) {
   
    }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func addButtonPressed(_ sender: Any) {
        
    }
    
}
