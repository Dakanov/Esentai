//
//  Requests.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class Requests: NSObject {

    private static var sharedReference : Requests{
            let headers = Requests()
            return headers
        }
        
        class func shared() -> Requests {
            return sharedReference
        }
    func sendOTP(params : [String: AnyObject], callback: @escaping (RootClass?) -> ()) {
        Alamofire.request("https://esentai-shop.kz/wp-json/digits/v1/send_otp", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RootClass>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
            }
        }
    }
    
    func createUser(params : [String: AnyObject], callback: @escaping (RootClass?) -> ()) {
        Alamofire.request("https://esentai-shop.kz/wp-json/digits/v1/create_user", method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RootClass>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
            }
        }
    }
    
}
