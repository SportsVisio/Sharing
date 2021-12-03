//
//  ServicesManager.swift
//  CCO-iOS
//
//  Created by Jahan on 6/6/20.
//  Copyright © 2020 Jahan. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

extension NetworkManager {
    
    func registerStream(parameters: Parameters, completion: @escaping (DataResponse<String>) -> Void) {
        sendPostRequest(url: Constants.EndPonts.registerStream + "\(Constants.deviceId)", parameters: parameters, completion: completion)
    }
    
    func attachDevice(parameters: Parameters, completion: @escaping (DataResponse<String>) -> Void) {
        sendPostRequest(url: Constants.EndPonts.attachDevice, parameters: parameters, completion: completion)
    }
    
    
    func updateDevice( completion: @escaping (DataResponse<String>) -> Void) {
        sendPutRequest(url: Constants.EndPonts.updateDevice + "\(AppHelper.instance.scheduledGame?.deviceGameAssn.first?.id ?? "N/A")", parameters: ["":""], completion: completion)
    }
    
    func startStream( completion: @escaping (DataResponse<String>) -> Void) {
        sendGetRequest(url: Constants.EndPonts.startStream + "\(AppHelper.instance.scheduledGame?.deviceGameAssn.first?.id ?? "N/A")", parameters: ["":""], completion: completion)
    }
    
    func getAccount(completion: @escaping (DataResponse<String>) -> Void) {
        sendGetRequest(url: Constants.EndPonts.getAccount, parameters: ["":""], completion: completion)
    }
    
    //sendPutRequest
    func stopStream( completion: @escaping (DataResponse<String>) -> Void) {
        sendGetRequest(url: Constants.EndPonts.stopStream + "\(AppHelper.instance.scheduledGame?.deviceGameAssn.first?.id ?? "N/A")", parameters: ["":""], completion: completion)
    }
   
}
