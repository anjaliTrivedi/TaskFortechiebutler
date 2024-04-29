//
//	RootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class RootClass : NSObject, NSCoding{

	var body : String!
	var it : Int!
	var title : String!
	var userId : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		body = dictionary["body"] as? String
		it = dictionary["id"] as? Int
		title = dictionary["title"] as? String
		userId = dictionary["userId"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if body != nil{
			dictionary["body"] = body
		}
		if it != nil{
			dictionary["id"] = it
		}
		if title != nil{
			dictionary["title"] = title
		}
		if userId != nil{
			dictionary["userId"] = userId
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         body = aDecoder.decodeObject(forKey: "body") as? String
         it = aDecoder.decodeObject(forKey: "id") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         userId = aDecoder.decodeObject(forKey: "userId") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if body != nil{
			aCoder.encode(body, forKey: "body")
		}
		if it != nil{
			aCoder.encode(it, forKey: "id")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if userId != nil{
			aCoder.encode(userId, forKey: "userId")
		}

	}

}
