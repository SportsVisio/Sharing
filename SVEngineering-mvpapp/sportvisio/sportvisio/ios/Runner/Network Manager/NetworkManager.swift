//
//  NetworkManager.swift
//  JUST CHILL
//
//  Created by khawer Nisar on 11/12/18.
//  Copyright © 2018 Rehan Saleem. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

class NetworkManager: NSObject {
    
    static let sharedInstance = NetworkManager()
   
    func sendPostRequest(url: String, parameters: Parameters, completion: @escaping (DataResponse<String>) -> Void) -> Void {
        
        if !NetworkConnection.isConnectedToNetwork() {
            AlertControllerHelper.showAlertWithAction(message: "Your internet connection smeed to be offline") { (success) in
                if let topVC = UIApplication.topViewController() {
                    MBProgressHUD.hide(for: topVC.view, animated: true)
                }
            }
            
            return
        }
        let api = "\(Constants.BaseUrl)\(url)"
        print(api)
        let headers : HTTPHeaders = [
            "Content-Type" : Constants.contentType,
            "Authorization": "\(Constants.tokenType) \(Constants.idToken)",
        ]
        print(headers)
        print(parameters)
        
        Alamofire.request(api, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            do {
                if response.error != nil {
                    print(response.error)
                }else{
                    let str = String(data: response.data!, encoding: .utf8)
                    print(str)
                    let json = try JSON(data: response.data!)
                    print(json)
                }
                completion(response)
            }catch{
                print(error.localizedDescription)
                completion(response)
            }
        }
        
    }
    
    func sendDeleteRequest(url: String, parameters: Parameters, completion: @escaping (DataResponse<String>) -> Void) -> Void {
        
        if !NetworkConnection.isConnectedToNetwork() {
            AlertControllerHelper.showAlertWithAction(message: "Your internet connection smeed to be offline") { (success) in
                if let topVC = UIApplication.topViewController() {
                    MBProgressHUD.hide(for: topVC.view, animated: true)
                }
            }
            
            return
        }
        let api = "\(Constants.BaseUrl)\(url)"
        print(api)
        let headers : HTTPHeaders = [
            "Content-Type" : Constants.contentType,
            "Authorization": "\(Constants.tokenType) \(Constants.idToken)",
        ]
        print(headers)
        print(parameters)
        
        Alamofire.request(api, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            do {
                if response.error != nil {
                    print(response.error)
                }else{
                    let str = String(data: response.data!, encoding: .utf8)
                    print(str)
                    let json = try JSON(data: response.data!)
                    print(json)
                }
                completion(response)
            }catch{
                print(error.localizedDescription)
                completion(response)
            }
        }
        
    }
    
    func sendGetRequest(url: String, parameters: Parameters, completion: @escaping (DataResponse<String>) -> Void) -> Void {
        
        if !NetworkConnection.isConnectedToNetwork() {
            AlertControllerHelper.showAlertWithAction(message: "Your internet connection smeed to be offline") { (success) in
                if let topVC = UIApplication.topViewController() {
                    MBProgressHUD.hide(for: topVC.view, animated: true)
                }
            }
            
            return
        }
        let api = "\(Constants.BaseUrl)\(url)"
        print(api)
        let headers : HTTPHeaders = [
            "Content-Type" : Constants.contentType,
            "Authorization": "\(Constants.tokenType) \(Constants.idToken)",
        ]
        print(headers)
        print(parameters)
        
        Alamofire.request(api, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            do {
                if response.error != nil {
                    print(response.error)
                }else{
                    let str = String(data: response.data!, encoding: .utf8)
                    print(str)
                    let json = try JSON(data: response.data!)
                    print(json)
                }
                completion(response)
            }catch{
                print(error.localizedDescription)
                completion(response)
            }
        }
        
    }
    
    func sendPutRequest(url: String, parameters: Parameters, completion: @escaping (DataResponse<String>) -> Void) -> Void {
        
        if !NetworkConnection.isConnectedToNetwork() {
            AlertControllerHelper.showAlertWithAction(message: "Your internet connection smeed to be offline") { (success) in
                if let topVC = UIApplication.topViewController() {
                    MBProgressHUD.hide(for: topVC.view, animated: true)
                }
            }
            
            return
        }
        let api = "\(Constants.BaseUrl)\(url)"
        print(api)
        let headers : HTTPHeaders = [
            "Content-Type" : Constants.contentType,
            "Authorization": "\(Constants.tokenType) \(Constants.idToken)",
        ]
        print(headers)
        print(parameters)
        
        Alamofire.request(api, method: .put, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseString { (response) in
            do {
                if response.error != nil {
                    print(response.error)
                }else{
                    let str = String(data: response.data!, encoding: .utf8)
                    print(str)
                    let json = try JSON(data: response.data!)
                    print(json)
                }
                completion(response)
            }catch{
                print(error.localizedDescription)
                completion(response)
            }
        }
        
    }
    
    
    
 
}
