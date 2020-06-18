//
//  SummaryFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 06/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData

struct HeightConst:Equatable{
    var minHeight: CGFloat
    var maxHeight: CGFloat
    var isMax: Bool = false
}

class SummaryFirstViewController: UIViewController {
    
    var subjectArray = [SubjectStruct]()
    var basicFirstModel : BasicFirstStruct?
    var basicDict = [String : Any]()
    var basicSecondDict = [String : Any]()
    var rollSummaryDict = [String : Any]()
    var basicSecondModel = [BasicSecondStruct]()
    var rollSummaryModel = [RollSummaryStruct]()
    var summaryModel = [SummaryFirstStruct]()
    var heightConst : HeightConst?
    var isAccepted : Bool = false
    var comments : String = ""
    var editType : EditType = .NEW
    var summaryStruct : SummaryDataStruct?
    var isAction : Bool = false

    var basicStructApi = [BasicFirstStruct]()

    @IBOutlet weak var summaryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if editType == .UPDATE && isAction == false{
            self.fetchFromCoreData()
           
        }
        if isAction {
            self.fetchFromCoreData()
        } else {
             self.fetchBasicFromCoreData()
        }
        self.fetchRollFromCoreData()
        self.fetchRollSummaryFromCoreData()

        heightConst = HeightConst(minHeight: 230, maxHeight: 500, isMax: false)
        self.populateSubject()

