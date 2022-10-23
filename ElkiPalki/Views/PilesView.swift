//
//  PilesView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 28.09.2022.
//

import UIKit

class PilesView: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "svai")
        imageView.frame = CGRect(x: 20, y: 10, width: 80, height: 80)
        return imageView
    }()
    
    private lazy var greenLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "ElGreen")
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Bold", size: 18)
        label.text = "Свайный фундамент"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var blackLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Medium", size: 15)
        label.text = "включен в стоимость"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        configure()
    }
    
    override func layoutSubviews() {
        dropShadow()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(imageView)
        addSubview(stackView)
        stackView.addArrangedSubview(greenLabel)
        stackView.addArrangedSubview(blackLabel)
        
        stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        greenLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        greenLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        blackLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        blackLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

}
