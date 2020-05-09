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
    var pickedimgData = [Data]()
 
    var basicFirstModel : BasicFirstStruct?
    var basicSecondModel : BasicSecondStruct?
    var rollFirstModel : RollStruct?
    var rollCount : Int = 0
    
    @IBOutlet weak var testImage: UIImageView!
    @IBOutlet weak var imageCol: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCol.delegate = self
        self.imageCol.dataSource = self
//        self.testImage.image = self.pickedImages[0]
//        self.saveToCoreData()
        if editType == .UPDATE {
            self.fetchImage()
        }
        // Do any additional setup after loading the view.
    }
    
    func saveToCoreData(img : UIImage){
        if let imageData = img.pngData() {
            self.pickedimgData.append(imageData)
        }
        DataBaseHelper.shareInstance.saveImage(data: pickedimgData)
    }
    func fetchImage() {
        var fetchingImage = [RollImages]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RollImages")
        
        do {
            fetchingImage = try context.fetch(fetchRequest) as! [RollImages]
            for data in fetchingImage {
                self.pickedimgData = data.rollImage as! [Data]
            }
        } catch {
            print("Error while fetching the image")
        }
        self.pickedImages = []
        _ = self.pickedimgData.map({ (imgData) in
            self.pickedImages.append(UIImage(data: imgData) ?? UIImage())
        })
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
    @IBAction func onTapNext(_ sender: UIButton) {
        if editType == .NEW {
            _ = self.pickedImages.map({ (img) in
                self.saveToCoreData(img: img)
            })
        }
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let rollsThirdVC = storyBoard.instantiateViewController(withIdentifier: "rollThirdVC") as! RollsThirdViewController
        rollsThirdVC.basicFirstModel = self.basicFirstModel
        rollsThirdVC.basicSecondModel = self.basicSecondModel
        rollsThirdVC.rollFirstModel = self.rollFirstModel
        rollsThirdVC.rollCount = rollCount
        self.navigationController?.pushViewController(rollsThirdVC, animated: true)
        
    }
}

extension RollsSecondViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pickedImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageListCollectionViewCell
        cell.imgView.contentMode = .scaleToFill
        cell.imgView.image = self.pickedImages[indexPath.item]
        cell.txtLbl.text = "\(indexPath.item + 1)"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let ht = 200
        return CGSize(width: ht, height: ht)
    }
    
    
}
