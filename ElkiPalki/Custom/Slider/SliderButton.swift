//
//  SliderButton.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 28.09.2022.
//

import UIKit

struct SliderButtonModel {
    let label: String
    let normalImageName: String
    let activeImageName: String
}

class SliderButton: UIButton {
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    let image: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let viewModel: SliderButtonModel?
    
    override init(frame: CGRect) {
        self.viewModel = nil
        super.init(frame: frame)
    }
    
    init(with viewModel: SliderButtonModel) {
        self.viewModel = viewModel
        
        super.init(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        configure()
        self.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        label.text = self.viewModel?.label
        image.image = UIImage(named: (self.viewModel?.normalImageName)!)
    }
    
//    func changeColor() {
//        image.image = UIImage(named: (self.viewModel?.activeImageName)!)
//        print("tap")
//        self.setNeedsDisplay()
//    }
    
    
    override func layoutSubviews() {
        image.frame = CGRect(x: self.frame.width/2-25, y: 10, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: 60, width: self.frame.width, height: self.frame.height-image.frame.maxY).integral
    }
}

