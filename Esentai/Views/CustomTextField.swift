//
//  CustomTextField.swift
//  Esentai
//
//  Created by Sultan on 12/17/20.
//

import UIKit
import EasyPeasy
class CustomTextField: UIView {

    let borderView = UIView()
    let titleLabel = UILabel()
    let textField = UITextField()
    let prefix = UILabel()
    let picker = UIDatePicker()
    let s = UIStackView()
    
    func set(title: String,placeholder: String = "", prefixHidden: Bool = false){
        titleLabel.set(title: title, font: .systemFont(ofSize: 12))
        textField.placeholder = placeholder
        self.prefix.isHidden = prefixHidden
        standart()
    }
    func standart() {
        self.addSubview(borderView)
        borderView.easy.layout(Edges(4),Height(56))
        borderView.layer.cornerRadius = 8
        borderView.layer.borderWidth = 1
        addSubview(titleLabel)
        titleLabel.easy.layout(Left(16),Top(),Width(105))
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .white
        bottomStack()
    }

    func setDatePicker(){
        standart()
        picker.datePickerMode =  .date
        picker.maximumDate = Date()
        picker.locale = Locale.current
        self.prefix.isHidden = true
        textField.placeholder = "ДД — ММ — ГГГГ"
        picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        textField.inputView = picker
        let calendar = UIImageView(image: #imageLiteral(resourceName: "calendar"))
        calendar.easy.layout(Width(24),Height(24))
        s.addArrangedSubview(calendar)
    }
    func bottomStack(){
        
        s.axis = .horizontal
        s.alignment = .fill
        s.distribution = .fill
        s.spacing = 7
        prefix.set(title: "+7", font: .systemFont(ofSize: 20))
        prefix.easy.layout(Width(25))
        s.addArrangedSubview(prefix)
        textField.font = .systemFont(ofSize: 20)
        borderView.addSubview(s)
        s.easy.layout(Edges(15))
        s.addArrangedSubview(textField)
        
    }
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            self.textField.text = "\(day)-\(month)-\(year)"
        }
    }
}
