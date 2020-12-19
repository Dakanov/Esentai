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
    func sendOTP(params : [String: AnyObject], callback: @escaping (SMSObject?) -> ()) {
        Alamofire.request("https://esentai-shop.kz/wp-json/digits/v1/send_otp", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseObject{
            (response: DataResponse<SMSObject>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
            }
        }
    }
    func verifyOtp(params : [String: AnyObject], callback: @escaping (SMSObject?) -> ()) {
        Alamofire.request("https://esentai-shop.kz/wp-json/digits/v1/verify_otp", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseObject{
            (response: DataResponse<SMSObject>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
            }
        }
    }
    
    func createUser(params : [String: AnyObject], callback: @escaping (UserData?) -> ()) {
        Alamofire.request("https://esentai-shop.kz/wp-json/digits/v1/create_user", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseObject{
            (response: DataResponse<UserData>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
            }
        }
    }
    func login(params : [String: AnyObject], callback: @escaping (UserData?) -> ()) {
        Alamofire.request("https://esentai-shop.kz/wp-json/digits/v1/login_user", method: .post, parameters: params, encoding: URLEncoding.default, headers: nil).responseObject{
            (response: DataResponse<UserData>) in
            if let _ = response.response{
                let model = response.result
                callback(model.value ?? nil)
            }
        }
    }
    
}
