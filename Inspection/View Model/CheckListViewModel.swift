//
//  CheckListViewModel.swift
//  Inspection
//
//  Created by Beegins on 24/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import IHProgressHUD

extension UIImage {
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }

    /// Returns the data for the specified image in JPEG format.
    /// If the image object’s underlying image data has been purged, calling this function forces that data to be reloaded into memory.
    /// - returns: A data object containing the JPEG data, or nil if there was a problem generating the data. This function may return nil if the image has no data or if the underlying CGImageRef contains data in an unsupported bitmap format.
    func jpeg(_ jpegQuality: JPEGQuality) -> Data? {
        return jpegData(compressionQuality: jpegQuality.rawValue)
    }
}


class CheckListViewModel: NSObject {
    
    var basicDict = [String : Any]()
    var basicSecondDict = [String : Any]()
    var rollSummaryDict = [String:Any]()
    var basicFirstModel = [BasicFirstStruct]()
    var basicSecondModel = [BasicSecondStruct]()
    var rollModel = [RollMainStruct]()
    var rollSummaryModel = [RollSummaryStruct]()
    var summaryModel = [SummaryDataStruct]()
    var checkListModel = [CheckListMainStruct]()
    var rollImagesModel = [RollImgaesStruct]()
    var statusArray = [Bool]()
    var rootVC : ChecklistViewController?
    var imageResponse = [[String:Any]]()
    var imageDataArray = [[Data]]()

    
    
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
                self.basicFirstModel.append(BasicFirstStruct(dict: basicDict))
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
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func fetchRollPointsFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "RollFirst")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                let dictArray = data.value(forKey: "rankDict") as! [[String:Any]]
                let rankArray = dictArray.map({ (model) -> RollStruct in
                    return RollStruct(dict: model)
                })
                self.rollModel.append(RollMainStruct(inspectionNo: data.value(forKey: "inspectionNo") as! Int, rankArr: rankArray, rollNo: data.value(forKey: "rollNo") as! Int))
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
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    func fetchRollImageFromCoreData() {
        var fetchingImage = [RollImages]()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "RollImages")
        
        do {
            var pickedImgData = [Data]()
            fetchingImage = try context.fetch(fetchRequest) as! [RollImages]
            for data in fetchingImage {
                pickedImgData = data.rollImage as! [Data]
                self.rollImagesModel.append(RollImgaesStruct(img: pickedImgData, inspecNo: data.value(forKey: "inspectionNo") as! Int, rollNo: data.value(forKey: "rollNo") as! Int))
            }
        } catch {
            print("Error while fetching the image")
        }
        //        self.pickedImages = []
        //        return fetchingImage
    }
    func fetchChecklistFromCoreData(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "CheckList")
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BasicFirst")
        
        //3
        self.statusArray = []
        do {
            let result = try managedContext.fetch(fetchRequest)
            for data in result {
                let dictArray = data.value(forKey: "remarkDict") as! [[String:Any]]
                let checkList = dictArray.map({ (model) -> CheckListStruct in
                    return CheckListStruct(dict: model)
                })
                self.checkListModel.append(CheckListMainStruct(inspectionNo: data.value(forKey: "inspectionNo") as! Int, model: checkList, comm : data.value(forKey: "comments") as! String))
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    func fetchSummaryFromCoreData(){
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
                self.summaryModel.append(SummaryDataStruct(status: data.value(forKey: "factoryAccepted") as! Bool, comm: data.value(forKey: "comments") as! String, inspectionNo: data.value(forKey: "inspectionNo") as! Int, accepRolls: data.value(forKey: "acceptedRolls") as! Int, rejRolls: data.value(forKey: "rejectedRolls") as! Int, avgPoints: data.value(forKey: "avgPoints") as! Int))
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func commpressImage(inspectionNo : Int) -> [[Data]] {
        
        let rollArray = self.rollImagesModel.filter{$0.inspectionNo == inspectionNo}
        _ = rollArray.map({ (rollImageStruct) in
            var imgDataArray = [Data]()
            _ = rollImageStruct.rollImages.enumerated().map({ (index, imgData) in
                let img = UIImage(data: imgData)
                if let imageData = img?.jpeg(.lowest) {
                    imgDataArray.append(imageData)
                }
            })
            self.imageDataArray.append(imgDataArray)
        })
        return self.imageDataArray
    }
    
    func performImageApi(rollNo : Int,dataArray : [Data],completion: @escaping (_ responseData: [[String:Any]]) -> Void) {
         var customHeaders: HTTPHeaders?
        let user = AppSettings.getCurrentUser()
        customHeaders = ["Authorization" : "Bearer \(user.token)"]
        DispatchQueue.main.async {
            IHProgressHUD.show()

        }
        DispatchQueue.global(qos: .background).async {
            Alamofire.upload(multipartFormData: { (multipartFormData) in
                _ = dataArray.enumerated().map({ (index, imgData) in
                    multipartFormData.append(imgData, withName: "images[]", fileName: "image\(index).jpeg", mimeType: "image/jpeg")
                })
            }, to: "\(BaseURL)/\(IMAGE_UPLOAD)", method: .post, headers: customHeaders, encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response)
                        do {
                            let jsonObj = try JSONSerialization.jsonObject(with: response.data!, options: []) as! NSDictionary
                            print(jsonObj)
                            self.imageResponse.append(["\(rollNo)":jsonObj["data"] as! [String]])
                            completion(self.imageResponse)
                        }
                        catch {
                            completion([])
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion([])
                }

            })
        }

    }
    
//    func performImageApi(selInspectionNo : Int, rollArray : [RollImgaesStruct]) {
//        let user = AppSettings.getCurrentUser()
//        let selBasicFirstModel = (self.basicFirstModel.filter{$0.inspectionNo == selInspectionNo}).first
//        let customHeaders = ["Authorization" : "Bearer \(user.token)"]
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            for i in 0..<rollArray.rollImages.count {
//
//                let rotatedImage = rollArray.rollImages[i] as! UIImage
//
//                if let imgData = rotatedImage.jpegData(compressionQuality: 0.8) {
//                   multipartFormData.append(imgData, withName: "image" , fileName: "image\(index+1).jpeg" , mimeType: "image/jpeg")
//                }
//            }
//            for (key, value) in parameters {
//
//                //multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
//                let paramsData:Data = NSKeyedArchiver.archivedData(withRootObject: value)
//                multipartFormData.append(paramsData, withName: key)
//
//            }
//
//            for (key, value) in parameters {
//                if key == "letter" {
//                    let arrData = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
//                    multipartFormData.append(arrData, withName: key as String)
//                }
//                else {
//                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
//                }
//            }
//
//        }, to: "\(BaseURL)/\(IMAGE_UPLOAD)",
//           method:.post,
//           headers:customHeaders) { (result) in
//            print("\n\n\nRequest URL :- \(url)\nParameters :- \(parameters)")
//            switch result {
//            case .success(let upload, , ):
//
//                upload.responseJSON { response in
//
//                    if response.error != nil {
//                        print("Error :- \((response.error?.localizedDescription)!)\n\n\n")
//                    }
//                    if let jsonDict = response.result.value as? NSDictionary {
//                        print("Response :- \(jsonDict)\n\n\n")
//
//                    } else {
//                        //print("Error :- \(Constant.ErrorMessage.kCommanError)\n\n\n")
//                        print("Errfdc")
//                    }
//                }
//            case .failure(let encodingError):
//                print("Error :- \(encodingError.localizedDescription)\n\n\n")
//
//            }
//
//        }
//    }

    
    func performAddInspection(selInspectionNo : Int, completion: @escaping (_ responseData: NSDictionary) -> Void){
//        self.performImageApi(selInspectionNo: selInspectionNo)
        var postData = [String:Any]()
        var basicFirstDict = [String:Any]()
        let selBasicFirstModel = (self.basicFirstModel.filter{$0.inspectionNo == selInspectionNo}).first
        if let basicModel = selBasicFirstModel {
            basicFirstDict["added_on"] = basicModel.date
            basicFirstDict["color_name"] = basicModel.colorName
            basicFirstDict["construction"] = basicModel.construction
            basicFirstDict["content"] = basicModel.content
            basicFirstDict["current_page"] = "1"
            basicFirstDict["current_roll_number"] = ""
            basicFirstDict["fabric_category"] = basicModel.fabricCategory
            basicFirstDict["fabric_type"] = basicModel.fabricType
            basicFirstDict["factory_name"] = basicModel.factoryName
            basicFirstDict["finish"] = basicModel.finish
            basicFirstDict["order_qty"] = "\(basicModel.orderQty)"
            basicFirstDict["po_cut_width_in_inch"] = "\(basicModel.POCutWidth)"
            basicFirstDict["po_number"] = "\(basicModel.PONo)"
            basicFirstDict["report_to_one"] = "\(basicModel.reportToName)"
            basicFirstDict["time"] = "0"
            basicFirstDict["total_qty_offered"] = "\(basicModel.totalQtyOffered)"
            basicFirstDict["weight_in_gsm"] = "\(basicModel.weightGSM)"
        }
        postData["basic"] = basicFirstDict
        if self.imageResponse.count > 0 {
            var imageArray = [[String:Any]]()
            _ = self.imageResponse.map({ (imgDict) in
                var imageDict = [String:Any]()
                for (key,value) in imgDict {
                    let imgArray = value as! [String]
                    _ = imgArray.map({ (imgString)  in
                        imageDict["image"] = imgString
                        imageDict["roll_number"] = key
                        imageDict["po_number"] = selBasicFirstModel?.PONo
                        imageArray.append(imageDict)
                    })
                }
            })
          postData["images"] = imageArray
        } else {
            postData["images"] = []
        }
        
        let rollsArray = self.rollModel.filter{$0.inspectionNo == selInspectionNo}
        var rankArray = [[String:Any]]()
        var count = 1
        _ = rollsArray.map({ (rollMainModel) in
            _ = rollMainModel.rankArray.map({ (rollModel) in
                var dict = [String:Any]()
                dict["id"] = count
                dict["po_number"] = selBasicFirstModel?.PONo
                dict["point_four"] = rollModel.fourPoint
                dict["point_one"] = rollModel.onePoint
                dict["point_three"] = rollModel.threePoint
                dict["point_two"] = rollModel.twoPoint
                dict["rank_id"] = rollModel.id
                dict["roll_number"] = "\(rollMainModel.rollNo)"
                dict["type"] = rollModel.titleText
                count = count + 1
                rankArray.append(dict)
            })
        })
        postData["ranks"] = rankArray
        var rollArray = [[String:Any]]()
        var rollCount = 1
        let rollDetailArray = self.basicSecondModel.filter{$0.inspectionNo == selInspectionNo}
        _ = rollDetailArray.map({ (rollStruct) in
            let rollSummaryStruct = (self.rollSummaryModel.filter{$0.inspectionNo == selInspectionNo && $0.rollNo == Int(rollStruct.rollNumber)}).first
            var dict = [String : Any]()
            dict["actual_cut_width_in_inch_1"] = rollStruct.actualCutWidthOne
            dict["actual_cut_width_in_inch_2"] = rollStruct.actualCutWidthTwo
            dict["actual_cut_width_in_inch_3"] = rollStruct.actualCutWidthThree
            dict["actual_length"] = rollStruct.actualLength
            dict["actual_weight_in_gsm"] = rollStruct.actualWeightGSM
            dict["end_to_end_shedding"] = rollStruct.endToEnd
            dict["grade"] = "A"
            dict["hand_feel"] = "\(rollStruct.handFeel)"
            dict["id"] = rollCount
            dict["pattern"] = "\(rollStruct.pattern)"
            dict["po_number"] = selBasicFirstModel?.PONo ?? ""
            dict["points_per_100_sq_yard"] = rollSummaryStruct?.yardValue
            dict["remark"] = rollSummaryStruct?.remarks
            dict["roll_number"] = rollStruct.rollNumber
            dict["side_to_center_shedding"] = rollStruct.sideToCenter
            dict["side_to_side_shedding"] = rollStruct.sideToSide
            dict["skew_bowing"] = rollStruct.skewBowing
            dict["ticket_length_in_yds"] = rollStruct.ticketLength
            dict["total_points"] = rollSummaryStruct?.totalPoints
            dict["result"] = "\(rollSummaryStruct?.status ?? false)"
            rollCount += 1
            rollArray.append(dict)
        })
        postData["rolls"] = rollArray
        var summaryDict = [String:Any]()
        if let summaryStruct = (self.summaryModel.filter{$0.inspectionNo == selInspectionNo}).first {
            summaryDict["accepted_rolls"] = summaryStruct.acceptedRolls
            summaryDict["avg_points"] = summaryStruct.avgPoints
            summaryDict["comment"] = summaryStruct.comments
            summaryDict["factory_accepted"] = summaryStruct.isAccepted
            summaryDict["percentage_inspected"] = 100
            summaryDict["po_number"] = selBasicFirstModel?.PONo
            summaryDict["rejected_rolls"] = summaryStruct.rejectedRolls
            summaryDict["total_quantity_inspected"] = rollDetailArray.count
        }
        
        if let checkList = (self.checkListModel.filter{$0.inspectionNo == selInspectionNo}).first {
            _ = checkList.checkListData.map({ (checkListModel) in
                switch checkListModel.titleText {
                    
                case "Packing List Available?":
                    summaryDict["packaging_list_available"] = checkListModel.isChecked
                    summaryDict["packaging_list_available_remark"] = checkListModel.remark
                case "Inspect roll # Qty Match to PL?" :
                    summaryDict["inspect_roll"] = checkListModel.isChecked
                    summaryDict["inspect_roll_remark"] = checkListModel.remark
                case "SNS face Stamp on Both End?" :
                    summaryDict["sns_face_stamp_on_both_end"] = checkListModel.isChecked
                    summaryDict["sns_face_stamp_on_both_end_remark"] = checkListModel.remark
                case  "Roll Marking?" :
                    summaryDict["roll_marking"] = checkListModel.isChecked
                    summaryDict["roll_marking_remark"] = checkListModel.remark
                case "Shipping Mark Mentioned on top of the Bale?":
                    summaryDict["shipping_mark_mentioned_on_top_of_the_bale"] = checkListModel.isChecked
                    summaryDict["shipping_mark_mentioned_on_top_of_the_bale_remark"] = checkListModel.remark
                case "Shrinkage SMPL Taken for every 3000 Yds?" :
                    summaryDict["shrinkage_smpl_taken_for_every_3000_yds"] = checkListModel.isChecked
                    summaryDict["shrinkage_smpl_taken_for_every_3000_yds_remark"] = checkListModel.remark
                case "Shrinkage / Torque Measured yourself after washing?" :
                    summaryDict["shrinkage_torque_measured_yourself"] = checkListModel.isChecked
                    summaryDict["shrinkage_torque_measured_yourself_remark"] = checkListModel.remark
                case "Width / GSM Checked by yourself?" :
                    summaryDict["width_gsm_checked_by_yourself"] = checkListModel.isChecked
                    summaryDict["width_gsm_checked_by_yourself_remark"] = checkListModel.remark
                case "Skewing / Bowing Checked By yourself?" :
                    summaryDict["skew_bowing_checked_by_yourself"] = checkListModel.isChecked
                    summaryDict["skew_bowing_checked_by_yourself_remark"] = checkListModel.remark
                case "Color checked With Appd Sample?" :
                    summaryDict["color_checked_with_appd_sample"] = checkListModel.isChecked
                    summaryDict["color_checked_with_appd_sample_remark"] = checkListModel.remark
                case "Checked Color Shading Btw Head end and Tail end?" :
                    summaryDict["checked_color_shading_btw_head_end_and_tail_end"] = checkListModel.isChecked
                    summaryDict["checked_color_shading_btw_head_end_and_tail_end_remark"] = checkListModel.remark
                case "Checked Shading in inspected rolls?" :
                    summaryDict["checked_shading_in_inspected_rolls"] = checkListModel.isChecked
                    summaryDict["checked_shading_in_inspected_rolls_remark"] = checkListModel.remark
                case "Handfeel Checked against Samples?" :
                    summaryDict["handfeel_checked_against_samples"] = checkListModel.isChecked
                    summaryDict["handfeel_checked_against_samples_remark"] = checkListModel.remark
                case "Solid White - Part Inspection on Table?" :
                    summaryDict["solid_white_part_inspection_on_table"] = checkListModel.isChecked
                    summaryDict["solid_white_part_inspection_on_table_remark"] = checkListModel.remark
                case "Length Cross Checked on Table?" :
                    summaryDict["length_cross_checked_on_table"] = checkListModel.isChecked
                    summaryDict["length_cross_checked_on_table_remark"] = checkListModel.remark
                case "Roll Shortage Observed?" :
                    summaryDict["roll_shortage_observed"] = checkListModel.isChecked
                    summaryDict["roll_shortage_observed_remark"] = checkListModel.remark
                case "Any marks Other Than SNS Face Stamp?" :
                    summaryDict["any_marks_other_than_sns_face_stamp"] = checkListModel.isChecked
                    summaryDict["any_marks_other_than_sns_face_stamp_remark"] = checkListModel.remark
                case "Did Inspection report Signed by Mill?" :
                    summaryDict["did_inspection_report_signed_by_mill"] = checkListModel.isChecked
                    summaryDict["did_inspection_report_signed_by_mill_remark"] = checkListModel.remark
                default:
                    print("default")
                }
            })
            summaryDict["comment"] = checkList.comments
            summaryDict["comments"] = checkList.comments
        }
        postData["summary"] = summaryDict
        print("PostData : \(postData)")
        
        IHProgressHUD.show()
        
        WebServiceApi.performRequestWithURL(url: "\(BaseURL)/\(ADD_INSPECTION)", dict: postData) { (responseObj) in
            if responseObj is NSNull {
                completion(NSDictionary())
                return
            }
            do {
                let data: Data = responseObj as! Data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                print("JSOn : \(jsonObj)")
                completion(jsonObj)
            } catch {
                completion(NSDictionary())
            }
             completion(NSDictionary())
        }
        

        
    }
    
}
