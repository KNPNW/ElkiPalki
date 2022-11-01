import UIKit

class AuthorizationViewController: UIViewController {
    
    let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "line")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let authorizationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Montserrat-Bold", size: 40)
        label.text = NSLocalizedString("Login", comment: "")
        label.textColor = UIColor(named: "ElGreen")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let logintTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Email", keyboardType: .emailAddress, typeTextField: .email , wrongMessage: "Неверно указан email")
        return textField
    }()
    
    let passwordTextField : CustomTextField = {
        let textField = CustomTextField(placeholder: "Пароль", typeTextField: .password , wrongMessage: "Не проходит валидация")
        return textField
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ElGreen")
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("Sing in", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Gilroy-Regular", size: 17)
        button.setTitleColor(UIColor(named: "mainButtonTextColor"), for: UIControl.State.normal)
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
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        
        view.addSubview(lineImageView)
        view.addSubview(authorizationLabel)
        view.addSubview(stackView)
    
        stackView.addArrangedSubview(logintTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(enterButton)
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    private func setConstraints () {
        lineImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        lineImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        lineImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        lineImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        authorizationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        authorizationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
    
        stackView.topAnchor.constraint(equalTo: authorizationLabel.bottomAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        for subView in stackView.arrangedSubviews {
            subView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            subView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            subView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
    }
    
    @objc func enterButtonTapped() {
        guard let email = logintTextField.textField.text, let password = passwordTextField.textField.text, email != "", password != "" else {
            passwordTextField.showError()
            return
        }
        
        let userAuthorization = UsetAuthorization(email: email, password: password)
        
        let postRequest = ApiRequest(endPoint: "user/login/")
        
        postRequest.login(userAuthorization, completion: {result in
            switch result {
            case .success(let responseData):
                UserSettings.userEmail = email
                UserSettings.userRefreshToken = responseData.tokens.refreshToken
                DispatchQueue.main.async {
                    UserSettings.isAuthorized = true
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController()
                }
            case .failure(let error):
                print(error)
                
            }
        })
    }
}
