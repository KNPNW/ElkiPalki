import UIKit
import Combine

class MainViewController: UITabBarController {
    
    lazy var AuthAccountVC: UINavigationController = {
        let viewController = UINavigationController(rootViewController: AuthAccountViewController())
        viewController.tabBarItem.image = UIImage(systemName: "person")
        viewController.tabBarItem.title = NSLocalizedString("Personal account", comment: "")
        return viewController
    }()
    
    lazy var UnAuthAccountVC: UINavigationController = {
        let viewController = UINavigationController(rootViewController: UnAuthAccountViewController())
        viewController.tabBarItem.image = UIImage(systemName: "person")
        viewController.tabBarItem.title = NSLocalizedString("Personal account", comment: "")
        return viewController
    }()
    
    lazy var ObjectsVC: UINavigationController = {
        let viewController = UINavigationController(rootViewController: ObjectsViewController())
        viewController.tabBarItem.image = UIImage(systemName: "house")
        viewController.tabBarItem.title = NSLocalizedString("Projects", comment: "")
        return viewController
    }()
    
    lazy var AboutVC: UINavigationController = {
        let viewController = UINavigationController(rootViewController: AboutViewController())
        viewController.tabBarItem.image = UIImage(systemName: "info.circle")
        viewController.tabBarItem.title = NSLocalizedString("About us", comment: "")
        return viewController
    }()
    
    var auth: Bool
    
    init(auth: Bool) {
        self.auth = auth
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        tabBar.tintColor = UIColor(named: "ElGreen")
        
        if self.auth {
            //set for authorized user
            setViewControllers([AuthAccountVC, ObjectsVC, AboutVC], animated: true)
        } else {
            //set for unauthorized user
            setViewControllers([UnAuthAccountVC, ObjectsVC, AboutVC], animated: true)
        }
        
    }
}

