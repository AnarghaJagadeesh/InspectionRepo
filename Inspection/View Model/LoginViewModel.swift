//
//  LoginViewModel.swift
//  Inspection
//
//  Created by Beegins on 19/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import UIKit
import var CommonCrypto.CC_MD5_DIGEST_LENGTH
import func CommonCrypto.CC_MD5
import typealias CommonCrypto.CC_LONG



//Test:
//let md5Data = MD5(string:"Hello")
//
//let md5Hex =  md5Data.map { String(format: "%02hhx", $0) }.joined()
//print("md5Hex: \(md5Hex)")
//
//let md5Base64 = md5Data.base64EncodedString()
//print("md5Base64: \(md5Base64)")


class LoginViewModel: NSObject {
    
    var basicFirstModel = [BasicFirstStruct]()
    
    func performLoginApi(username : String, password : String, completion: @escaping (_ responseData: NSDictionary) -> Void){
        
        let passwordEncrypted = MD5(string: password)
        
        var dict = [String : Any]()
        let urlString = "\(BaseURL)/\(LOGIN)"
        dict["username"] = username
        dict["password"] = passwordEncrypted
        WebServiceApi.performRequestWithURL(url: urlString, dict: dict) { (responseObj) in
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
        }
        
    }
    
    func performFetchFabricApi(completion: @escaping (_ isDone: Bool) -> Void){
        let urlString = "\(BaseURL)/\(FABRIC)"
        WebServiceApi.performRequestWithURLGET(url: urlString) { (responseObj) in
            if responseObj is NSNull {
                completion(false)
                return
            }
            do {
                let data: Data = responseObj as! Data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                print("JSOn : \(jsonObj)")
                if let status = jsonObj["status"] as? String {
                    if status == StatusCode.success.rawValue {
                        var fabricArray = [[String : Any]]()
                        if let data = jsonObj["data"] as? [[String : Any]] {
                            _ = data.map({ (fabricDict) in
                                fabricArray.append(fabricDict)
                            })
                            UserDefaults.standard.set(fabricArray, forKey: "fabricType")
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    func performInspectionListApi(completion: @escaping (_ isDone: Bool) -> Void){
        let urlString = "\(BaseURL)/\(INSPECTION_LIST)"
        WebServiceApi.performRequestWithURLGET(url: urlString) { (responseObj) in
            if responseObj is NSNull {
                completion(false)
                return
            }
            do {
                let data: Data = responseObj as! Data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                print("JSOn : \(jsonObj)")
                if let status = jsonObj["status"] as? String {
                    if status == StatusCode.success.rawValue {
                        self.basicFirstModel = []
                        if let data = jsonObj["data"] as? [[String : Any]] {
                            _ = data.map({ (inspectionDict) in
                                self.basicFirstModel.append(BasicFirstStruct(dict: inspectionDict, isApi: true))
                            })
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    func performFetchFabricCategoryApi(completion: @escaping (_ isDone: Bool) -> Void){
        let urlString = "\(BaseURL)/\(FABRIC_CATEGORY)"
        WebServiceApi.performRequestWithURLGET(url: urlString) { (responseObj) in
            if responseObj is NSNull {
                completion(false)
                return
            }
            do {
                let data: Data = responseObj as! Data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                print("JSOn : \(jsonObj)")
                if let status = jsonObj["status"] as? String {
                    if status == StatusCode.success.rawValue {
                        var fabricArray = [[String : Any]]()
                        if let data = jsonObj["data"] as? [[String : Any]] {
                            _ = data.map({ (fabricDict) in
                                fabricArray.append(fabricDict)
                            })
                            UserDefaults.standard.set(fabricArray, forKey: "fabricCategory")
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    
    func performRollListApi(completion: @escaping (_ isDone: Bool) -> Void){
        let urlString = "\(BaseURL)/\(ROLL_LIST)"
        WebServiceApi.performRequestWithURLGET(url: urlString) { (responseObj) in
            if responseObj is NSNull {
                completion(false)
                return
            }
            do {
                let data: Data = responseObj as! Data
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                print("JSOn : \(jsonObj)")
                if let status = jsonObj["status"] as? String {
                    if status == StatusCode.success.rawValue {
                        var rollArray = [[String : Any]]()
                        if let data = jsonObj["data"] as? [[String : Any]] {
                            _ = data.map({ (rollDict) in
                                rollArray.append(rollDict)
                            })
                            UserDefaults.standard.set(rollArray, forKey: "rollList")
                            completion(true)
                        }
                    }
                } else {
                    completion(false)
                }
            } catch {
                print(error)
                completion(false)
            }
        }
    }
    
    
    func MD5(string: String) -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: length)

        _ = digestData.withUnsafeMutableBytes { digestBytes -> UInt8 in
            messageData.withUnsafeBytes { messageBytes -> UInt8 in
                if let messageBytesBaseAddress = messageBytes.baseAddress, let digestBytesBlindMemory = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(messageData.count)
                    CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBlindMemory)
                }
                return 0
            }
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digestData[index])
        }
        return digestHex
    }
}
