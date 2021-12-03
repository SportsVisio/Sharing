//
//  AccountModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 11, 2021

import Foundation
import SwiftyJSON


class AccountModel : NSObject, NSCoding{

    var createdAt : String!
    var devices : [Device]!
    var id : String!
    var inactive : Bool!
    var leagues : [League]!
    var members : [String]!
    var scheduledGames : [ScheduledGame]!
    var teams : [Team]!
    var updatedAt : String!

	/**
	 * Instantiate the instance using the passed json values to set the properties values
	 */
	init(fromJson json: JSON!){
		if json.isEmpty{
			return
		}
        createdAt = json["createdAt"].stringValue
        devices = [Device]()
        let devicesArray = json["devices"]
        for devicesJson in devicesArray{
            let value = Device(fromJson: devicesJson.1)
            devices.append(value)
        }
        id = json["id"].stringValue
        inactive = json["inactive"].boolValue
        leagues = [League]()
        let leaguesArray = json["leagues"]
        for leaguesJson in leaguesArray{
            let value = League(fromJson: leaguesJson.1)
            leagues.append(value)
        }
        members = [String]()
        let membersArray = json["members"]
        for membersJson in membersArray{
            members.append(membersJson.1.stringValue)
        }
        scheduledGames = [ScheduledGame]()
        let scheduledGamesArray = json["scheduledGames"]
        for scheduledGamesJson in scheduledGamesArray{
            let value = ScheduledGame(fromJson: scheduledGamesJson.1)
            scheduledGames.append(value)
        }
        teams = [Team]()
        let teamsArray = json["teams"]
        for teamsJson in teamsArray{
            let value = Team(fromJson: teamsJson.1)
            teams.append(value)
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
        if devices != nil{
        var dictionaryElements = [[String:Any]]()
        for devicesElement in devices {
        	dictionaryElements.append(devicesElement.toDictionary())
        }
        dictionary["devices"] = dictionaryElements
        }
        if id != nil{
        	dictionary["id"] = id
        }
        if inactive != nil{
        	dictionary["inactive"] = inactive
        }
        if leagues != nil{
        var dictionaryElements = [[String:Any]]()
        for leaguesElement in leagues {
        	dictionaryElements.append(leaguesElement.toDictionary())
        }
        dictionary["leagues"] = dictionaryElements
        }
        if members != nil{
        	dictionary["members"] = members
        }
        if scheduledGames != nil{
        var dictionaryElements = [[String:Any]]()
        for scheduledGamesElement in scheduledGames {
        	dictionaryElements.append(scheduledGamesElement.toDictionary())
        }
        dictionary["scheduledGames"] = dictionaryElements
        }
        if teams != nil{
        var dictionaryElements = [[String:Any]]()
        for teamsElement in teams {
        	dictionaryElements.append(teamsElement.toDictionary())
        }
        dictionary["teams"] = dictionaryElements
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
		devices = aDecoder.decodeObject(forKey: "devices") as? [Device]
		id = aDecoder.decodeObject(forKey: "id") as? String
		inactive = aDecoder.decodeObject(forKey: "inactive") as? Bool
		leagues = aDecoder.decodeObject(forKey: "leagues") as? [League]
		members = aDecoder.decodeObject(forKey: "members") as? [String]
		scheduledGames = aDecoder.decodeObject(forKey: "scheduledGames") as? [ScheduledGame]
		teams = aDecoder.decodeObject(forKey: "teams") as? [Team]
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
		if devices != nil{
			aCoder.encode(devices, forKey: "devices")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if inactive != nil{
			aCoder.encode(inactive, forKey: "inactive")
		}
		if leagues != nil{
			aCoder.encode(leagues, forKey: "leagues")
		}
		if members != nil{
			aCoder.encode(members, forKey: "members")
		}
		if scheduledGames != nil{
			aCoder.encode(scheduledGames, forKey: "scheduledGames")
		}
		if teams != nil{
			aCoder.encode(teams, forKey: "teams")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updatedAt")
		}

	}

}
