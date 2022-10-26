//
//  ViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 25.04.2022.
//

import UIKit


class FirstViewController: UIViewController {
    
    let mainLogo : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ElpalLogo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let enterButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ElGreen")
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("Sing in", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 17)
        button.setTitleColor(UIColor(named: "mainButtonTextColor"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let registrateButton : UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "ElGreen")
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("Sing up", comment: ""), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 17)
        button.setTitleColor(UIColor(named: "mainButtonTextColor"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let withoutRegButton : UIButton = {
        let button = UIButton()
//        button.backgroundColor = UIColor(named: "mainColor")
        button.layer.cornerRadius = 10
        button.setTitle(NSLocalizedString("Continue without registration", comment: ""), for: .normal)
        button.titleLabel?.font = UIFont(name: "Gilroy-Light", size: 17)
        button.setTitleColor(UIColor(named: "ElGreen"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        
        UserSettings.isFirstLaunch = false
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        registrateButton.addTarget(self, action: #selector(registrateButtonTapped), for: .touchUpInside)
        
        withoutRegButton.addTarget(self, action: #selector(withoutRegButtonTapped), for: .touchUpInside)
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func enterButtonTapped() {
        let authorizationView = AuthorizationViewController()
        authorizationView.modalPresentationStyle = .pageSheet
        authorizationView.modalTransitionStyle = .coverVertical
        present(authorizationView, animated: true, completion: nil)
    }
    
    @objc func registrateButtonTapped() {
        let authorizationView = RegistrationViewController()
        authorizationView.modalPresentationStyle = .pageSheet
        authorizationView.modalTransitionStyle = .coverVertical
        present(authorizationView, animated: true, completion: nil)
    }
    
    
    @objc func withoutRegButtonTapped() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController()
    }


}


extension FirstViewController  {
    
    func setConstraints () {
        view.addSubview(mainLogo)
        NSLayoutConstraint.activate([
            mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            mainLogo.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        view.addSubview(enterButton)
        NSLayoutConstraint.activate([
            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200),
            enterButton.widthAnchor.constraint(equalToConstant: 300),
            enterButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(registrateButton)
        NSLayoutConstraint.activate([
            registrateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registrateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -135),
            registrateButton.widthAnchor.constraint(equalToConstant: 300),
            registrateButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        view.addSubview(withoutRegButton)
        NSLayoutConstraint.activate([
            withoutRegButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            withoutRegButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -75),
            withoutRegButton.widthAnchor.constraint(equalToConstant: 300),
            withoutRegButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
