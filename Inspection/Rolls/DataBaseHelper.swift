//
//  DataBaseHelper.swift
//  Inspection
//
//  Created by Beegins on 09/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    func saveImage(data: Data) {
        let imageInstance = RollImages(context: context)
        imageInstance.rollImage = data
        do {
            try context.save()
            print("Image is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}
