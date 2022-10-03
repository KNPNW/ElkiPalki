//
//  HouseTableViewCell.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 30.04.2022.
//

import UIKit

class HouseTableViewCell: UITableViewCell {
    
    static let indentifier = "HouseTableViewCell"
    
    let backView : UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: 370, height: 160))//  add auto width
        view.backgroundColor = UIColor(named: "ElGreen")
        view.layer.cornerRadius = 20
        return view
    }()
    
    let houseName : UILabel = {
        let text = UILabel(frame: CGRect(x: 20, y: 10, width: 370, height: 20))
        text.font = UIFont.boldSystemFont(ofSize: 20)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let houseImage : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 20, y: 45, width: 155, height: 90))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let squareImage : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 190, y: 45, width: 30, height: 30))
        imageView.image = UIImage(named: "square")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let squareCountHeader : UILabel = {
        let text = UILabel(frame: CGRect(x: 225, y: 45, width: 40, height: 10))
        text.text = "Размер"
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let squareCountInfo : UILabel = {
        let text = UILabel(frame: CGRect(x: 225, y: 65, width: 40, height: 10))
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let ladderImage : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 190, y: 105, width: 30, height: 30))
        imageView.image = UIImage(named: "stairs")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let ladderCountHeader : UILabel = {
        let text = UILabel(frame: CGRect(x: 225, y: 105, width: 40, height: 10))
        text.text = "Этажей"
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let ladderCountInfo : UILabel = {
        let text = UILabel(frame: CGRect(x: 225, y: 125, width: 40, height: 10))
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let square2Image : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 275, y: 45, width: 30, height: 30))
        imageView.image = UIImage(named: "square")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let square2CountHeader : UILabel = {
        let text = UILabel(frame: CGRect(x: 310, y: 45, width: 50, height: 10))
        text.text = "Площадь"
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let square2CountInfo : UILabel = {
        let text = UILabel(frame: CGRect(x: 310, y: 65, width: 50, height: 10))
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let bedImage : UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 275, y: 105, width: 30, height: 30))
        imageView.image = UIImage(named: "bed")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let bedCountHeader : UILabel = {
        let text = UILabel(frame: CGRect(x: 310, y: 105, width: 50, height: 10))
        text.text = "Помещ."
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    let bedCountInfo : UILabel = {
        let text = UILabel(frame: CGRect(x: 310, y: 125, width: 50, height: 10))
        text.font = UIFont.boldSystemFont(ofSize: 10)
        text.textColor = UIColor(named: "White")
        return text
    }()
    
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addSubview(backView)
        
        backView.addSubview(houseImage)
        backView.addSubview(houseName)
        
        backView.addSubview(squareImage)
        backView.addSubview(squareCountHeader)
        backView.addSubview(squareCountInfo)
        
        backView.addSubview(ladderImage)
        backView.addSubview(ladderCountHeader)
        backView.addSubview(ladderCountInfo)
        
        backView.addSubview(square2Image)
        backView.addSubview(square2CountHeader)
        backView.addSubview(square2CountInfo)
        
        backView.addSubview(bedImage)
        backView.addSubview(bedCountHeader)
        backView.addSubview(bedCountInfo)
//        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension HouseTableViewCell  {
    func setConstraints () {
        contentView.addSubview(houseImage)
        NSLayoutConstraint.activate([
            houseImage.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            houseImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            houseImage.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
}
