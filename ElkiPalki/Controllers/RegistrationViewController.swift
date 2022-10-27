//
//  RegistrateViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 05.08.2022.
//

import Foundation
import UIKit

class RegistrationViewController: UIViewController {
    
    let lineImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "line")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let registrateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont (name: "Montserrat-Bold", size: 40)
        label.text = "Регистрация"
        label.textColor = UIColor(named: "ElGreen")
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
    
    let registrateButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ElGreen")
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("Sing up", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 17)
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
        view.addSubview(registrateLabel)
        view.addSubview(stackView)
    
        stackView.addArrangedSubview(logintTextField)
        stackView.addArrangedSubview(passwordTextField)
        stackView.addArrangedSubview(registrateButton)
        
        registrateButton.addTarget(self, action: #selector(registrateButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    private func setConstraints () {
        
        lineImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15).isActive = true
        lineImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        lineImageView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        lineImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        registrateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registrateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
    
        stackView.topAnchor.constraint(equalTo: registrateLabel.bottomAnchor, constant: 50).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        for subView in stackView.arrangedSubviews {
            subView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            subView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            subView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
    }
    
    
    @objc func registrateButtonTapped() {
        guard let email = logintTextField.textField.text, let password = passwordTextField.textField.text, email != "", password != "" else {
            logintTextField.showError()
            passwordTextField.showError()
            return
        }
        
        let userAuthorization = UsetAuthorization(email: email, password: password)
        
        let postRequest = ApiRequest(endPoint: "user/registration/")
        
        postRequest.registration(userAuthorization, completion: {result in
            switch result {
            case .success(let responseData):
                UserSettings.userEmail = email
                UserSettings.userRefreshToken = responseData.tokens.refreshToken
                DispatchQueue.main.async {
                    UserSettings.isAuthorized = true
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController()
                }
            case .failure (let error):
                print(error)
            }
        })
    }
}
