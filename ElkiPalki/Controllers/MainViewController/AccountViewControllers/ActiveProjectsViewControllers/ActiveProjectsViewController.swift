import UIKit

class ActiveProjectsViewController: UIViewController {
    
    private lazy var collectionView: ActiveProjectCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = ActiveProjectCollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var models = [ActiveProjectCollectionView.ActiveProjectOptions]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = NSLocalizedString("Active projects", comment: "")
        
        configure()
        
        view.addSubview(collectionView)
        
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setConstraints () {
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func configure() {
        models.append(ActiveProjectCollectionView.ActiveProjectOptions(main: ActiveProjectCollectionView.mainActiveProjectOptions(numberContract: "231231", dateOfConclusion: "01.02.2022"), additional: ActiveProjectCollectionView.additionalActiveProjectOptions(responsibleManager: "Золотиков Максим Юрьевич", dateStartOfConstruction: "Не указано", customer: "Коваленко Владимир Игорьевич", contractStage: "Ожидает оплаты")))
        
        models.append(ActiveProjectCollectionView.ActiveProjectOptions(main: ActiveProjectCollectionView.mainActiveProjectOptions(numberContract: "322133", dateOfConclusion: "10.11.2021"), additional: ActiveProjectCollectionView.additionalActiveProjectOptions(responsibleManager: "Иванов Артем Евгеньевич", dateStartOfConstruction: "28.10.2022", customer: "Коваленко Владимир Игорьевич", contractStage: "Строится")))
        
        models.append(ActiveProjectCollectionView.ActiveProjectOptions(main: ActiveProjectCollectionView.mainActiveProjectOptions(numberContract: "231231", dateOfConclusion: "10.11.2022"), additional: ActiveProjectCollectionView.additionalActiveProjectOptions(responsibleManager: "Иванов Артем Евгеньевич", dateStartOfConstruction: "18.11.2022", customer: "Коваленко Владимир Игорьевич", contractStage: "Ожидает строительства")))
        
        collectionView.models = models
    }

}
