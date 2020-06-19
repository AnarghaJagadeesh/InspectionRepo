//
//  WebServiceApi.swift
//  Inspection
//
//  Created by Beegins on 19/05/20.
//  Copyright © 2020 CodeGreen. All rights reserved.
//

import Foundation

open class WebServiceApi: NSObject {
    
    class func performRequestWithURL(url :String, dict : [String : Any], completion:@escaping (_ responseData : AnyObject)-> Void){
        
        // print("current URL \(url)")
        let urlString : String = url.trimmingCharacters(in: .whitespacesAndNewlines)
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let currentUrl: URL = URL.init(string: urlString){
                
                let request = NSMutableURLRequest(url : currentUrl)
                
                //initilise request
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                let user = AppSettings.getCurrentUser()
                if user.token != "" {
                    request.setValue("Bearer \(user.token)", forHTTPHeaderField: "Authorization")
                    
                }
                request.httpMethod = "POST";
                //                print("request dictionary \(dict)")
                
                let postData = try! JSONSerialization.data(withJSONObject: dict, options: [])
                
                request.httpBody = postData
                
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    
                    
                    guard error == nil && data != nil else{
                        
                        completion(data as AnyObject)
                        // print("Error found \(String(describing: error))")
                        return
                    }
                    DispatchQueue.main.async {
                        
                        completion(data! as AnyObject)
                        
                    }
                    
                })
                
                task.resume()
            }
            
        }
    }
    
    class func performRequestWithURLGET(url :String, completion:@escaping (_ responseData : AnyObject)-> Void){
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let currentUrl: URL = URL.init(string: url){
                
                let request = NSMutableURLRequest(url : currentUrl)
                
                request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
                request.httpMethod = "GET";
                
                let user = AppSettings.getCurrentUser()
                if user.token != "" {
                    request.setValue("Bearer \(user.token)", forHTTPHeaderField: "Authorization")
                    
                }
                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
                    
                    guard error == nil && data != nil else{
                        
                        completion(data as AnyObject)
                        //                        print("Error found \(String(describing: error))")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        
                        completion(data! as AnyObject)
                        
                    }
                    
                })
                
                task.resume()
            }
            
        }
        
        
    }
    
    
    
}
