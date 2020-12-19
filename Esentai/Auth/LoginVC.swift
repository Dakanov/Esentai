//
//  LoginVC.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit

class LoginVC: ScrollStackController {

    let topTitle = UILabel()
    let textField = CustomTextField()
    let loginButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
        setBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }

    func setViews(){
        stackView.addArrangedSubview(topTitle)
        topTitle.set(title: "Войти в систему", font: .systemFont(ofSize: 32))
        topTitle.textColor = .black
        
        stackView.addArrangedSubview(textField)
        textField.set(title: "Номер телефона")
        textField.textField.keyboardType = .phonePad
        textField.textField.becomeFirstResponder()
        textField.textField.placeholder = "(———) ——— ————"
        stackView.addArrangedSubview(SizedBox(height: 80))
        
        loginButton.set(title: "ВОЙТИ", background: #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1))
        loginButton.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)
        stackView.addArrangedSubview(loginButton)
        bottomStack()
    }
    func bottomStack(){
        let prefix = UILabel()
        prefix.numberOfLines = 0
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20), NSAttributedString.Key.foregroundColor : UIColor.gray]
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20),
                      NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,
                      NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1)] as [NSAttributedString.Key : Any]
        let attributedString1 = NSMutableAttributedString(string:"Нет в системе? ", attributes:attrs1)
        let attributedString2 = NSMutableAttributedString(string:"Создать аккаунт", attributes:attrs2)
        attributedString1.append(attributedString2)
        prefix.attributedText = attributedString1
        prefix.textAlignment = .center
        prefix.addTapGestureRecognizer {
            RegisterVC.open(vc: self)
        }
        self.stackView.addArrangedSubview(prefix)
    }
    @objc func loginPressed(_ sender:UIButton){
        guard let mobile = textField.textField.text, mobile.count == 10 else {
            self.textField.titleLabel.textColor = .red
            return }
        let p = [ "countrycode" : "+7",
                  "mobileNo": mobile,
                  "type":"login"
        ] as [String:AnyObject]
        startLoading()
        Requests.shared().sendOTP(params: p) { (r) in
            self.stopLoading()
            ChecSMSVC.open(vc: self,SMSparams: p)
        }
    }
    static func open(vc:UIViewController) {
        let vcc = LoginVC()
        if let nav = vc.navigationController {
            nav.pushViewController(vcc, animated: true)
        }
    }
}
