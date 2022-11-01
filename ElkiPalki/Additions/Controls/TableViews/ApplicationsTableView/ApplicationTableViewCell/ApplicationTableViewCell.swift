//
//  ApplicationTableViewCell.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 28.10.2022.
//

import UIKit

class ApplicationTableViewCell: UITableViewCell {
    
    static let identifier = "ApplicationTableViewCell"
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var applicationNumberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Gilroy-Bold", size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var objectApplicationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Gilroy-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusApplicationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .left
        label.font = UIFont(name: "Gilroy-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var statusApplicationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "mainBackGroungColor")
        
        contentView.addSubview(shadowView)
        
        shadowView.addSubview(applicationNumberLabel)
        shadowView.addSubview(objectApplicationLabel)
        shadowView.addSubview(statusApplicationImageView)
        shadowView.addSubview(statusApplicationLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        shadowView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        shadowView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        shadowView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        applicationNumberLabel.topAnchor.constraint(equalTo: shadowView.topAnchor, constant: 20).isActive = true
        applicationNumberLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        applicationNumberLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true
        applicationNumberLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        objectApplicationLabel.topAnchor.constraint(equalTo: applicationNumberLabel.bottomAnchor).isActive = true
        objectApplicationLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        objectApplicationLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true
        objectApplicationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        statusApplicationImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20).isActive = true
        statusApplicationImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        statusApplicationImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        statusApplicationImageView.centerYAnchor.constraint(equalTo: objectApplicationLabel.bottomAnchor, constant: 15).isActive = true
        
        statusApplicationLabel.centerYAnchor.constraint(equalTo: statusApplicationImageView.centerYAnchor).isActive = true
        statusApplicationLabel.leadingAnchor.constraint(equalTo: statusApplicationImageView.trailingAnchor, constant: 10).isActive = true
        statusApplicationLabel.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor, constant: -20).isActive = true
        statusApplicationLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    public func configure(with model: ApplicationsTableView.ApplicationOptions) {
        
        applicationNumberLabel.text =  "\(NSLocalizedString("Application", comment: "")) №\(model.numberApplication)"
        objectApplicationLabel.text = model.objectApplication
        
        switch model.state {
        case .sent:
            statusApplicationLabel.text = NSLocalizedString("Sent", comment: "")
            shadowView.dropShadow(shadowColor: UIColor(named: "sentApplicationColor")!)
            statusApplicationImageView.image = UIImage(named: "sentIcon")
        case .closed:
            statusApplicationLabel.text = NSLocalizedString("Closed", comment: "")
            shadowView.dropShadow(shadowColor: UIColor(named: "closedApplicationColor")!)
            statusApplicationImageView.image = UIImage(named: "closedIcon")
        case .inProcessing:
            statusApplicationLabel.text = NSLocalizedString("In processing", comment: "")
            shadowView.dropShadow(shadowColor: UIColor(named: "inProcessingApplicationColor")!)
            statusApplicationImageView.image = UIImage(named: "inProcessingIcon")
        }
    }
    
}
