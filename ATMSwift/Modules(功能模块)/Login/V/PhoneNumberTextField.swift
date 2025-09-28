//
//  PhoneNumberTextField.swift
//  ATMSwift
//
//  Created by binbin.c on 2025/9/26.
//


import UIKit

class PhoneNumberTextField: UITextField {
    private let maxDigits = 22 // 中国手机号长度
    private let groupSize = 4 // 每组数字位数
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        keyboardType = .numberPad
        delegate = self
        addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        formatPhoneNumber()
    }
    
    private func formatPhoneNumber() {
        let digits = String((text ?? "").filter { $0.isNumber }.prefix(maxDigits))
        
        // 每4位插入空格
        var formatted = ""
        for (index, char) in digits.enumerated() {
            if index > 0 && index % groupSize == 0 {
                formatted.append(" ")
            }
            formatted.append(char)
        }
        
        text = formatted
    }
}

extension PhoneNumberTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                  shouldChangeCharactersIn range: NSRange,
                  replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
        return newText.filter { $0.isNumber }.count <= maxDigits
    }
}
