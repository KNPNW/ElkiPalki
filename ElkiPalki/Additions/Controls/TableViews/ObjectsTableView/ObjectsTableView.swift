import UIKit

class ObjectsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    struct Section {
        let title: String
        var options: [ObjectOptions]
    }

    struct ObjectOptions {
        let object: ObjectMainInfo
        let handler: (()->Void)
        
    }
    
    var models = [Section]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor(named: "mainBackGroungColor")
        self.register(ObjectTableViewCell.self, forCellReuseIdentifier: ObjectTableViewCell.identifier)
        
        self.delegate = self
        self.dataSource = self
        self.separatorStyle = .none
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 470
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
