import UIKit

class ObjectsViewController: UIViewController {
    
    private lazy var tableView : ObjectsTableView = {
        let tableView = ObjectsTableView(frame: .zero, style: .grouped)
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let controller = UIRefreshControl()
        controller.tintColor = UIColor(named: "ElGreen")
        return controller
    }()
    
    
    private lazy var loadView: LoadingView = {
        let view = LoadingView(size: 100)
        return view
    }()
    
    var models = [SectionObject]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Наши проекты"
        
        configure()
        
        view.addSubview(tableView)
        view.addSubview(loadView)
        
        loadView.frame = CGRect(x: view.frame.size.width/2-loadView.size/2, y: view.frame.size.height/2-loadView.size/2, width: loadView.size, height: loadView.size)
        
        loadView.draw(CGRect(x: 0, y: 0, width: 100, height: 100))
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(updateTable), for: .valueChanged)
        
        setConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setConstraint() {
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    @objc func updateTable() {
        DispatchQueue.main.async {
            self.models.removeLast()
            self.tableView.reloadData()
            
            DispatchQueue.global(qos: .userInitiated).async {
                let getObject = ApiRequest(endPoint: "api/getAllObjects/")
                self.models.append(SectionObject(title: "", options: []))
                
                getObject.getAllObjects(completion: { result in
                    switch result {
                    case .success(let allObjects):
                        for (_, object) in allObjects.objects.enumerated() {
                            self.models[0].options.append(ObjectOptions(object: object, handler: {
                                let objectViewController = ObjectViewController(objectId: String(object.id))
//                                objectViewController.modalPresentationStyle = .custom
//                                objectViewController.transitioningDelegate = self
//
//                                self.present(objectViewController, animated: true, completion: nil)
                                self.show(objectViewController, sender: self)
                            }))
                            self.tableView.models = self.models
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                
                    case .failure(let ApiErrors):
                        print(ApiErrors)
                    }
                    DispatchQueue.main.async {
                        self.refreshControl.endRefreshing()
                    }
                })
            }
        }
    }
    
    func configure(){
        DispatchQueue.global(qos: .userInitiated).async {
            
            let getObject = ApiRequest(endPoint: "api/getAllObjects/")
            self.models.append(SectionObject(title: "", options: []))
            
            getObject.getAllObjects(completion: { result in
                switch result {
                case .success(let allObjects):
                    DispatchQueue.main.async {
                        self.loadView.removeFromSuperview()
                    }
                    for (_, object) in allObjects.objects.enumerated() {
                        self.models[0].options.append(ObjectOptions(object: object, handler: {
                            let objectViewController = ObjectViewController(objectId: String(object.id))
//                            objectViewController.modalPresentationStyle = .custom
//                            objectViewController.transitioningDelegate = self
//
//                            self.present(objectViewController, animated: true, completion: nil)
                              self.show(objectViewController, sender: self)
                        }))
                        self.tableView.models = self.models
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
            
                case .failure(let ApiErrors):
                    print(ApiErrors)
                }
            })
        }
    }
}
