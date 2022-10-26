//
//  SliderView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 29.09.2022.
//

import UIKit

class SliderView: UIView {
    
    var prices = [String]() {
        didSet {
            changeText()
        }
    }
    var credits = [String]() {
        didSet {
            changeText()
        }
    }
    
    
    private lazy var costLabel: UILabel = {
        let label = UILabel()
        label.text = "Стоимость"
        label.textAlignment = .center
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Montserrat-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "ElGreen")
        label.font = UIFont(name: "Montserrat-Medium", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var creditLabel: UILabel = {
        let label = UILabel()
        label.text = "В кредит"
        label.textAlignment = .center
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Montserrat-Bold", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creditValueLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor(named: "mainTextColor")
        label.font = UIFont(name: "Montserrat-Medium", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var creditStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var priceStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .systemGray6
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var sliderControll: CustomSlider = {
        let slider = CustomSlider(commaSeparatedtitels: "Силовой\nкаркас,Закрытый\nконтур,С чистовой\nотделкой", commaSeparatedNormalImages: "variant-1-gray,variant-2-gray,variant-3-gray", commaSeparatedActiveImages: "variant-1,variant-2,variant-3")
        return slider
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configure()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func changeText() {
        if (prices.count != 0 && credits.count != 0) {
            self.costValueLabel.text = self.prices[0]
            self.creditValueLabel.text = self.credits[0]
        }
    }
    
    private func configure() {
        costStack.addArrangedSubview(costLabel)
        costStack.addArrangedSubview(costValueLabel)
        
        creditStack.addArrangedSubview(creditLabel)
        creditStack.addArrangedSubview(creditValueLabel)
        
        priceStack.addArrangedSubview(costStack)
        priceStack.addArrangedSubview(creditStack)
        
        addSubview(sliderControll)
        addSubview(priceStack)
        
        sliderControll.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sliderControll.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sliderControll.heightAnchor.constraint(equalToConstant: 100).isActive = true
    
        priceStack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        priceStack.topAnchor.constraint(equalTo: sliderControll.bottomAnchor).isActive = true
        priceStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        costStack.topAnchor.constraint(equalTo: priceStack.topAnchor).isActive = true
        costStack.bottomAnchor.constraint(equalTo: priceStack.bottomAnchor).isActive = true
        costStack.leadingAnchor.constraint(equalTo: priceStack.leadingAnchor).isActive = true
        costStack.trailingAnchor.constraint(equalTo: priceStack.centerXAnchor, constant: -20).isActive = true
        
        creditStack.topAnchor.constraint(equalTo: priceStack.topAnchor).isActive = true
        creditStack.bottomAnchor.constraint(equalTo: priceStack.bottomAnchor).isActive = true
        creditStack.leadingAnchor.constraint(equalTo: costStack.trailingAnchor).isActive = true
        creditStack.trailingAnchor.constraint(equalTo: priceStack.trailingAnchor).isActive = true
        
        
        costLabel.topAnchor.constraint(equalTo: costStack.topAnchor, constant: 20).isActive = true
        costLabel.widthAnchor.constraint(equalTo: costStack.widthAnchor).isActive = true
        costLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        costValueLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor).isActive = true
        costValueLabel.widthAnchor.constraint(equalTo: costStack.widthAnchor).isActive = true
        costValueLabel.bottomAnchor.constraint(equalTo: costStack.bottomAnchor).isActive = true
        
        creditLabel.topAnchor.constraint(equalTo: creditStack.topAnchor, constant: 20).isActive = true
        creditLabel.widthAnchor.constraint(equalTo: creditStack.widthAnchor).isActive = true
        creditLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        creditValueLabel.topAnchor.constraint(equalTo: creditLabel.bottomAnchor).isActive = true
        creditValueLabel.widthAnchor.constraint(equalTo: creditStack.widthAnchor).isActive = true
        creditValueLabel.bottomAnchor.constraint(equalTo: creditStack.bottomAnchor).isActive = true
        
    }
    
    @objc func customSegmentValueChanged(_ sender: CustomSlider) {
        UILabel.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
            self.costValueLabel.frame.origin.y = self.costValueLabel.frame.origin.y-15
            self.creditValueLabel.frame.origin.y = self.creditValueLabel.frame.origin.y-15
            
            UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                self.costValueLabel.alpha = 0
                self.creditValueLabel.alpha = 0
            }
        }, completion: { _ in
            self.costValueLabel.text = self.prices[sender.selectedSegmentIndex]
            self.creditValueLabel.text = self.credits[sender.selectedSegmentIndex]
            
            self.costValueLabel.frame.origin.y = self.costValueLabel.frame.origin.y + 30
            self.creditValueLabel.frame.origin.y = self.creditValueLabel.frame.origin.y + 30
            
            UILabel.animateKeyframes(withDuration: 0.5, delay: 0.0, options: .calculationModeLinear, animations: {
                self.costValueLabel.frame.origin.y = self.costValueLabel.frame.origin.y-15
                self.creditValueLabel.frame.origin.y = self.creditValueLabel.frame.origin.y-15
                
                UILabel.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1) {
                    self.costValueLabel.alpha = 1
                    self.creditValueLabel.alpha = 1
                }
                
            }, completion: nil)
        })
    }
}
