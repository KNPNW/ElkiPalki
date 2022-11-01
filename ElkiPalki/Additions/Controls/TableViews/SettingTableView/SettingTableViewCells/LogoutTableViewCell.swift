//
//  TextTableViewCell.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 08.09.2022.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    static let identifier = "LogoutTableViewCell"
    
    private let generalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "rectangle.portrait.and.arrow.right")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Medium", size: 15)
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        generalStack.addArrangedSubview(label)
        generalStack.addArrangedSubview(iconImageView)
        contentView.addSubview(generalStack)
        
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        generalStack.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        generalStack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        contentView.backgroundColor = nil
    }
    
    public func configure(with model: SettingTableView.LogoutSettingOption) {
        label.text = model.title
        contentView.backgroundColor = model.color
    }

}
