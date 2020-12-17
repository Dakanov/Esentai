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
