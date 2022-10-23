import UIKit

class CustomTextField: UIView, UITextViewDelegate {
    
    enum typeTF{
        case phone
        case date
        case name
        case email
        case password
    }
    
    private var type: typeTF?
    private var wrongMessage: String?
    private var animationWrongLabel: Bool = false
    var haveError: Bool = false
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        return picker
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let textField: UITextField = {
        let textField = TextField()
        textField.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1.0

        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private class TextField: UITextField {
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 10, dy: 0)
        }
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 10, dy: 0)
        }
    }
    
    let wrongLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "errorColor")
        label.textAlignment = .left
        label.font = UIFont(name: "Montserrat-Medium", size: 10)
        label.alpha = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(frame: CGRect = .zero, title: String = "",
         titleColor: UIColor = UIColor(named: "textFieldLabelColor")!, backgroundColor: UIColor = UIColor(named: "textFieldBackGroundColor")!,
         placeholder: String = "", keyboardType: UIKeyboardType? = nil,
         isDate: Bool? = nil, typeTextField:
         typeTF? = nil,
         wrongMessage: String? = nil) {
        
        super.init(frame: frame)
        self.type = typeTextField
        self.wrongMessage = wrongMessage
        
        titleLabel.text = title
        titleLabel.textColor = titleColor
        
        textField.backgroundColor = backgroundColor
        textField.placeholder = placeholder
        
        wrongLabel.text = wrongMessage
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setTypeKeybord(keyboardType: keyboardType)
        
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
    
    private func configure() {
        textField.delegate = self
        
        addSubview(textField)
        addSubview(wrongLabel)
        
        if titleLabel.text != "" {
            addSubview(titleLabel)
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            titleLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        } else {
            textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        }
        
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        wrongLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 11).isActive = true
        wrongLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        wrongLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1.5).isActive = true
        wrongLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true

    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var color: UIColor
        if haveError {
            color = UIColor(named: "errorColor") ?? .red
        } else {
            color = UIColor(named: "successColor") ?? .green
        }
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
            self.textField.layer.borderColor = color.cgColor
            UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.textField.layer.borderWidth = 2
            }
        }, completion: { _ in
            self.textField.layer.borderColor = color.cgColor
            self.textField.layer.borderWidth = 2
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
            textField.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
            UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.textField.layer.borderWidth = 1
            }
        }, completion: { _ in
            self.textField.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
            self.textField.layer.borderWidth = 1
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func showError() {
        textField.shakeAnimation()
        
        if !haveError {
            self.wrongLabel.frame.origin.y =  self.wrongLabel.frame.origin.y - 2
            
            UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
                self.wrongLabel.frame.origin.y = self.wrongLabel.frame.origin.y + 2
                self.textField.layer.borderColor = UIColor(named: "errorColor")?.cgColor
                UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                    self
                        .wrongLabel.alpha = 1
                    self.textField.layer.borderWidth = 2
                }
            }, completion: { _ in
                UILabel.animateKeyframes(withDuration: 0.5, delay: 2.0, options: .calculationModeLinear, animations: {
                    self.wrongLabel.frame.origin.y = self.wrongLabel.frame.origin.y - 2
                    self.textField.layer.borderColor = UIColor(named: "textFieldBorderColor")?.cgColor
                    UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                        self.wrongLabel.alpha = 0
                        self.textField.layer.borderWidth = 1.0
                    }
                    
                }, completion: { _ in
                    self.wrongLabel.frame.origin.y = self.wrongLabel.frame.origin.y + 2
                })
            })
        }
    }
    
    func setTypeKeybord(keyboardType: UIKeyboardType?) {
        if let keyboardType = keyboardType {
            textField.keyboardType = keyboardType
            if keyboardType == UIKeyboardType.phonePad {
                let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
                
                let closeButton = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""), style: .plain, target: nil, action: #selector(close))
                
                toolbar.setItems([closeButton], animated: false)
                
                textField.inputAccessoryView = toolbar
            }
        }
        
        if type == .date {
            setDatePicker()
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
            if animationWrongLabel {
                animationWrongLabel = false
                haveError = false
                UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
                    self.wrongLabel.frame.origin.y = self.wrongLabel.frame.origin.y - 2
                    self.textField.layer.borderColor = UIColor(named: "successColor")?.cgColor
                    UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                        self.wrongLabel.alpha = 0
                        self.textField.layer.borderWidth = 2
                    }
                }, completion: nil )
            }
        } else {
            if !animationWrongLabel {
                animationWrongLabel = true
                haveError = true
                UIView.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
                    self.wrongLabel.frame.origin.y = self.wrongLabel.frame.origin.y + 2
                    self.textField.layer.borderColor = UIColor(named: "errorColor")?.cgColor
                    UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                        self.wrongLabel.alpha = 1
                        self.textField.layer.borderWidth = 2
                    }
                }, completion: nil )
            }
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
    
    func setDatePicker() {
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 300, height: 44))
        
        let doneButton = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: nil, action: #selector(doneDatePicker))
        let closeButton = UIBarButtonItem(title: NSLocalizedString("Close", comment: ""), style: .plain, target: nil, action: #selector(close))
        
        
        toolbar.setItems([closeButton, doneButton], animated: false)
        
        textField.inputAccessoryView = toolbar
        textField.inputView = datePicker
    }
    
    @objc func close() {
        textField.endEditing(true)
    }
    
    @objc func doneDatePicker() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        textField.text = formatter.string(from: datePicker.date)
        
        textField.endEditing(true)
    }
    
}

extension UITextField {
    func shakeAnimation() {
            let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
            animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
            animation.duration = 0.5
            animation.values = [-15.0, 15.0, -15.0, 15.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
            layer.add(animation, forKey: "shake")
        }
}

extension CustomTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch type {
        case .phone:
            textField.text = setPhoneNumberMask(textField: textField, mask: "+X (XXX) XXX-XX-XX", string: string, range: range)
        case .date:
            textField.text = setPhoneNumberMask(textField: textField, mask: "XX.XX.XXXX", string: string, range: range)
        case .name:
            setTextField(textField: textField, validType: .name, wrongMessage: wrongMessage ?? "", string: string, range: range)
        case .email:
            setTextField(textField: textField, validType: .email, wrongMessage: wrongMessage ?? "", string: string, range: range)
        case .password:
            setTextField(textField: textField, validType: .password, wrongMessage: wrongMessage ?? "", string: string, range: range)
        default:
            let text = (textField.text ?? "") + string
            let result: String
            if range.length == 1 {
                let end = text.index(text.startIndex, offsetBy: text.count - 1)
                result = String(text[text.startIndex..<end])
            } else {
                result = text
            }
            
            textField.text = result
        }
        return false
    }
}

