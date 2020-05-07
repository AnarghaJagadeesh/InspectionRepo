//
//  SummaryFirstViewController.swift
//  Inspection
//
//  Created by Beegins on 06/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class SummaryFirstViewController: UIViewController {
    
    var subjectArray = [SubjectStruct]()

    @IBOutlet weak var summaryCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateSubject()
        summaryCollectionView.delegate = self
        summaryCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func populateSubject(){
        self.subjectArray = []
        self.subjectArray.append(SubjectStruct(dict: ["title" : "PO Number:", "value" : "123456"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Fabric Type:", "value" : "Knit"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Content:", "value" : "Test"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Construction:", "value" : "Test"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Cuttable Width:", "value" : "56"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Color Name:", "value" : "Blue"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Weight in GSM:", "value" : "20"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Total QTY Inspected", "value" : "900"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Percentage Inspected:", "value" : "100%"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "No. of rolls accepted:", "value" : "800"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "No. of rolls rejected:", "value" : "100"]))
        self.subjectArray.append(SubjectStruct(dict: ["title" : "Average Points/100 Sq Yard", "value" : "11.55"]))
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

extension SummaryFirstViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.subjectArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath) as! SummaryFirstCollectionViewCell
        cell.subjectModel = self.subjectArray[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "summaryHeaderCell", for: indexPath)
            return header
        }
        return UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 35)
    }
}
