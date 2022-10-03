import UIKit
import SwiftUI

class CustomTextField: UIView {
    
    enum textFieldTypes{
        case phone
        case date
        case name
        case email
        case password
    }
    
    private var typeTextField: textFieldTypes?
    private var wrongMessage: String?
    
    private lazy var picker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 300, height: 216))
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = TextField()
        textField.layer.borderColor = UIColor(named: "BorderColorForTextField")?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let wrongLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "Red")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 10)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect = .zero, title: String, titleColor: UIColor = .black, backgroundColor:UIColor = .white, placeholder: String = "", keyboardType: UIKeyboardType? = nil, isDate: Bool? = nil, typeTextField: textFieldTypes? = nil, wrongMessage: String? = nil) {
        super.init(frame: frame)
        titleLabel.text = title
        titleLabel.textColor = titleColor
        textField.backgroundColor = backgroundColor
        textField.placeholder = placeholder
        setTypeKeybord(keyboardType: keyboardType)
        addDatePicker(isDate: isDate)
        self.typeTextField = typeTextField
        self.wrongMessage = wrongMessage
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    func setTypeKeybord(keyboardType: UIKeyboardType?) {
        if let keyboardType = keyboardType {
            textField.keyboardType = keyboardType
            if keyboardType == UIKeyboardType.phonePad {
                let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
                
                let closeButton = UIBarButtonItem(title: "Закрыть", style: .plain, target: nil, action: #selector(cancelPhonePad))
                
                toolbar.setItems([closeButton], animated: false)
                
                textField.inputAccessoryView = toolbar
            }
        }
    }
    
    func addDatePicker(isDate: Bool?) {
        if let isDate = isDate {
            if isDate {
                
                picker.datePickerMode = .date
                picker.preferredDatePickerStyle = .wheels
                
                let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
                
                let doneButton = UIBarButtonItem(title: "Готово", style: .plain, target: nil, action: #selector(doneDatePicker))
                let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: nil, action: #selector(cancelDatePicker))
                
                
                toolbar.setItems([cancelButton, doneButton], animated: false)
                
                textField.inputAccessoryView = toolbar
                textField.inputView = picker
            }
        }
    }
    
    private func setTextField(textField: UITextField, validType: String.ValidTypes, wrongMessage: String, string: String, range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 {
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType){
            wrongLabel.text = ""
            textField.layer.borderColor = UIColor(named: "ElGreen")?.cgColor
            textField.layer.borderWidth = 1.5
            titleLabel.textColor = UIColor(named: "ElGreen")
        } else {
            wrongLabel.text = wrongMessage
            textField.layer.borderColor = UIColor(named: "Red")?.cgColor
            textField.layer.borderWidth = 1.5
            titleLabel.textColor = UIColor(named: "Red")
        }
    }
    
    
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string)
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        return result
    }
    
    @objc func cancelPhonePad() {
        textField.endEditing(true)
    }
    
    @objc func cancelDatePicker() {
        textField.endEditing(true)
    }
    
    @objc func doneDatePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        textField.text = formatter.string(from: picker.date)
        
        textField.endEditing(true)
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "ElGreen")?.cgColor
        textField.layer.borderWidth = 1.5
        titleLabel.textColor = UIColor(named: "ElGreen")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = UIColor(named: "BorderColorForTextField")?.cgColor
        textField.layer.borderWidth = 1.0
        titleLabel.textColor = .black
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    
    private func configure() {
        setupDelegate()
        
        addSubview(textField)
        addSubview(titleLabel)
        addSubview(wrongLabel)
        
        
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -5),
            
            wrongLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            wrongLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            wrongLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1.5)
        ])
    }
    
    private class TextField: UITextField {
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 10, dy: 0)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 10, dy: 0)
        }
    }
    
}

extension CustomTextField: UITextFieldDelegate {
    
    func setupDelegate() {
        textField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch typeTextField {
        case .phone:
            textField.text = setPhoneNumberMask(textField: textField, mask: "+X (XXX) XXX-XX-XX", string: string, range: range)
        case .date:
            textField.text = setPhoneNumberMask(textField: textField, mask: "XX.XX.XXXX", string: string, range: range)
        case .name:
            setTextField(textField: textField,
                         validType: .name,
                         wrongMessage: wrongMessage ?? "",
                         string: string,
                         range: range)
        case .email:
            setTextField(textField: textField,
                         validType: .email,
                         wrongMessage: wrongMessage ?? "",
                         string: string,
                         range: range)
        case .password:
            setTextField(textField: textField,
                         validType: .password,
                         wrongMessage: wrongMessage ?? "",
                         string: string,
                         range: range)
        default:
            textField.text = textField.text ?? ""
        }
        return false
    }
}

