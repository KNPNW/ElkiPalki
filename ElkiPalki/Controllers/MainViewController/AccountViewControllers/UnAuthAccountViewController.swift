//
//  UnauthorizedUserViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 24.10.2022.
//

import UIKit

class UnAuthAccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 17)
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
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 17)
        button.setTitleColor(UIColor(named: "mainButtonTextColor"), for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.backgroundColor = UIColor(named: "mainBackGroungColor")
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Personal account", comment: "")
        view.backgroundColor = UIColor(named: "mainBackGroundColor")
        
        view.addSubview(mainLogo)
        view.addSubview(enterButton)
        view.addSubview(registrateButton)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        configure()
        
        enterButton.addTarget(self, action: #selector(enterButtonTapped), for: .touchUpInside)
        
        registrateButton.addTarget(self, action: #selector(registrateButtonTapped), for: .touchUpInside)
        
        mainLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mainLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 175).isActive = true
        mainLogo.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        enterButton.topAnchor.constraint(equalTo: mainLogo.bottomAnchor, constant: 25).isActive = true
        enterButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        enterButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        enterButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        registrateButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20).isActive = true
        registrateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        registrateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        registrateButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.topAnchor.constraint(equalTo: registrateButton.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func configure(){
        models.append(Section(title: "General", options: [
            .staticCell(model: AccountOptions(title: NSLocalizedString("About app", comment: ""), icon: UIImage(systemName: "info"), iconBackGroundColor: .systemGray2 ){
                return
            }),
            .staticCell(model: AccountOptions(title: NSLocalizedString("Information and help", comment: ""), icon: UIImage(systemName: "bubble.left.and.exclamationmark.bubble.right"), iconBackGroundColor: .systemGray2 ){
                return
            }),
            .staticCell(model: AccountOptions(title: NSLocalizedString("User agreement", comment: ""), icon: UIImage(systemName: "lock"), iconBackGroundColor: .systemGray2 ){
                return
            })
            ]))
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AccountTableViewCell.identifier,
                for: indexPath
            ) as? AccountTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .logoutCell(let model):
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: LogoutTableViewCell.identifier,
                for: indexPath
            ) as? LogoutTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        switch model.self {
        case .staticCell(let model):
            model.handler()
        case .logoutCell(let model):
            model.handler()
        }
    }
    

}