        summaryCollectionView.delegate = self
        summaryCollectionView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    func fetchBasicFromCoreData(){
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
                self.basicFirstModel = BasicFirstStruct(dict: basicDict)
                print(basicFirstModel)
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchRollFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BasicSecond")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                print(self.basicFirstModel)
                if data.value(forKey: "inspectionNo") as? Int == self.basicFirstModel?.inspectionNo {
                    basicSecondDict["rollNumber"] = data.value(forKey: "rollNumber") as! String
                    basicSecondDict["ticketLength"] = data.value(forKey: "ticketLength") as! Float
                    basicSecondDict["actualLength"] = data.value(forKey: "actualLength") as! Float
                    basicSecondDict["actualCutWidthOne"] = data.value(forKey: "actualCutWidthOne") as! Float
                    basicSecondDict["actualCutWidthTwo"] = data.value(forKey: "actualCutWidthTwo") as! Float
                    basicSecondDict["actualCutWidthThree"] = data.value(forKey: "actualCutWidthThree") as! Float
                    basicSecondDict["endToEnd"] = data.value(forKey: "endToEnd") as! String
                    basicSecondDict["sideToSide"] = data.value(forKey: "sideToSide") as! String
                    basicSecondDict["sideToCenter"] = data.value(forKey: "sideToCenter") as! String
                    basicSecondDict["skewBowing"] = data.value(forKey: "skewBowing") as! String
                    basicSecondDict["pattern"] = data.value(forKey: "pattern") as! Bool
                    basicSecondDict["actualWeightGSM"] = data.value(forKey: "actualWeightGSM") as! Float
                    basicSecondDict["handFeel"] = data.value(forKey: "handFeel") as! Bool
                    basicSecondDict["inspectionNo"] = data.value(forKey: "inspectionNo") as! Int
                    self.basicSecondModel.append(BasicSecondStruct(dict: basicSecondDict))
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func fetchRollSummaryFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollThird")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                if data.value(forKey: "inspectionNo") as? Int == self.basicFirstModel?.inspectionNo {
                    rollSummaryDict["totalPoints"] = data.value(forKey: "totalPoints") as! Int
                    rollSummaryDict["status"] = data.value(forKey: "status") as! Bool
                    rollSummaryDict["inspectionNo"] = data.value(forKey: "inspectionNo") as! Int
                    rollSummaryDict["rollNo"] = data.value(forKey: "rollNo") as! Int
                    rollSummaryDict["grade"] = data.value(forKey: "grade") as! String
                    rollSummaryDict["remarks"] = data.value(forKey: "remarks") as! String
                    rollSummaryDict["pointDict"] = data.value(forKey: "pointsDict") as! [String:Any]
                    rollSummaryDict["yardValue"] = data.value(forKey: "yardValue") as! Double
                    self.rollSummaryModel.append(RollSummaryStruct(dict: rollSummaryDict))
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func saveToCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        //        let rollFirstVal = NSManagedObject(entity: rollEntity,
        //                                            insertInto: managedContext)
        
        // 3
        
                
        let summaryDict = SummaryFirst(context: managedContext)
        summaryDict.factoryAccepted = self.isAccepted
        summaryDict.comments = self.comments
        summaryDict.acceptedRolls = Int16(Int(self.subjectArray[9].value ) ?? 0)
        summaryDict.rejectedRolls = Int16(Int(self.subjectArray[10].value ) ?? 0)
        summaryDict.avgPoints = Int32(Int(self.subjectArray[11].value) ?? 0)
        summaryDict.inspectionNo = Int32(UserDefaults.standard.value(forKey: "inspectionNo") as! Int)
        // 4
        do {
            try managedContext.save()
            //          basicFirst.append(basicFirstVal)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SummaryFirst")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                print(self.basicFirstModel)
                if data.value(forKey: "inspectionNo") as? Int == self.basicFirstModel?.inspectionNo {
                    self.isAccepted = data.value(forKey: "factoryAccepted") as! Bool
                    self.comments = data.value(forKey: "comments") as! String
                    self.summaryStruct = SummaryDataStruct(status: data.value(forKey: "factoryAccepted") as! Bool, comm: data.value(forKey: "comments") as! String, inspectionNo: data.value(forKey: "inspectionNo") as! Int, accepRolls: data.value(forKey: "acceptedRolls") as! Int, rejRolls: data.value(forKey: "rejectedRolls") as! Int, avgPoints: data.value(forKey: "avgPoints") as! Int)
                }
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }

    func populateSubject(){
        self.subjectArray = []
        if let model = basicFirstModel {
            self.subjectArray.append(SubjectStruct(dict: ["title" : "PO Number", "value" : "\(model.PONo )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Fabric Type", "value" : "\(model.fabricType )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Content", "value" : "\(model.content )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Construction", "value" : "\(model.content )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Cuttable Width", "value" : "\(model.POCutWidth )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Color Name", "value" : "\(model.colorName )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Weight in GSM", "value" : "\(model.weightGSM )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Total QTY Inspected", "value" : "\(rollSummaryModel.count )"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "Percentage Inspected", "value" : "100%"]))
            var rollAcceptCount = 0
            var rollRejectCount = 0
            var totalPoints = 0
            _ = self.rollSummaryModel.map({ (rollSummaryStruct) in
                if rollSummaryStruct.status == true {
                    rollAcceptCount = rollAcceptCount + 1
                } else {
                    rollRejectCount = rollRejectCount + 1
                }
                totalPoints = totalPoints + rollSummaryStruct.totalPoints
            })
            self.subjectArray.append(SubjectStruct(dict: ["title" : "No. of rolls accepted:", "value" : "\(rollAcceptCount)"]))
            self.subjectArray.append(SubjectStruct(dict: ["title" : "No. of rolls rejected:", "value" : "\(rollRejectCount)"]))
            if self.rollSummaryModel.count > 0 {
                let avgPoint = (totalPoints*25)/(self.rollSummaryModel.count)
                self.subjectArray.append(SubjectStruct(dict: ["title" : "Average Points/100 Sq Yard", "value" : "\(avgPoint)"]))

            }

        }
        
        
        _ = basicSecondModel.map({ (model) in
            var summaryDict = [String : Any]()
            summaryDict["rollNumber"] = model.rollNumber
            summaryDict["shrinkage"] = 0.0
            summaryDict["torque"] = 0.0
            self.summaryModel.append(SummaryFirstStruct(dict: summaryDict))
        })
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
        if editType == .NEW {
            self.saveToCoreData()
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let summarySecondVC = storyBoard.instantiateViewController(withIdentifier: "summarySecondVC") as! ChecklistViewController
        summarySecondVC.editType = self.editType
        summarySecondVC.summaryStruct = self.summaryStruct
        summarySecondVC.basicFirstModel = self.basicFirstModel
        summarySecondVC.basicStructApi = self.basicStructApi
        self.navigationController?.pushViewController(summarySecondVC, animated: true)

    }
    
    @IBAction func bkPressed(_ sender: UIButton) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: HomeViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
}

extension SummaryFirstViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            return 1
        case 2:
            return 1
        default:
            return self.subjectArray.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rollCell", for: indexPath) as! RollDetailsCollectionViewCell
            cell.rollsArray = self.summaryModel
            cell.heightConst = self.heightConst
            cell.didTapExpand = { [weak self] (heightConst) in
                self?.heightConst = heightConst
                self?.summaryCollectionView.reloadSections(IndexSet(integer: 1))
                
            }
            cell.didEditContent = { [weak self] (summaryStruct, selectedIndex, isPresent) in
                if isPresent {
                    self?.summaryModel[selectedIndex] = summaryStruct
                    self?.summaryCollectionView.reloadSections(IndexSet(integer: 1))
                }
            }
            return cell
        case 2 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath) as! SummaryBottomCollectionViewCell
            cell.cmtTxtView.delegate = cell
            cell.cmtTxtView.text = self.comments
            cell.isAccepted = self.isAccepted
            cell.didTapFactoryAccepted = { [weak self] (status)  in
                self?.isAccepted = status
            }
            cell.didEnterComment = { [weak self] (commentStr) in
                self?.comments = commentStr
            }
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath) as! SummaryFirstCollectionViewCell
            cell.subjectModel = self.subjectArray[indexPath.item]
            return cell

        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 1:
            if heightConst?.isMax ?? false {
                return CGSize(width: collectionView.frame.width, height: heightConst?.maxHeight ?? 0)
            } else {
                return CGSize(width: collectionView.frame.width, height: heightConst?.minHeight ?? 0)
            }
        case 2:
            return CGSize(width: collectionView.frame.width, height: 262)
        default:
            return CGSize(width: collectionView.frame.width, height: 35)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            if indexPath.section == 0 {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "summaryHeaderCell", for: indexPath)
                return header
            }
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 1:
            return CGSize.zero
        case 2:
            return CGSize.zero
        default:
            return CGSize(width: collectionView.frame.width, height: 35)
        }
        
    }
}
