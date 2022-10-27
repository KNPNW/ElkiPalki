import UIKit

class AuthAccountViewController: UIViewController {
    
    
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

    
    private lazy var tableView: SettingTableView = {
        let tableView = SettingTableView(frame: .zero, style: .insetGrouped)
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
        
        tableView.models = models
    
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        
        headerTableView.addSubview(greetingLabel)
        tableView.tableHeaderView = headerTableView

        view.addSubview(tableView)
        
        setConstraints()

    }
    
    private func setConstraints () {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configure(){
        models.append(Section(title: "User", options: [
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("Profile", comment: ""), icon: UIImage(systemName: "person"), iconBackGroundColor: UIColor(named:
                "ElGreen")){
                self.navigationController?.pushViewController(ProfileViewController(), animated: true)
                return
            }),
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("Active projects", comment: ""), icon: UIImage(systemName: "house"), iconBackGroundColor: UIColor(named: "ElGreen")){
                self.navigationController?.pushViewController(ActiveProjectsViewController(), animated: true)
                return
            }),
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("My applications", comment: ""), icon: UIImage(systemName: "doc.text"), iconBackGroundColor: UIColor(named: "ElGreen")){
                self.navigationController?.pushViewController(ApplicationsViewController(), animated: true)
                return
            }),
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("Settings", comment: ""), icon: UIImage(systemName: "gearshape"), iconBackGroundColor: UIColor(named: "ElGreen")){
                self.navigationController?.pushViewController(SettingsViewController(), animated: true)
                return
            })
            ]))
        
        models.append(Section(title: "General", options: [
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("About app", comment: ""), icon: UIImage(systemName: "info"), iconBackGroundColor: .systemGray4){
                return
            }),
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("Information and help", comment: ""), icon: UIImage(systemName: "bubble.left.and.exclamationmark.bubble.right"), iconBackGroundColor: .systemGray4 ){
                return
            }),
            .simpleCell(model: SimpleSettingOption(title: NSLocalizedString("User agreement", comment: ""), icon: UIImage(systemName: "lock"), iconBackGroundColor: .systemGray4 ){
                return
            })
            ]))
        
        models.append(Section(title: "Logout", options: [
            .logoutCell(model: LogoutSettingOption(title: NSLocalizedString("Logout", comment: ""), color: UIColor(named: "errorColor"), handler: {
                UserDefaults.standard.removeObject(forKey: "userRefreshToken")
                UserDefaults.standard.removeObject(forKey: "userEmail")
                
                UserSettings.isAuthorized = false
                
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController()
                
                return
            }))
        
        ]))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
