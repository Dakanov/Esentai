//
//  ViewController.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy

class ViewController: UIViewController {

    let nameTitle = UIImageView()
    let registerButton = CustomButton()
    let loginButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nav()
        setViews()
        setBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        self.navigationController?.isNavigationBarHidden = true
    }
    func setViews() {
        let image = UIImageView(image: #imageLiteral(resourceName: "backGroundImage"))
        image.contentMode = .scaleAspectFit
        self.view.addSubview(image)
        image.easy.layout(Edges())
        
        
        view.addSubview(nameTitle)
        nameTitle.easy.layout(Left(32),CenterY(-130),Width(223),Height(78))
        self.nameTitle.image = #imageLiteral(resourceName: "esentai-gourmet-logo-left 1")
        
        view.addSubview(registerButton)
        registerButton.set(title: "РЕГИСТРАЦИЯ", background: #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1))
        registerButton.easy.layout(CenterY(-7),Height(56),Left(32),Right(93))
        registerButton.addTarget(self, action: #selector(registerPressed(_:)), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.set(title: "ВОЙТИ")
        loginButton.easy.layout(CenterY(61),Height(56),Left(32),Right(93))
        loginButton.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)
    }
    func nav(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    @objc func loginPressed(_ sender:UIButton){
        LoginVC.open(vc: self)
    }
    @objc func registerPressed(_ sender:UIButton){
        RegisterVC.open(vc: self)
    }


}

