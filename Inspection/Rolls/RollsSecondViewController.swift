//
//  RollsSecondViewController.swift
//  Inspection
//
//  Created by Beegins on 09/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData

class RollsSecondViewController: UIViewController {
    
    var pickedImages = [UIImage]()
    var editType : EditType = .UPDATE

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.saveToCoreData()
        if editType == .UPDATE {
            self.fetchImage()
        }
        // Do any additional setup after loading the view.
    }
    
    func saveToCoreData(){
        if let imageData = pickedImages[0].pngData() {
        DataBaseHelper.shareInstance.saveImage(data: imageData)
        }
    }
    func fetchImage() {
        var fetchingImage = [RollImages]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RollImages")
        
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [RollImages]
            for data in fetchingImage {
                print(data.rollImage!)
            }
        } catch {
            print("Error while fetching the image")
        }
//        return fetchingImage
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
