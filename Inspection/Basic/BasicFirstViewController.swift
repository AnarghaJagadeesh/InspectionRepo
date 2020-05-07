//
//  BasicFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 07/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData

class BasicFirstViewController: UIViewController {

    var basicFirst: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.saveToCoreData()
        self.fetchFromCoreData()
        // Do any additional setup after loading the view.
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
        let basicEntity =
          NSEntityDescription.entity(forEntityName: "BasicFirst",
                                     in: managedContext)!
        let basicFirstVal = NSManagedObject(entity: basicEntity,
                                     insertInto: managedContext)
        
        // 3
        basicFirstVal.setValue("Test 2", forKeyPath: "fabricCategory")
        
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

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "BasicFirst")
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")

        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                print(data.value(forKey: "fabricCategory") as! String)
            }

        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }

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
