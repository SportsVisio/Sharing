//
//  DeviceGameAssnModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 11, 2021

import Foundation
import SwiftyJSON


class DeviceGameAssnModel : NSObject, NSCoding{

    var annotations : [String]!
    var createdAt : String!
    var deletedAt : String!
    var endTime : Int!
    var id : String!
    var isActive : Bool!
    var startTime : Int!
    var updatedAt : String!
    var videoId : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        annotations = [String]()
        let annotationsArray = json["annotations"]
        for annotationsJson in annotationsArray{
            annotations.append(annotationsJson.1.stringValue)
        }
        createdAt = json["createdAt"].stringValue
        deletedAt = json["deletedAt"].stringValue
        endTime = json["endTime"].intValue
        id = json["id"].stringValue
        isActive = json["isActive"].boolValue
        startTime = json["startTime"].intValue
        updatedAt = json["updatedAt"].stringValue
        videoId = json["videoId"].stringValue
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
        if annotations != nil{
        	dictionary["annotations"] = annotations
        }
        if createdAt != nil{
        	dictionary["createdAt"] = createdAt
        }
        if deletedAt != nil{
        	dictionary["deletedAt"] = deletedAt
        }
        if endTime != nil{
        	dictionary["endTime"] = endTime
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if isActive != nil{
        	dictionary["isActive"] = isActive
        }
        if startTime != nil{
        	dictionary["startTime"] = startTime
        }
        if updatedAt != nil{
        	dictionary["updatedAt"] = updatedAt
        }
        if videoId != nil{
        	dictionary["videoId"] = videoId
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
		annotations = aDecoder.decodeObject(forKey: "annotations") as? [String]
		createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
		deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? String
		endTime = aDecoder.decodeObject(forKey: "endTime") as? Int
		id = aDecoder.decodeObject(forKey: "id") as? String
		isActive = aDecoder.decodeObject(forKey: "isActive") as? Bool
		startTime = aDecoder.decodeObject(forKey: "startTime") as? Int
		updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
		videoId = aDecoder.decodeObject(forKey: "videoId") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
	{
		if annotations != nil{
			aCoder.encode(annotations, forKey: "annotations")
		}
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "createdAt")
		}
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
		}
		if endTime != nil{
			aCoder.encode(endTime, forKey: "endTime")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if isActive != nil{
			aCoder.encode(isActive, forKey: "isActive")
		}
		if startTime != nil{
			aCoder.encode(startTime, forKey: "startTime")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}
		if videoId != nil{
			aCoder.encode(videoId, forKey: "videoId")
		}

	}

}
