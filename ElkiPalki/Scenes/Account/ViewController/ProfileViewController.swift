//
//  ProfileViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 09.09.2022.
//

import UIKit
import SwiftUI

class ProfileViewController: UIViewController {
    
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()

        view.frame = self.view.bounds
        view.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height-100)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let saveButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ElGreen")
        button.layer.cornerRadius = 10
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor(named: "White"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: self.view.frame.size.width, height: scrollView.frame.size.height)
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 25
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var firstName: CustomTextField = {
        let textField = CustomTextField(title: "Имя", typeTextField: .name, wrongMessage: "Имя может содержать только символы русского алфавита")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lastName: CustomTextField = {
        let textField = CustomTextField(title: "Фамилия", typeTextField: .name, wrongMessage: "Фамилия может содержать только символы русского алфавита")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var dateOfBirth: CustomTextField = {
        let textField = CustomTextField(title: "Дата рождения", isDate: true, typeTextField: .date)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var phone: CustomTextField = {
        let textField = CustomTextField(title: "Телефон", keyboardType: UIKeyboardType.phonePad, typeTextField: .phone)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var test: CustomTextField = {
        let textField = CustomTextField(title: "Test", wrongMessage: "Имя может содержать только символы русского алфавита")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Profile", comment: "")
        
        view.backgroundColor = UIColor(named: "mainBackGroundColor")
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        stackView.addArrangedSubview(firstName)
        stackView.addArrangedSubview(lastName)
        stackView.addArrangedSubview(dateOfBirth)
        stackView.addArrangedSubview(phone)
        stackView.addArrangedSubview(test)
        
        
        view.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        setConstraints ()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setConstraints () {
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100).isActive = true
        
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25).isActive = true
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        for view in stackView.arrangedSubviews {
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
            view.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        }
        
        saveButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20).isActive = true
        saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc func saveButtonTapped() {
        
        let userInfo = UserInfoModel(refreshToken: UserSettings.userRefreshToken, userFirstName: firstName.textField.text ?? "", userLastName: lastName.textField.text ?? "", userDateBirthday: dateOfBirth.textField.text ?? "", userPhone: phone.textField.text ?? "")
        
        let postRequest = ApiRequest(endPoint: "user/updateUserInfo/")
        
        postRequest.updateUserInfo(userInfo, completion:{result in
            switch result {
            case .success(let responseData):
                print(responseData)
            case .failure (let .apiError(error)):
                print(error)
            case .failure(.responseProblem):
                print("error")
            case .failure(.decodingProblem):
                print("error")
            case .failure(.encodingProblem):
                print("error")
            default:
                print("error")
            }
        })
    }
}
