import UIKit

class AuthorizationViewController: UIViewController {
    
    let authorizationLabel : UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Login", comment: "")
        label.textColor = UIColor(named: "White")
        label.font = UIFont.boldSystemFont(ofSize: 40.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let warnLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "Red")
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logintTextField : CustomTextField = {
        let textField = CustomTextField(title: "", placeholder: "Email", keyboardType: .emailAddress, typeTextField: .email , wrongMessage: "Неверно указан email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let passwordTextField : CustomTextField = {
        let textField = CustomTextField(title: "", placeholder: "Пароль", typeTextField: .password , wrongMessage: "Не проходит валидация")
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "White")
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("Sing in", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(named: "ElGreen"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ElGreen")
        warnLabel.alpha = 0

        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(logintTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(enterButton)
        setConstraints()
    }
    
    func displayWarningLabel(withText text: String) {
        DispatchQueue.main.async {
            self.warnLabel.text = text
        
            UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: { [weak self] in self?.warnLabel.alpha = 1 }, completion: {[weak self] complete in self?.warnLabel.alpha = 0})
        }
    }
    
    @objc func enterButtonTapped() {
        guard let email = logintTextField.textField.text, let password = passwordTextField.textField.text, email != "", password != "" else {
            displayWarningLabel(withText: "Введена неверная информация")
            return
        }
        
        let userAuthorization = UsetAuthorization(email: email, password: password)
        
        let postRequest = ApiRequest(endPoint: "user/login/")
        
        postRequest.login(userAuthorization, completion: {result in
            switch result {
            case .success(let responseData):
                UserDefaults.standard.set(responseData.tokens.refreshToken, forKey: "refreshToken")
                DispatchQueue.main.async {
                    let mainView = MainViewController()
                    mainView.modalPresentationStyle = .fullScreen
                    mainView.modalTransitionStyle = .coverVertical
                    self.present(mainView, animated: true, completion: nil)
                    return
                }
            case .failure (let .apiError(error)):
                self.displayWarningLabel(withText: "\(error)")
            case .failure(.responseProblem):
                self.displayWarningLabel(withText: "\("Упс, что-то пошло не так(")")
            case .failure(.decodingProblem):
                self.displayWarningLabel(withText: "\("Упс, что-то пошло не так(")")
            case .failure(.encodingProblem):
                self.displayWarningLabel(withText: "\("Упс, что-то пошло не так(")")
            default:
                self.displayWarningLabel(withText: "\("Упс, что-то пошло не так(")")
                
            }
        })
    }
}


extension AuthorizationViewController  {
    
    func setConstraints () {
        
        view.addSubview(authorizationLabel)
        NSLayoutConstraint.activate([
            authorizationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorizationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75)
        ])
        
        view.addSubview(warnLabel)
        NSLayoutConstraint.activate([
            warnLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warnLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 125)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: authorizationLabel.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        for view in stackView.arrangedSubviews {
            view.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            view.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            view.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
}
