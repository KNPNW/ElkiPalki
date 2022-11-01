//
//  ApplicationsTableView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 27.10.2022.
//

import UIKit

class ApplicationsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    enum stateApplication {
        case sent
        case closed
        case inProcessing
    }
    
    struct ApplicationOptions {
        let numberApplication: String
        let objectApplication: String
        let state: stateApplication
        let handler: (()->Void)
    }

    var models = [ApplicationOptions]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor(named: "mainBackGroungColor")
        self.register(ApplicationTableViewCell.self, forCellReuseIdentifier: ApplicationTableViewCell.identifier)
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 160
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]

        guard let cell = tableView.dequeueReusableCell( withIdentifier: ApplicationTableViewCell.identifier, for: indexPath) as? ApplicationTableViewCell else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.row]
        model.handler()
    }
}
