//
//  ActiveProjectCollectionView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 28.10.2022.
//

import UIKit

class ActiveProjectCollectionView: UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    struct ActiveProjectOptions {
        let main: mainActiveProjectOptions
        let additional: additionalActiveProjectOptions
    }
    
    struct mainActiveProjectOptions {
        let numberContract: String
        let dateOfConclusion: String
    }
    
    struct additionalActiveProjectOptions {
        let responsibleManager: String
        let dateStartOfConstruction: String
        let customer: String
        let contractStage: String
    }
    
    var models = [ActiveProjectOptions]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = UIColor(named: "mainBackGroungColor")
        
        self.delegate = self
        self.dataSource = self
        self.alwaysBounceVertical = true
        self.allowsMultipleSelection = true
        
        self.register(ActiveProjectCollectionViewCell.self, forCellWithReuseIdentifier: ActiveProjectCollectionViewCell.identifier)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = models[indexPath.row]
    
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActiveProjectCollectionViewCell.identifier, for: indexPath) as? ActiveProjectCollectionViewCell else { return UICollectionViewCell() }
        cell.setInfo(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        return CGSize(width: collectionView.bounds.width-40, height: isSelected ? 290 : 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        collectionView.deselectItem(at: indexPath, animated: true)
        collectionView.performBatchUpdates(nil)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        collectionView.performBatchUpdates(nil)
        return true
    }
}
