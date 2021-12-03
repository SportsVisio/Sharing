//
//  ScheduledGame.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 11, 2021

import Foundation
import SwiftyJSON


class ScheduledGame : NSObject, NSCoding{

    var createdAt : String!
    var descriptionField : String!
    var deviceGameAssn : [DeviceGameAssnModel]!
    var endTime : Int!
    var id : String!
    var startTime : Int!
    var teamGameAssn : [String]!
    var updatedAt : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        createdAt = json["createdAt"].stringValue
        descriptionField = json["description"].stringValue
        deviceGameAssn = [DeviceGameAssnModel]()
        let deviceGameAssnArray = json["deviceGameAssn"]
        for deviceGameAssnJson in deviceGameAssnArray{
            let model = DeviceGameAssnModel(fromJson: deviceGameAssnJson.1)
            deviceGameAssn.append(model)
        }
        endTime = json["endTime"].intValue
        id = json["id"].stringValue
        startTime = json["startTime"].intValue
        teamGameAssn = [String]()
        let teamGameAssnArray = json["teamGameAssn"]
        for teamGameAssnJson in teamGameAssnArray{
            teamGameAssn.append(teamGameAssnJson.1.stringValue)
        }
        updatedAt = json["updatedAt"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if createdAt != nil{
        	dictionary["createdAt"] = createdAt
        }
        if descriptionField != nil{
        	dictionary["description"] = descriptionField
        }
        if deviceGameAssn != nil{
        	dictionary["deviceGameAssn"] = deviceGameAssn
        }
        if endTime != nil{
        	dictionary["endTime"] = endTime
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if startTime != nil{
        	dictionary["startTime"] = startTime
        }
        if teamGameAssn != nil{
        	dictionary["teamGameAssn"] = teamGameAssn
        }
        if updatedAt != nil{
        	dictionary["updatedAt"] = updatedAt
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
		descriptionField = aDecoder.decodeObject(forKey: "description") as? String
		deviceGameAssn = aDecoder.decodeObject(forKey: "deviceGameAssn") as? [DeviceGameAssnModel]
		endTime = aDecoder.decodeObject(forKey: "endTime") as? Int
		id = aDecoder.decodeObject(forKey: "id") as? String
		startTime = aDecoder.decodeObject(forKey: "startTime") as? Int
		teamGameAssn = aDecoder.decodeObject(forKey: "teamGameAssn") as? [String]
		updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if descriptionField != nil{
			aCoder.encode(descriptionField, forKey: "description")
		}
		if deviceGameAssn != nil{
			aCoder.encode(deviceGameAssn, forKey: "deviceGameAssn")
		}
		if endTime != nil{
			aCoder.encode(endTime, forKey: "endTime")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if startTime != nil{
			aCoder.encode(startTime, forKey: "startTime")
		}
		if teamGameAssn != nil{
			aCoder.encode(teamGameAssn, forKey: "teamGameAssn")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}

	}

}
