//
//  Objects.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//


import Foundation
import ObjectMapper


class RootClass : NSObject, Mappable{

    var accountkit : Int?
    var code : Int?
    var firebase : Int?
    var message : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        accountkit <- map["accountkit"]
        code <- map["code"]
        firebase <- map["firebase"]
        message <- map["message"]
        
    }
}
class SMSObject : NSObject, Mappable{

    var accountkit : Int?
    var code : Int?
    var firebase : Int?
    var message : String?

    required init?(map: Map){}

    func mapping(map: Map)
    {
        accountkit <- map["accountkit"]
        code <- map["code"]
        firebase <- map["firebase"]
        message <- map["message"]
        
    }
}


class UserData : NSObject, NSCoding, Mappable{

    var data : Data?
    var success : Bool?


    class func newInstance(map: Map) -> Mappable?{
        return UserData()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        data <- map["data"]
        success <- map["success"]
        
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         data = aDecoder.decodeObject(forKey: "data") as? Data
         success = aDecoder.decodeObject(forKey: "success") as? Bool

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }

    }

}

class Data : NSObject, NSCoding, Mappable{

    var accessToken : String?
    var tokenType : String?
    var userId : String?
    var code : String?
    var level : Int?
    var msg : String?

    class func newInstance(map: Map) -> Mappable?{
        return Data()
    }
    required init?(map: Map){}
    private override init(){}

    func mapping(map: Map)
    {
        accessToken <- map["access_token"]
        tokenType <- map["token_type"]
        userId <- map["user_id"]
        level <- map["level"]
        code <- map["code"]
        msg <- map["msg"]
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         accessToken = aDecoder.decodeObject(forKey: "access_token") as? String
         tokenType = aDecoder.decodeObject(forKey: "token_type") as? String
         userId = aDecoder.decodeObject(forKey: "user_id") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "access_token")
        }
        if tokenType != nil{
            aCoder.encode(tokenType, forKey: "token_type")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }

    }

}
