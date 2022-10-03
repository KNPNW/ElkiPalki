//
//  TextTableViewCell.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 08.09.2022.
//

import UIKit

class LogoutTableViewCell: UITableViewCell {

    static let identifier = "LogoutTableViewCell"
    
    private lazy var contenerView: UIView = {
        let view = UIView(frame: CGRect(x: self.contentView.frame.size.width/2-65, y: self.contentView.frame.size.height/2-20, width: 130, height: contentView.frame.size.height))
        return view
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
        label.textColor = .white
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contenerView.addSubview(label)
        contenerView.addSubview(iconImageView)
        contentView.addSubview(contenerView)
        
        contentView.clipsToBounds = true
        accessoryType = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size: CGFloat = contentView.frame.size.height - 12
        let imageSize: CGFloat = size/1.5
        
        
        contenerView.frame = CGRect(x: (self.contentView.frame.size.width/2)-40, y: 0, width: 130, height: contentView.frame.size.height)
        iconImageView.frame = CGRect(x: 60 + label.frame.size.width, y: 12, width: imageSize, height: imageSize)
        
   
        
        label.frame = CGRect(x: 0, y: 0, width: 100, height: contentView.frame.size.height)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        contentView.backgroundColor = nil
    }
    
    public func configure(with model: AccountLogoutOptions) {
        label.text = model.title
        contentView.backgroundColor = model.color
    }

}
