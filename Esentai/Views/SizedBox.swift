//
//  SizedBox.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy
class SizedBox: UIView {

    init(height:CGFloat = 0, width:CGFloat = 0) {
        super.init(frame: .zero)
        self.easy.layout(Width(width),Height(height))

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
