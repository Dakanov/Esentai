//
//  CustomButton.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy
class CustomButton: UIButton {
    

    func set(title:String,background: UIColor = UIColor.clear ){
        self.setTitle(title, for: .normal)
        self.backgroundColor = background
        self.layer.cornerRadius = 8
        self.layer.borderWidth = background == .clear ? 1 : 0
        let titleColor = background != .clear ? UIColor.white : UIColor.black
        self.setTitleColor(titleColor, for: .normal)
        self.easy.layout(Height(56))
    }
}
