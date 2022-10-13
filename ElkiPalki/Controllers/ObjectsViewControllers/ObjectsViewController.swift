import UIKit

struct SectionObject {
    let title: String
    var options: [ObjectOptions]
}

struct ObjectOptions {
    let object: Info
    let handler: (()->Void)
    
}

class ObjectsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private lazy var tableView : UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), style: .grouped)
        tableView.register(ObjectTableViewCell.self, forCellReuseIdentifier: ObjectTableViewCell.identifier)
        tableView.backgroundColor = .white
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
        
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
                                self.show(ObjectViewController(objectId: String(object.id)), sender: self)
                            }))
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
                    print(allObjects)
                    for (_, object) in allObjects.objects.enumerated() {
                        self.models[0].options.append(ObjectOptions(object: object, handler: {
                            self.show(ObjectViewController(objectId: String(object.id)), sender: self)
                        }))
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
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 490
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section].options[indexPath.row]

        guard let cell = tableView.dequeueReusableCell( withIdentifier: ObjectTableViewCell.identifier, for: indexPath) as? ObjectTableViewCell else { return UITableViewCell() }
        cell.configure(with: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = models[indexPath.section].options[indexPath.row]
        model.handler()
    }
}

