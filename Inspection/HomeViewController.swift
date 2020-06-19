//
//  HomeViewController.swift
//  Inspection
//
//  Created by Xavier Joseph on 18/03/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var homeCol: UICollectionView!
    var basicStruct = [BasicFirstStruct]()
    var basicStructApi = [BasicFirstStruct]()
    var basicDict = [String:Any]()
    var editType : EditType = .NEW
    
    @IBAction func btnSettings(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyBoard.instantiateViewController(withIdentifier: "Settings") as! SettingsViewController
        self.navigationController?.pushViewController(settingsVC, animated: true)
        
    }
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
        
        _ = self.basicStructApi.map({ (basicDict) in
            var basicIndex = 0
            if self.basicStruct.contains(basicDict) {
                _ = self.basicStruct.enumerated().map({ (index, basicFirstStruct)  in
                    if basicFirstStruct == basicDict {
                        basicIndex = index
                    }
                })
                self.basicStruct.remove(at: basicIndex)
            }
        })
        _ = self.basicStructApi.map({ (basicDict) in
            self.basicStruct.append(basicDict)
        })
        print(self.basicStruct)
        
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
        if editType == .NEW {
            if let inspectionNo = UserDefaults.standard.value(forKey: "inspectionNo") as? Int {
                UserDefaults.standard.set(inspectionNo + 1, forKey: "inspectionNo")
            } else {
                UserDefaults.standard.set(1, forKey: "inspectionNo")
            }
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let basicFirstVC = storyBoard.instantiateViewController(withIdentifier: "basicFirstVC") as! BasicFirstViewController
        basicFirstVC.editType = self.editType
        basicFirstVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(basicFirstVC, animated: true)
    }
    func goToSummary(basicStruct : BasicFirstStruct) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summaryFirstVC = storyBoard.instantiateViewController(withIdentifier: "summaryFirstVC") as! SummaryFirstViewController
        summaryFirstVC.basicFirstModel = basicStruct
        summaryFirstVC.basicStructApi = basicStructApi
        summaryFirstVC.editType = self.editType
        summaryFirstVC.isAction = true
        self.navigationController?.pushViewController(summaryFirstVC, animated: true)
    }
}


extension HomeViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basicStruct.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCollectionViewCell
        cell.basicStruct = self.basicStruct[indexPath.item]
        cell.didTapAction = { [weak self] (basicStruct) in
            self?.editType = .UPDATE
            if basicStruct.id == 0 {
                self?.goToSummary(basicStruct: basicStruct)
            }
        }
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
