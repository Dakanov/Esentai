//
//  ViewController.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy
import Firebase
import FirebaseAuth
import FBSDKLoginKit
import GoogleSignIn

class ViewController: UIViewController,LoginButtonDelegate {
  
    

    
    

    let nameTitle = UIImageView()
    let registerButton = CustomButton()
    let loginButton = CustomButton()
    let fbButton = FBLoginButton()
    let googlesignInButton = GIDSignInButton()
    let customGButton = UIImageView(image: #imageLiteral(resourceName: "GoogleBut"))
    let customFBButton = UIImageView(image: #imageLiteral(resourceName: "FaceBookB"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        googleAuth()
        faceBookAuth()
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
        nameTitle.addTapGestureRecognizer {
            self.navigationController?.pushViewController(WebViewVC(), animated: true)
        }
        
        view.addSubview(registerButton)
        registerButton.set(title: "РЕГИСТРАЦИЯ", background: #colorLiteral(red: 0.9411764706, green: 0.4862745098, blue: 0, alpha: 1))
        registerButton.easy.layout(CenterY(-7),Height(56),Left(32),Right(93))
        registerButton.addTarget(self, action: #selector(registerPressed(_:)), for: .touchUpInside)
        view.addSubview(loginButton)
        loginButton.set(title: "ВОЙТИ")
        loginButton.easy.layout(CenterY(61),Height(56),Left(32),Right(93))
        loginButton.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)
        
        let socNetLabel = UILabel()
        socNetLabel.set(title: "или войти с помощью".uppercased())
        self.view.addSubview(socNetLabel)
        self.view.addSubview(self.customFBButton)
        self.view.addSubview(self.customGButton)
        socNetLabel.easy.layout(Top(40).to(loginButton),Left(32))
        customFBButton.easy.layout(Top(80).to(loginButton),Left(32),Height(64),Width(64))
        customGButton.easy.layout(Top(80).to(loginButton),Left(16).to(customFBButton),Width(64),Height(64))
    }
    func nav(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
    }
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    func googleAuth(){
        GIDSignIn.sharedInstance()?.signOut()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        GIDSignIn.sharedInstance().delegate = self
        customGButton.addTapGestureRecognizer {
            GIDSignIn.sharedInstance().signIn()
        }
    }
    //MARK:- facebookLigonKit
    func faceBookAuth(){
        self.fbButton.delegate = self
        if let accessToken = AccessToken.current, !accessToken.isExpired { // User is logged in, do work such as go to next view controller.
            UserDefaults.standard.setValue(accessToken.tokenString, forKey: "token")
            self.showAlert(withTitle: "token", withMessage: accessToken.tokenString)
        }
        customFBButton.addTapGestureRecognizer {
            self.fbButton.sendActions(for: .touchUpInside)
        }
    }
    @objc func loginPressed(_ sender:UIButton){
        LoginVC.open(vc: self)
    }
    @objc func registerPressed(_ sender:UIButton){
        RegisterVC.open(vc: self)
    }
    
}
extension ViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard let user = user else { return }
        if let authentication = user.authentication, let token = authentication.accessToken {
            UserDefaults.standard.setValue(token, forKey: "token")
            self.showAlert(withTitle: "token", withMessage: token)
        }
    }
    
    
}
