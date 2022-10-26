//
//  FinishingOptionsScrollView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 06.10.2022.
//

import UIKit

class FinishingOptionsScrollView: UIScrollView, UIScrollViewDelegate{

    var data: [String: String] = [:] {
        didSet {
            configure()
        }
    }
    var stacksView = [UIStackView]()
    
    override init(frame:CGRect = .zero) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        configure()
        
        self.delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        for (nameImage, nameOption) in data {
            let stack: UIStackView = {
                let stack = UIStackView()
                stack.axis = .vertical
                stack.alignment = .fill
                stack.spacing = 5
                
                return stack
            }()
            
            let imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFill
                imageView.image = UIImage(named: nameImage)
                imageView.clipsToBounds = true
                imageView.layer.cornerRadius = 10
                return imageView
            }()
            
            let label: UILabel = {
                let label = UILabel()
                label.text = nameOption
                label.numberOfLines = 1
                label.font = UIFont(name: "Montserrat-Medium", size: 18)
                label.textColor = UIColor(named: "mainTextColor")
                label.textAlignment = .center
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            
            stack.addArrangedSubview(imageView)
            stack.addArrangedSubview(label)
            self.addSubview(stack)
            stacksView.append(stack)
        }        
    }
    
    override func layoutSubviews() {
        for (index, imageView) in stacksView.enumerated() {
            imageView.frame.size = self.frame.size
            imageView.frame.origin.x = self.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        
        self.contentSize = CGSize(width: self.frame.width * CGFloat(stacksView.count), height: self.frame.height)
        self.isPagingEnabled = true
    }
    
    
}
