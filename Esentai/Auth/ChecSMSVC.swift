//
//  ChecSMSVC.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy

class ChecSMSVC: ScrollStackController {

    let topTitle = UILabel()
    let titleLabel = UILabel()
    let first = UITextField()
    let second = UITextField()
    let third = UITextField()
    let fours = UITextField()
    let textStack = UIStackView()
    var register = false
    var registerParams : [String:AnyObject] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        hideKeyboardWhenTappedAround()
        first.becomeFirstResponder()
    }
    
    func setViews(){
        topTitle.set(title: "Верификация", font: .systemFont(ofSize: 32))
        titleLabel.set(title: "Введите SMS-код, присланный на  +7 (700) 000 0000", font: .systemFont(ofSize: 20),numberOfLines: 0)
        
        textStack.axis = .horizontal
        textStack.alignment = .fill
        textStack.distribution = .equalCentering
        textStack.spacing = 16
        textStack.addArrangedSubview(first)
        textStack.addArrangedSubview(second)
        textStack.addArrangedSubview(third)
        textStack.addArrangedSubview(fours)
        
        stackView.addArrangedSubview(topTitle)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(SizedBox(height: 20))
        stackView.addArrangedSubview(textStack)
        
        textFieldSize(t: first)
        textFieldSize(t: second)
        textFieldSize(t: third)
        textFieldSize(t: fours)
        first.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        second.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        third.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        fours.addTarget(self, action: #selector(didChange(_:)), for: .editingChanged)
        bottomStack()
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
            } else {
                self.sendData()
            }
            textField.backgroundColor = UIColor.black
        } else {
            self.clearData()
        }
    }
    
    func sendData(){
        if register {
            registerReq()
        } else  {
            loginReq()
        }
    }
    func registerReq(){
        let otp = "\(first.text ?? "")\(second.text ?? "")\(third.text ?? "")\(fours.text ?? "")"
        self.registerParams["otp"] = otp as AnyObject
        Requests.shared().createUser(params: registerParams) { (ss) in
            
        }
    }
    func loginReq(){
        
    }
    
    func clearData(){
        first.becomeFirstResponder()
        first.text = ""
        second.text = ""
        third.text = ""
        fours.text = ""
        first.backgroundColor = .white
        second.backgroundColor = .white
        third.backgroundColor = .white
        fours.backgroundColor = .white
    }
    
    func textFieldSize(t : UITextField){
        t.layer.cornerRadius = 8
        t.easy.layout(Width(64),Height(64))
        t.font = .systemFont(ofSize: 32)
        t.layer.borderWidth = 1
        t.textColor = .white
        t.textAlignment = .center
        t.keyboardType = .numberPad
    }
    static func open(vc:UIViewController, register : Bool = false, params : [String:AnyObject] = [:]) {
        let vcc = ChecSMSVC()
        vcc.register = register
        vcc.registerParams = params
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }
}
