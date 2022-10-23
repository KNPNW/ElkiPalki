import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: AccountViewController())
        let vc2 = UINavigationController(rootViewController: ObjectsViewController())
        let vc3 = UINavigationController(rootViewController: AboutViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "person")
        vc2.tabBarItem.image = UIImage(systemName: "house")
        vc3.tabBarItem.image = UIImage(systemName: "info.circle")
        
        vc1.tabBarItem.title = NSLocalizedString("Personal account", comment: "")
        vc2.tabBarItem.title = NSLocalizedString("Projects", comment: "")
        vc3.tabBarItem.title = NSLocalizedString("About us", comment: "")
        
        tabBar.tintColor = UIColor(named: "ElGreen")
        
    
        setViewControllers([vc1, vc2, vc3], animated: true)
    }


}

