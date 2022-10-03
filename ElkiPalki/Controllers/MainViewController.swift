import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: AccountViewController())
        let vc2 = UINavigationController(rootViewController: HomeViewController())
        let vc3 = UINavigationController(rootViewController: AboutViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "person")
        vc2.tabBarItem.image = UIImage(systemName: "house")
        vc3.tabBarItem.image = UIImage(systemName: "info.circle")
        
        vc1.tabBarItem.title = "Личный Кабинет"
        vc2.tabBarItem.title = "Проекты"
        vc3.tabBarItem.title = "О нас"
        
        tabBar.tintColor = UIColor(named: "ElGreen")
        
    
        setViewControllers([vc1, vc2, vc3], animated: true)
//        let button = UIButton()
//        button.frame = CGRect(x: self.view.frame.size.width - 250, y: 650, width: 100, height: 50)
//        button.backgroundColor = UIColor(named: "ElGreen")
//        button.setTitle("Войти", for: .normal)
//        button.setTitleColor(.black, for: UIControl.State.normal)
//        self.view.addSubview(button)

//        setConstraints()
    }


}


//extension MainViewController  {
//
//    func setConstraints () {
//
//        view.addSubview(enterButton)
//        NSLayoutConstraint.activate([
//            enterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            enterButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -175),
//            enterButton.widthAnchor.constraint(equalToConstant: 300),
//            enterButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//
//        view.addSubview(withoutRegButton)
//        NSLayoutConstraint.activate([
//            withoutRegButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            withoutRegButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -125),
//            withoutRegButton.widthAnchor.constraint(equalToConstant: 300),
//            withoutRegButton.heightAnchor.constraint(equalToConstant: 50)
//        ])
//    }
//}
