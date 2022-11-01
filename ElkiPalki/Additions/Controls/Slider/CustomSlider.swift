//
//  CustomSlider.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 28.09.2022.
//

import UIKit

class CustomSlider: UIControl {
    
    var buttonTitles = [String]()
    var normalImage = [String]()
    var activeImage = [String]()
//    var buttons = [UIButton]()
    var buttons = [SliderButton]()
    
    var selectedSegmentIndex = 0

    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: buttons)
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    init(frame: CGRect = .zero, commaSeparatedtitels: String, commaSeparatedNormalImages: String, commaSeparatedActiveImages: String) {
        super.init(frame: frame)
        self.buttonTitles = commaSeparatedtitels.components(separatedBy: ",")
        self.normalImage = commaSeparatedNormalImages.components(separatedBy: ",")
        self.activeImage = commaSeparatedActiveImages.components(separatedBy: ",")
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor(named: "mainBackGroungColor")
//        self.clipsToBounds = true
//        self.layer.cornerRadius = 10
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        buttons.removeAll()
        
        subviews.forEach { $0.removeFromSuperview() }
        
        for (index, buttonTitle) in buttonTitles.enumerated() {
            let button = SliderButton(with: SliderButtonModel(label: buttonTitle, normalImageName: normalImage[index], activeImageName: activeImage[index]))
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            buttons.append(button)
        }
        buttons[0].image.image = UIImage(named: buttons[0].viewModel?.activeImageName ?? "")
        
        addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    @objc func buttonTapped(button: SliderButton!) {
        for (index, btn) in buttons.enumerated() {
            if btn == button {
                self.selectedSegmentIndex = index
                button.image.image = UIImage(named: button.viewModel?.activeImageName ?? "")
                sendAction(#selector(SliderView.customSegmentValueChanged), to: nil, for: nil)
            } else {
                btn.image.image = UIImage(named: btn.viewModel?.normalImageName ?? "")
            }
        }
    }

}
