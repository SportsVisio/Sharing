//
//  VideoViewControllerNetowrkExtension.swift
//  Runner
//
//  Created by Jahan on 09/08/2021.
//

import UIKit
import MBProgressHUD
import SwiftyJSON
import Alamofire

extension VideoViewController {
    
    func registerStreaming(params : Parameters){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkManager.sharedInstance.registerStream(parameters: params) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.error != nil) {
                print(response.error ?? "Error")
                AlertControllerHelper.showAlert(message: response.error?.localizedDescription ?? "Error in api call.")
                return
            }
            if response.error == nil {
                do {
                    let jsonData = try JSON(data: response.data!)
                    print(jsonData)
                    let status = jsonData["status"].boolValue
                    if status {
                        let data = jsonData["message"]
                       
                    }else{
                        let msg = jsonData
                        print(msg)
                        //AlertControllerHelper.showAlert(message: "\(msg)")
                    }
                } catch{
                    print(error.localizedDescription)
                   // AlertControllerHelper.showAlert(message: error.localizedDescription)
                }
            }else {
                print(Error.self)
               // AlertControllerHelper.showAlert(message: "")
            }
        }
    }
    
    func attachDevice(params : Parameters){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkManager.sharedInstance.attachDevice(parameters: params) { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.error != nil) {
                print(response.error ?? "Error")
                AlertControllerHelper.showAlert(message: response.error?.localizedDescription ?? "Error in api call.")
                return
            }
            if response.error == nil {
                do {
                    self.getAccountInfo()
                    let jsonData = try JSON(data: response.data!)
                    print(jsonData)
                    let status = jsonData["status"].boolValue
                    if status {
                        let data = jsonData["message"]
                       
                    }else{
                        let msg = jsonData
                        print(msg)
                        //AlertControllerHelper.showAlert(message: "\(msg)")
                    }
                } catch{
                    print(error.localizedDescription)
                   // AlertControllerHelper.showAlert(message: error.localizedDescription)
                }
            }else {
                print(Error.self)
               // AlertControllerHelper.showAlert(message: "")
            }
        }
    }
    
    func updateDevice(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkManager.sharedInstance.updateDevice() { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.error != nil) {
                print(response.error ?? "Error")
                AlertControllerHelper.showAlert(message: response.error?.localizedDescription ?? "Error in api call.")
                return
            }
            if response.error == nil {
                do {
                    let jsonData = try JSON(data: response.data!)
                    print(jsonData)
                    let status = jsonData["status"].boolValue
                    if status {
                        let data = jsonData["message"]
                       
                    }else{
                        let msg = jsonData
                        print(msg)
                        //AlertControllerHelper.showAlert(message: "\(msg)")
                    }
                } catch{
                    print(error.localizedDescription)
                   // AlertControllerHelper.showAlert(message: error.localizedDescription)
                }
            }else {
                print(Error.self)
               // AlertControllerHelper.showAlert(message: "")
            }
        }
    }
    
    func getAccountInfo(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkManager.sharedInstance.getAccount() { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.error != nil) {
                print(response.error ?? "Error")
                AlertControllerHelper.showAlert(message: response.error?.localizedDescription ?? "Error in api call.")
                return
            }
            if response.error == nil {
                do {
                    let jsonData = try JSON(data: response.data!)
                    print(jsonData)
                    let accountModel = AccountModel(fromJson: jsonData)
                    let gameModel = accountModel.scheduledGames.first { (model) -> Bool in
                        return model.id == Constants.gameId
                    }
                    AppHelper.instance.scheduledGame = gameModel
                    AppHelper.instance.accountModel = accountModel
                    
                } catch{
                    print(error.localizedDescription)
                   // AlertControllerHelper.showAlert(message: error.localizedDescription)
                }
            }else {
                print(Error.self)
               // AlertControllerHelper.showAlert(message: "")
            }
        }
    }
    
    func startStreaming(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkManager.sharedInstance.startStream() { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.error != nil) {
                print(response.error ?? "Error")
                AlertControllerHelper.showAlert(message: response.error?.localizedDescription ?? "Error in api call.")
                return
            }
            if response.error == nil {
                do {
                    let jsonData = try JSON(data: response.data!)
                    print(jsonData)
                    let status = jsonData["status"].boolValue
                    if status {
                        let data = jsonData["message"]
                       
                    }else{
                        let msg = jsonData
                        print(msg)
                        //AlertControllerHelper.showAlert(message: "\(msg)")
                    }
                } catch{
                    print(error.localizedDescription)
                   // AlertControllerHelper.showAlert(message: error.localizedDescription)
                }
            }else {
                print(Error.self)
               // AlertControllerHelper.showAlert(message: "")
            }
        }
    }
    
    func stopStreaming(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        NetworkManager.sharedInstance.stopStream() { (response) in
            MBProgressHUD.hide(for: self.view, animated: true)
            if (response.error != nil) {
                print(response.error ?? "Error")
                AlertControllerHelper.showAlert(message: response.error?.localizedDescription ?? "Error in api call.")
                return
            }
            if response.error == nil {
                do {
                    let jsonData = try JSON(data: response.data!)
                    print(jsonData)
                    let status = jsonData["status"].boolValue
                    if status {
                        let data = jsonData["message"]
                       
                    }else{
                        let msg = jsonData
                        print(msg)
                        //AlertControllerHelper.showAlert(message: "\(msg)")
                    }
                } catch{
                    print(error.localizedDescription)
                   // AlertControllerHelper.showAlert(message: error.localizedDescription)
                }
            }else {
                print(Error.self)
               // AlertControllerHelper.showAlert(message: "")
            }
        }
    }
}


extension VideoViewController : ConfirmRecordingDelegate {
    
    func btnYesAction(isPlay: Bool) {
        if isPlay {
            self.stopRecording()
        }else{
            self.startRecording()
        }
    }
    
    func btnNoAction(isPlay: Bool) {
        self.stopStreaming()
    }
    
    func btnEditGameAction(isPlay: Bool) {
        
    }
    
    func btnCancelRecordAction(isPlay: Bool) {
        self.stopRecordingAndGoBack()
    }
    
    
}
