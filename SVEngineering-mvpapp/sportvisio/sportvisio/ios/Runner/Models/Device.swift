//
//  Device.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 11, 2021

import Foundation
import SwiftyJSON


class Device : NSObject, NSCoding{

    var createdAt : String!
    var deletedAt : String!
    var deviceId : String!
    var id : String!
    var name : String!
    var stream : Stream!
    var updatedAt : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        createdAt = json["createdAt"].stringValue
        deletedAt = json["deletedAt"].stringValue
        deviceId = json["deviceId"].stringValue
        id = json["id"].stringValue
        name = json["name"].stringValue
        let streamJson = json["stream"]
        if !streamJson.isEmpty{
            stream = Stream(fromJson: streamJson)
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
        if deletedAt != nil{
        	dictionary["deletedAt"] = deletedAt
        }
        if deviceId != nil{
        	dictionary["deviceId"] = deviceId
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if name != nil{
        	dictionary["name"] = name
        }
        if stream != nil{
        	dictionary["stream"] = stream.toDictionary()
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
		deletedAt = aDecoder.decodeObject(forKey: "deletedAt") as? String
		deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String
		id = aDecoder.decodeObject(forKey: "id") as? String
		name = aDecoder.decodeObject(forKey: "name") as? String
		stream = aDecoder.decodeObject(forKey: "stream") as? Stream
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
		if deletedAt != nil{
			aCoder.encode(deletedAt, forKey: "deletedAt")
		}
		if deviceId != nil{
			aCoder.encode(deviceId, forKey: "deviceId")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if stream != nil{
			aCoder.encode(stream, forKey: "stream")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}

	}

}
