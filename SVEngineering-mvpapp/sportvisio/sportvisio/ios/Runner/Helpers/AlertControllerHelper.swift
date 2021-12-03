//
//  AlertControllerHelper.swift
//  WorldSportsBuddies
//
//  Created by DCMac01 on 11/1/17.
//  Copyright © 2017 Devclan. All rights reserved.
//

import UIKit

class AlertControllerHelper {
    
    class func showAlert(message:String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default ,handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithCompletion(message:String , completion : @escaping (_ success : Bool) -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default ,handler: { action in
            completion(true)
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default ,handler: { action in
            completion(false)
            alert.dismiss(animated: true, completion: nil)
            
        }))
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithCompletionDestrcutiveConfiem(title : String,message:String , completion : @escaping (_ success : Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive ,handler: { action in
            completion(false)
            alert.dismiss(animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title: "Confirm", style: .default ,handler: { action in
            completion(true)
            alert.dismiss(animated: true, completion: nil)
            
        }))
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithTitleAndMessageCompletion(title: String, message:String , completion : @escaping (_ success : Bool) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default ,handler: { action in
            completion(true)
            alert.dismiss(animated: true, completion: nil)
            
        }))
        
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlertWithAction( message:String , completion : @escaping (_ success : Bool) -> Void) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default ,handler: { action in
            alert.dismiss(animated: true, completion: nil)
            completion(true)
            
        }))
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
    
    class func showAlert(style: UIAlertController.Style, title: String?, message: String?, actions: [UIAlertAction] = [UIAlertAction(title: "Ok", style: .cancel, handler: nil)], completion: (() -> Swift.Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        for action in actions {
            alert.addAction(action)
        }
        
        if let topVC = UIApplication.topViewController() {
            topVC.present(alert, animated: true, completion: nil)
        }
    }
}
