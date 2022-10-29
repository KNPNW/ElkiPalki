//
//  ApplicationViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 10.09.2022.
//

import UIKit

class ApplicationsViewController: UIViewController {
    
    private lazy var tableView: ApplicationsTableView = {
        let tableView = ApplicationsTableView()
        return tableView
    }()
    
    var models = [ApplicationsTableView.ApplicationOptions]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("My applications", comment: "")
        
        configure()
        tableView.models = self.models
        
        view.addSubview(tableView)
        
        setConstraints()
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
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configure() {
        models.append(ApplicationsTableView.ApplicationOptions(numberApplication: "21342", objectApplication: "Каркасный дом 7х11 - КД 112", state: .sent, handler: {
            return
        }))
        
        models.append(ApplicationsTableView.ApplicationOptions(numberApplication: "40213", objectApplication: "Каркасный дом 6х6 - КД 110", state: .inProcessing, handler: {
            return
        }))
        
        models.append(ApplicationsTableView.ApplicationOptions(numberApplication: "92312", objectApplication: "Каркасный дом 7х7,5 - КД 111", state: .closed, handler: {
            return
        }))
    }

}
