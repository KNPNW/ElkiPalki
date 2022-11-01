//
//  FinishingOptionsView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 06.10.2022.
//

import UIKit

class FinishingOptionsView: UIView {
    
    let sectionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Bold", size: 19)
        label.textColor = UIColor(named: "mainTextColor")
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let optionsScrollView: FinishingOptionsScrollView = {
        let scrollView = FinishingOptionsScrollView()
        return scrollView
    }()
    
    private lazy var scrollIndicator: UIPageControl = {
        let pageController = UIPageControl()
//        pageController.numberOfPages = data.count
        pageController.currentPageIndicatorTintColor = UIColor(named: "ElGreen")
        pageController.pageIndicatorTintColor = .systemGray5
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    var data = [String: String]()
    
    init(frame: CGRect = .zero, sectionName: String, data: [String : String]) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(sectionLabel)
        self.addSubview(optionsScrollView)
        self.addSubview(scrollIndicator)
        optionsScrollView.data = data
        scrollIndicator.numberOfPages = data.count
        
        configure(sectionName: sectionName)
        
        scrollIndicator.addTarget(self, action: #selector(pageControlDidChanged(_:)), for: .valueChanged)
        optionsScrollView.delegate = self
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(sectionName: String) {
        sectionLabel.text = sectionName
        
        sectionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sectionLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sectionLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        optionsScrollView.topAnchor.constraint(equalTo: sectionLabel.bottomAnchor).isActive = true
        optionsScrollView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        optionsScrollView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        
        scrollIndicator.topAnchor.constraint(equalTo: optionsScrollView.bottomAnchor).isActive = true
        scrollIndicator.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        scrollIndicator.heightAnchor.constraint(equalToConstant: 25).isActive = true
    }
    
    @objc private func pageControlDidChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        optionsScrollView.setContentOffset(CGPoint(x: optionsScrollView.frame.width * CGFloat(current), y: 0), animated: true)
    }
}

extension FinishingOptionsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollIndicator.currentPage = Int(floorf(Float(optionsScrollView.contentOffset.x) / Float(optionsScrollView.frame.size.width)))
    }
}
