//
//  ObjectViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 27.09.2022.
//

import UIKit

class ObjectViewController: UIViewController {
    
    var name: String
    var objectId: String
    
    var images = [UIImageView]()
    
    private lazy var imageScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .lightGray
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var imageScrollIndicator: UIPageControl = {
        let pageController = UIPageControl()
        pageController.numberOfPages = images.count
        pageController.currentPageIndicatorTintColor = UIColor(named: "ElGreen")
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 200)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = name
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.tintColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = mainScrollView.contentSize
        return view
    }()
    
    private lazy var pilesView: PilesView = {
        let view = PilesView()
        return view
    }()
    
    private lazy var testtt: SliderView = {
        let view = SliderView(prices: ["768 831 ₽", "1 421 613 ₽", "1 827 788 ₽"], credits: ["11 922 ₽/месяц", "21 932 ₽/месяц", "28 598 ₽/месяц"])
        return view
    }()
    
    private lazy var applicationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить консультацию", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: "ElGreen")
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var infoAboutIbject: MainInfoAboutObject = {
        let view = MainInfoAboutObject()
        return view
    }()
    
    init(name: String, objectId: String) {
        self.objectId = objectId
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        let saveG = view.safeAreaLayoutGuide
        
        let imageName = ["firstHouse", "secondHouse"]
        
        infoAboutIbject.paramers = Parametrs(size: "10", square: "10", numberOfRooms: "20", numberOfFloors: "20")
        
        for name in imageName {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFill
            imageScrollView.addSubview(imageView)
            images.append(imageView)
        }
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageScrollView)
        contentView.addSubview(imageScrollIndicator)
        contentView.addSubview(pilesView)
        contentView.addSubview(testtt)
        contentView.addSubview(applicationButton)
        contentView.addSubview(infoAboutIbject)

        
        imageScrollIndicator.addTarget(self, action: #selector(pageControlDidChanged(_:)), for: .valueChanged)
        
        mainScrollView.topAnchor.constraint(equalTo: saveG.topAnchor).isActive = true
        mainScrollView.widthAnchor.constraint(equalTo: saveG.widthAnchor).isActive = true
        mainScrollView.heightAnchor.constraint(equalTo: saveG.heightAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageScrollView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//        imageScrollView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        imageScrollView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        imageScrollIndicator.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor).isActive = true
        imageScrollIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        imageScrollIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
//        imageScrollIndicator.widthAnchor.constraint(equalTo: imageScrollView.widthAnchor).isActive = true
        imageScrollIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pilesView.topAnchor.constraint(equalTo: imageScrollIndicator.bottomAnchor).isActive = true
        pilesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        pilesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        pilesView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        testtt.topAnchor.constraint(equalTo: pilesView.bottomAnchor, constant: 20).isActive = true
        testtt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        testtt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        testtt.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        applicationButton.topAnchor.constraint(equalTo: testtt.bottomAnchor, constant: 20).isActive = true
        applicationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        applicationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        applicationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        infoAboutIbject.topAnchor.constraint(equalTo: applicationButton.bottomAnchor, constant: 20).isActive = true
        infoAboutIbject.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40).isActive = true
        infoAboutIbject.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 40).isActive = true
        infoAboutIbject.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        imageScrollView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for (index, imageView) in images.enumerated() {
            imageView.frame.size = imageScrollView.frame.size
            imageView.frame.origin.x = imageScrollView.frame.width * CGFloat(index)
            imageView.frame.origin.y = 0
        }
        
        imageScrollView.contentSize = CGSize(width: imageScrollView.frame.width * CGFloat(images.count), height: imageScrollView.frame.height)
        imageScrollView.isPagingEnabled = true
    }
    
    @objc private func pageControlDidChanged(_ sender: UIPageControl) {
        let current = sender.currentPage
        imageScrollView.setContentOffset(CGPoint(x: imageScrollView.frame.width * CGFloat(current), y: 0), animated: true)
    }
    
}

extension ObjectViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        imageScrollIndicator.currentPage = Int(floorf(Float(imageScrollView.contentOffset.x) / Float(imageScrollView.frame.size.width)))
    }
}
