//
//  SettingTableView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 26.10.2022.
//

import UIKit

struct Section {
    let title: String
    let options: [SettingOptionsType]
}

enum SettingOptionsType {
    case simpleCell(model: SimpleSettingOption)
    case logoutCell(model: LogoutSettingOption)
    
}

struct LogoutSettingOption {
    let title: String
    let color: UIColor?
    let handler: (()->Void)
}

struct SimpleSettingOption {
    let title: String
    let icon: UIImage?
    let iconBackGroundColor: UIColor?
    let handler: (()->Void)
}


class SettingTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var models = [Section]() {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor(named: "mainBackGroungColor")
        self.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        self.register(LogoutTableViewCell.self, forCellReuseIdentifier: LogoutTableViewCell.identifier)
        
        self.delegate = self
        self.dataSource = self
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]
        
        switch model.self {
        case .simpleCell(let model):
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
        case .simpleCell(let model):
            model.handler()
        case .logoutCell(let model):
            model.handler()
        }
    }
    
}
