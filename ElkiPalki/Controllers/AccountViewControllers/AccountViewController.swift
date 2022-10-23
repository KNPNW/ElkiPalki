import UIKit

struct Section {
    let title: String
    let options: [AccountOptionsType]
}

enum AccountOptionsType {
    case staticCell(model: AccountOptions)
    case logoutCell(model: AccountLogoutOptions)
    
}

struct AccountLogoutOptions {
    let title: String
    let color: UIColor?
    let handler: (()->Void)
}

struct AccountOptions {
    let title: String
    let icon: UIImage?
    let iconBackGroundColor: UIColor?
    let handler: (()->Void)
}

class AccountViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var greetingLabel: UILabel = {
        let text = UILabel(frame: headerTableView.frame)
        text.lineBreakMode = .byWordWrapping
        text.numberOfLines = 2
        text.text = "Здравствуйте,\n\(UserSettings.userEmail ?? "странник")!"
        text.font = UIFont.boldSystemFont(ofSize: 35)
        text.textColor = UIColor(named: "Black")
        return text
    }()
    
    private lazy var headerTableView: UIView = {
        let view = UIView(frame: CGRect(x: 20, y: -50, width: self.view.frame.size.width, height: 100))
        return view
    }()

    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: -25, width: view.frame.size.width, height: view.frame.size.height), style: .insetGrouped)
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: AccountTableViewCell.identifier)
        tableView.register(LogoutTableViewCell.self, forCellReuseIdentifier: LogoutTableViewCell.identifier)
        return tableView
    }()
    
    private lazy var backItem: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.title = NSLocalizedString("Personal account", comment: "")
        return button
    }()
    
    
    var models = [Section]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
        configure()
        
        view.backgroundColor = UIColor(named: "White")
        
        headerTableView.addSubview(greetingLabel)
        tableView.tableHeaderView = headerTableView

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        

    }
    
    func configure(){
        models.append(Section(title: "General", options: [
            .staticCell(model: AccountOptions(title: NSLocalizedString("Profile", comment: ""), icon: UIImage(systemName: "person"), iconBackGroundColor: UIColor(named:
                "ElGreen")){
                self.navigationController?.pushViewController(ProfileViewController(), animated: true)
                return
            }),
            .staticCell(model: AccountOptions(title: NSLocalizedString("Active projects", comment: ""), icon: UIImage(systemName: "house"), iconBackGroundColor: UIColor(named: "ElGreen")){
                self.navigationController?.pushViewController(ActiveProjectsViewController(), animated: true)
                return
            }),
            .staticCell(model: AccountOptions(title: NSLocalizedString("My applications", comment: ""), icon: UIImage(systemName: "doc.text"), iconBackGroundColor: UIColor(named: "ElGreen")){
                self.navigationController?.pushViewController(ApplicationsViewController(), animated: true)
                return
            }),
            .staticCell(model: AccountOptions(title: NSLocalizedString("Settings", comment: ""), icon: UIImage(systemName: "gearshape"), iconBackGroundColor: UIColor(named: "ElGreen")){
                self.navigationController?.pushViewController(SettingsViewController(), animated: true)
                return
            })
            ]))
        models.append(Section(title: "Logout", options: [
            .logoutCell(model: AccountLogoutOptions(title: NSLocalizedString("Logout", comment: ""), color: UIColor(named: "Red"), handler: {
                UserDefaults.standard.removeObject(forKey: "userRefreshToken")
                UserDefaults.standard.removeObject(forKey: "userEmail")
                
                let view = FirstViewController()
                view.modalPresentationStyle = .fullScreen
                view.modalTransitionStyle = .crossDissolve
                
                self.dismiss(animated: true)
                self.present(view, animated: true)
                return
            }))
        ]))
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension AccountViewController {
}

