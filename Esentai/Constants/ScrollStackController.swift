//
//  ScrollStackController.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit


open class ScrollStackController: UIViewController {
    
    open var scrollView = UIScrollView()
    open var stackView = UIStackView()
    open var bottomAnchor = NSLayoutConstraint()
    open var scrollViewTopAnchor = NSLayoutConstraint()
    open var scrollViewLeftAnchor = NSLayoutConstraint()
    open var scrollViewRightAnchor = NSLayoutConstraint()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let bottomAnchorCalc = self.tabBarController?.tabBar.frame.size.height ?? 0
        bottomAnchor = scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -bottomAnchorCalc)
        bottomAnchor.isActive = true
        
        scrollViewTopAnchor = scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        scrollViewLeftAnchor = scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        scrollViewRightAnchor = scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        
        NSLayoutConstraint.activate([
            scrollViewTopAnchor,
            scrollViewLeftAnchor,
            scrollViewRightAnchor
        ])
        
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        if #available(iOS 11.0, *) {
            stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 24, bottom: 20, trailing: 24)
        } else {
            stackView.layoutMargins = UIEdgeInsets(top: 20, left: 24, bottom: 20, right: 24)
        }
        scrollView.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        //Подписываемся на изменение языка
        
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Подписываемся на открытие клавы
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        //удаляем обзерверы открытия клавы
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc open func setText() {} // Если нужны переводы, нужно делать override
    
    @objc open func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            //let bottomAnchorCalc = self.tabBarController?.tabBar.frame.size.height ?? 0
            UIView.animate(withDuration: 0.3){
                self.bottomAnchor.constant = -(keyboardSize.height)
            }
        }
    }
    
    @objc open func keyboardWillHide(notification _: NSNotification) {
        UIView.animate(withDuration: 0.3){
            self.bottomAnchor.constant = 0
        }
    }
    
    open func addLine() {
        let line = UIView()
        line.backgroundColor = .gray
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        stackView.addArrangedSubview(line)
    }
    open func addLine(to:UIStackView) {
        let line = UIView()
        line.backgroundColor = .gray
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        to.addArrangedSubview(line)
    }
}
