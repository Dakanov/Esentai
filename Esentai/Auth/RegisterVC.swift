//
//  RegisterVC.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit

class RegisterVC: ScrollStackController {

    let name = CustomTextField()
    let phone = CustomTextField()
    let date = CustomTextField()
    let registerButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setViews()
        setBackButton()
    }
    
    func setViews(){
        stackView.spacing = 30
        let register = UILabel()
        register.set(title: "Регистрация", font: .systemFont(ofSize: 32), numberOfLines: 1)
        stackView.addArrangedSubview(register)
        
        name.set(title: "Фамилия Имя", prefixHidden: true)
        stackView.addArrangedSubview(name)
        
        phone.set(title: "Номер телефона",placeholder: "(———) ——— ————")
        phone.textField.keyboardType = .phonePad
        stackView.addArrangedSubview(phone)
        
        date.setDatePicker()
        stackView.addArrangedSubview(date)
        bottomView()
    }
    func bottomView(){
        let prefix = UILabel()
        prefix.numberOfLines = 0
        let attrs1 = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 18), NSAttributedString.Key.foregroundColor : UIColor.gray]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                      NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                      NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attributedString1 = NSMutableAttributedString(string:"Регистрируясь Вы соглашаетесь с ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"Правилами пользования", attributes:attrs2)
        attributedString1.append(attributedString2)
        prefix.attributedText = attributedString1

        stackView.addArrangedSubview(SizedBox(height: 30))
        self.stackView.addArrangedSubview(prefix)
        
        registerButton.set(title: "зарегистрироваться".uppercased(), background: #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1))
        registerButton.addTarget(self, action: #selector(registerPressed(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(registerButton)
    }
    
    @objc func registerPressed(_ sender:UIButton){
        guard let mobile = phone.textField.text, mobile.count == 10 else { return }
        guard let name = name.textField.text, name != "" else { return }
        guard let bDay = date.textField.text, bDay != "" else { return }
        let p = [ "countrycode" : "+7",
                  "mobileNo": mobile,
                  "type":"register"
        ] as [String:AnyObject]
        let userParams = [ "digits_reg_name" :  name,
                  "digits_reg_mobile": mobile,
                  "digits_reg_birth_date": bDay
        ] as [String:AnyObject]
        Requests.shared().sendOTP(params: p) { (r) in
            ChecSMSVC.open(vc: self, register: true, params: userParams)
        }
    }
    
    static func open(vc:UIViewController) {
        let vcc = RegisterVC()
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }

}
