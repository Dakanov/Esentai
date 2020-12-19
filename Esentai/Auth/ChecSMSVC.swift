//
//  ChecSMSVC.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy

class ChecSMSVC: ScrollStackController,UITextFieldDelegate {

    let topTitle = UILabel()
    let titleLabel = UILabel()
    let first = UITextField()
    let second = UITextField()
    let third = UITextField()
    let fours = UITextField()
    let fives = UITextField()
    let six = UITextField()
    
    let textStack = UIStackView()
    var register = false
    var registerParams : [String:AnyObject] = [:]
    var smsParams : [String:AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        hideKeyboardWhenTappedAround()
        first.becomeFirstResponder()
    }
    
    func setViews(){
        topTitle.set(title: "Верификация", font: .systemFont(ofSize: 32))
        var number = "(700) 000 0000"
        if let userNumber = (self.smsParams["mobileNo"] as? String ){
            number = userNumber
        }
        
        let phone = "+7 \(number)"
        titleLabel.set(title: "Введите SMS-код, присланный на \(phone)", font: .systemFont(ofSize: 20),numberOfLines: 0)
        setTexfieldSettings()
        bottomStack()
    }
    func setTexfieldSettings(){
        textStack.axis = .horizontal
        textStack.alignment = .fill
        textStack.distribution = .fillEqually
        textStack.spacing = 4
        textStack.addArrangedSubview(first)
        textStack.addArrangedSubview(second)
        textStack.addArrangedSubview(third)
        textStack.addArrangedSubview(fours)
        textStack.addArrangedSubview(fives)
        textStack.addArrangedSubview(six)
        
        stackView.addArrangedSubview(topTitle)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(SizedBox(height: 20))
        stackView.addArrangedSubview(textStack)
        
        textFieldSize(t: first)
        textFieldSize(t: second)
        textFieldSize(t: third)
        textFieldSize(t: fours)
        textFieldSize(t: fives)
        textFieldSize(t: six)
        first.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        second.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        third.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        fours.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        fives.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        six.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
    }
    func bottomStack(){
        let prefix = UILabel()
        prefix.numberOfLines = 0
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.gray]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                      NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                      NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attributedString1 = NSMutableAttributedString(string:"Не пришло SMS?  ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"Переслать", attributes:attrs2)
        attributedString1.append(attributedString2)
        prefix.attributedText = attributedString1
        prefix.textAlignment = .center
        stackView.addArrangedSubview(SizedBox(height: 30))
        self.stackView.addArrangedSubview(prefix)
        prefix.addTapGestureRecognizer {
            print("Send again")
        }
    }
    @objc func didChange(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField == self.first {
                self.second.becomeFirstResponder()
            } else if textField == self.second {
                self.third.becomeFirstResponder()
            } else if textField == self.third {
                self.fours.becomeFirstResponder()
            } else if textField == self.fours {
                self.fives.becomeFirstResponder()
            }  else if textField == self.fives {
                self.six.becomeFirstResponder()
            } else if textField == self.six {
                self.verifyOTP()
            }
            textField.backgroundColor = UIColor.black
        } else {
            self.clearData()
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.clearData()
        textField.resignFirstResponder()
        return true
    }
    
    func sendData(){
        if register {
            registerReq()
        } else  {
            loginReq()
        }
    }
    func registerReq(){
        startLoading()
        Requests.shared().createUser(params: registerParams) { (result) in
            self.stopLoading()
            if let m = result?.data?.msg {
                self.showAlert(withTitle: "Внимание", withMessage: m)
            }
        }
    }
    func loginReq(){
        startLoading()
        smsParams.removeValue(forKey: "type")
        if let number = smsParams["mobileNo"] as? String {
            smsParams.removeValue(forKey: "mobileNo")
            smsParams["user"] = number as AnyObject
        }
        Requests.shared().login(params: smsParams) { (result) in
            self.stopLoading()
            if let m = result?.data?.msg {
                self.showAlert(withTitle: "Внимание", withMessage: m)
            }
            if let token = result?.data?.accessToken {
                UserDefaults.standard.setValue(token, forKey: "token")
                self.showAlert(withTitle: "token", withMessage: token)
            }
        }
    }
    func verifyOTP(){
        let otp = "\(first.text ?? "")\(second.text ?? "")\(third.text ?? "")\(fours.text ?? "")\(fives.text ?? "")\(six.text ?? "")"
        self.registerParams["otp"] = otp as AnyObject
        self.smsParams["otp"] = otp as AnyObject
        self.smsParams["type"] = (register ? "register" : "login") as AnyObject
        startLoading()
        Requests.shared().verifyOtp(params: self.smsParams) { (sms) in
            self.stopLoading()
            if let m = sms?.message  {
                self.showAlert(withTitle: "Внимание", withMessage: m)
            }
            if let code = sms?.code, code == 1 {
                self.sendData()
            }
        }
    }
    
    func clearData(){
        first.becomeFirstResponder()
        first.text = ""
        second.text = ""
        third.text = ""
        fours.text = ""
        fives.text = ""
        six.text = ""
        first.backgroundColor = .white
        second.backgroundColor = .white
        third.backgroundColor = .white
        fours.backgroundColor = .white
        fives.backgroundColor = .white
        six.backgroundColor = .white
    }
    
    func textFieldSize(t : UITextField){
        t.delegate = self
        t.layer.cornerRadius = 8
        t.easy.layout(Height(64))
        t.font = .systemFont(ofSize: 32)
        t.layer.borderWidth = 1
        t.textColor = .white
        t.textAlignment = .center
        t.keyboardType = .numberPad
    }
    static func open(vc:UIViewController, register : Bool = false, params : [String:AnyObject] = [:],SMSparams : [String:AnyObject] = [:]) {
        let vcc = ChecSMSVC()
        vcc.register = register
        vcc.registerParams = params
        vcc.smsParams = SMSparams
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }
}
