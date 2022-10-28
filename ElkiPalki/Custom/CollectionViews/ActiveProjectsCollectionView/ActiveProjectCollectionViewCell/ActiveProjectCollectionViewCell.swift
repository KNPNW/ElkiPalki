//
//  ActiveProjectCollectionViewCell.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 28.10.2022.
//

import UIKit

class ActiveProjectCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ActiveProjectCollectionViewCell"
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }

    private var expandedConstraintCell: NSLayoutConstraint!

    private var collapsedConstraintCell: NSLayoutConstraint!
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var bodyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "secondBackGroungColor")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.down")!.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = UIColor(named: "mainTextColor")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contractNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Bold", size: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateOfConclusionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var responsibleManagerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Ответсвенный менеджер:"
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var responsibleManagerInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private lazy var dateStartOfConstructionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Начало строительства:"
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateStartOfConstructionInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var customerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Заказчик:"
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var customerInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contractStageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Стадия договора:"
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contractStageInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Gilroy-Medium", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var additionalStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var additionalLabels = [self.responsibleManagerLabel, self.dateStartOfConstructionLabel, self.customerLabel, self.contractStageLabel]
    lazy var additionalInfoLabels = [self.responsibleManagerInfoLabel, self.dateStartOfConstructionInfoLabel, self.customerInfoLabel, self.contractStageInfoLabel]
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.dropShadow()
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        contentView.addSubview(mainView)
        
        headView.addSubview(arrowImageView)
        headView.addSubview(mainStackView)
        
        bodyView.addSubview(additionalStackView)
        
        mainStackView.addArrangedSubview(contractNumberLabel)
        mainStackView.addArrangedSubview(dateOfConclusionLabel)
        
        mainView.addSubview(headView)
        mainView.addSubview(bodyView)
        
        
        setConstraints()
        setAdditionalView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateAppearance() {
        collapsedConstraintCell.isActive = !isSelected
        expandedConstraintCell.isActive = isSelected
        
        
        UIView.animate(withDuration: 0.3) {
            let upsideDown = CGAffineTransform(rotationAngle: .pi * -0.999)
            self.arrowImageView.transform = self.isSelected ? upsideDown: .identity
            self.dropShadow()
        }
    }
    
    private func setAdditionalView () {
        for (index, _) in additionalLabels.enumerated() {
            let stackView: UIStackView = {
                let stack = UIStackView(arrangedSubviews: [additionalLabels[index], additionalInfoLabels[index]])
                stack.axis = .vertical
                return stack
            }()
            
            additionalStackView.addArrangedSubview(stackView)
        }
        
    }
    
    private func setConstraints () {
        mainView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        headView.topAnchor.constraint(equalTo: mainView.topAnchor).isActive = true
        headView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        headView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        headView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        collapsedConstraintCell = headView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        collapsedConstraintCell.priority = .defaultLow
        
        arrowImageView.trailingAnchor.constraint(equalTo: headView.trailingAnchor, constant: -20).isActive = true
        arrowImageView.centerYAnchor.constraint(equalTo: headView.centerYAnchor).isActive = true
        arrowImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        arrowImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        mainStackView.centerYAnchor.constraint(equalTo: headView.centerYAnchor).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: headView.leadingAnchor, constant: 20).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -10).isActive = true
        mainStackView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        bodyView.topAnchor.constraint(equalTo: headView.bottomAnchor).isActive = true
        bodyView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        bodyView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
                
        expandedConstraintCell = bodyView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor)
        expandedConstraintCell.priority = .defaultLow
        
        additionalStackView.topAnchor.constraint(equalTo: bodyView.topAnchor, constant: 20).isActive = true
        additionalStackView.leadingAnchor.constraint(equalTo: bodyView.leadingAnchor, constant: 20).isActive = true
        additionalStackView.trailingAnchor.constraint(equalTo: bodyView.trailingAnchor, constant: -20).isActive = true
        additionalStackView.bottomAnchor.constraint(equalTo: bodyView.bottomAnchor, constant: -20).isActive = true
    }
    
    public func setInfo(with model: ActiveProjectCollectionView.ActiveProjectOptions) {
        contractNumberLabel.text = "Договор №\(model.main.numberContract)"
        dateOfConclusionLabel.text = "от \(model.main.dateOfConclusion)"
        
        responsibleManagerInfoLabel.text = model.additional.responsibleManager
        dateStartOfConstructionInfoLabel.text = model.additional.dateStartOfConstruction
        customerInfoLabel.text = model.additional.customer
        contractStageInfoLabel.text = model.additional.contractStage
    }
    
}
    

