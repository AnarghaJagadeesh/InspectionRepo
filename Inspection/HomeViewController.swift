//
//  HomeViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 18/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var homeCol: UICollectionView!
    var basicStruct = [BasicFirstStruct]()
    var basicDict = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCol.delegate = self
        homeCol.dataSource = self
        self.fetchFromCoreData()
       initialSetup()
        // Do any additional setup after loading the view.
    }
    func initialSetup(){
      
        bottomView.layer.cornerRadius = 20
        bottomView.layer.borderWidth = 0.5
        bottomView.layer.borderColor = UIColor.lightGray.cgColor
       // bottomView.dropShadow()
    }
 
    func fetchFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BasicFirst")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                basicDict["fabricCategory"] = data.value(forKey: "fabricCategory") as! String
                basicDict["poNo"] = data.value(forKey: "poNo") as! String
                basicDict["content"] = data.value(forKey: "content") as! String
                basicDict["construction"] = data.value(forKey: "construction") as! String
                basicDict["poCutWidth"] = data.value(forKey: "poCutWidth") as! Float
                basicDict["fabricType"] = data.value(forKey: "fabricType") as! String
                basicDict["factoryName"] = data.value(forKey: "factoryName") as! String
                basicDict["orderQty"] = data.value(forKey: "orderQty") as! Int
                basicDict["totalQtyOffered"] = data.value(forKey: "totalQtyOffered") as! Int
                basicDict["weightGSM"] = data.value(forKey: "weightGSM") as! Float
                basicDict["colorName"] = data.value(forKey: "colorName") as! String
                basicDict["finish"] = data.value(forKey: "finish") as! String
                basicDict["reportToName"] = data.value(forKey: "reportToName") as! String
                basicDict["inspectionNo"] = data.value(forKey: "inspectionNo") as! Int
                basicDict["date"] = data.value(forKey: "date") as! String
                self.basicStruct .append(BasicFirstStruct(dict: basicDict))
                self.homeCol.reloadData()
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
        if let inspectionNo = UserDefaults.standard.value(forKey: "inspectionNo") as? Int {
            UserDefaults.standard.set(inspectionNo + 1, forKey: "inspectionNo")
        } else {
            UserDefaults.standard.set(1, forKey: "inspectionNo")
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicFirstVC = storyBoard.instantiateViewController(withIdentifier: "basicFirstVC") as! BasicFirstViewController
        self.navigationController?.pushViewController(basicFirstVC, animated: true)
    }
    
}

extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basicStruct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        cell.customerTxt.text = self.basicStruct[indexPath.item].reportToName
        cell.dateTxt.text = self.basicStruct[indexPath.item].date
        cell.poNumberTxt.text = self.basicStruct[indexPath.item].PONo
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionView.elementKindSectionHeader {
//            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeHeaderCell", for: indexPath) as! HomeHeaderCollectionViewCell
//            return header
//        }
//        return UICollectionViewCell()
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 40)
//    }
}
