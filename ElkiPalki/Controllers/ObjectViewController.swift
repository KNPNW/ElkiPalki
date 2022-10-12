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
        pageController.currentPageIndicatorTintColor = UIColor(named: "ElGreen")
        pageController.pageIndicatorTintColor = .systemGray6
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 700)
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
        let view = SliderView() //prices: ["768 831 ₽", "1 421 613 ₽", "1 827 788 ₽"], credits: ["11 922 ₽/месяц", "21 932 ₽/месяц", "28 598 ₽/месяц"]
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
        let view = MainInfoAboutObject(addShadow: true)
        return view
    }()
    
    
    private lazy var interiorDecorationView: FinishingOptionsView = {
        let view = FinishingOptionsView(sectionName: "Варианты внутренней отделки:", data: ["option1":"Под покраску или обои",
                                                                                            "option2":"Вагонка, имитация бруса",
                                                                                            "option3":"Фанера, шпон",
                                                                                            "option4":"Стендовые панели"])
        return view
    }()
    
    private lazy var exteriorDecorationView: FinishingOptionsView = {
        let view = FinishingOptionsView(sectionName: "Варианты наружней отделки:", data: ["option11":"Имитация бруса",
                                                                                            "option12":"Клинкерный кирпич",
                                                                                            "option13":"Металл, дерево",
                                                                                            "option14":"Штукатурный фасад"])
        return view
    }()
    
    
    private lazy var moreDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = UIColor(named: "ElGreen")
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        
        infoAboutIbject.paramers = Parametrs(size: "10", square: "10", numberOfRooms: "20", numberOfFloors: "20")
        
//        for name in imageName {
//            let image = UIImage(named: name)
//            let imageView = UIImageView(image: image)
//            imageView.contentMode = .scaleAspectFill
//            imageScrollView.addSubview(imageView)
//            images.append(imageView)
//        }
        downloadImages(objectId: objectId)
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageScrollView)
        contentView.addSubview(imageScrollIndicator)
        contentView.addSubview(pilesView)
        contentView.addSubview(testtt)
        contentView.addSubview(applicationButton)
        contentView.addSubview(infoAboutIbject)
        contentView.addSubview(interiorDecorationView)
        contentView.addSubview(exteriorDecorationView)
        contentView.addSubview(moreDetailButton)
        
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
        
        pilesView.topAnchor.constraint(equalTo: imageScrollIndicator.bottomAnchor, constant: 10).isActive = true
        pilesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        pilesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        pilesView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        infoAboutIbject.topAnchor.constraint(equalTo: pilesView.bottomAnchor, constant: 30).isActive = true
        infoAboutIbject.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        infoAboutIbject.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        infoAboutIbject.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        testtt.topAnchor.constraint(equalTo: infoAboutIbject.bottomAnchor, constant: 20).isActive = true
        testtt.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        testtt.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        testtt.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        applicationButton.topAnchor.constraint(equalTo: testtt.bottomAnchor, constant: 20).isActive = true
        applicationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        applicationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        applicationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        interiorDecorationView.topAnchor.constraint(equalTo: applicationButton.bottomAnchor, constant: 20).isActive = true
        interiorDecorationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        interiorDecorationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        interiorDecorationView.heightAnchor.constraint(equalToConstant: 305).isActive = true
        
        exteriorDecorationView.topAnchor.constraint(equalTo: interiorDecorationView.bottomAnchor).isActive = true
        exteriorDecorationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        exteriorDecorationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        exteriorDecorationView.heightAnchor.constraint(equalToConstant: 305).isActive = true
        
        moreDetailButton.topAnchor.constraint(equalTo: exteriorDecorationView.bottomAnchor, constant: 20).isActive = true
        moreDetailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        moreDetailButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        moreDetailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        imageScrollView.delegate = self
        
    }
    
    private func downloadImages (objectId: String) {
        
        let getInfo = ApiRequest(endPoint: "api/getFullInfoAboutObject/?object_id=\(objectId)")
        
        getInfo.getFullInfoAboutObject { result in
            switch result {
            case .success(let NewObject):
                print(NewObject)
                DispatchQueue.main.async {
                    self.infoAboutIbject.paramers = Parametrs(size: NewObject.mainInfo.size, square: String(NewObject.mainInfo.square), numberOfRooms: String(NewObject.mainInfo.numberOfRooms), numberOfFloors: NewObject.mainInfo.numberOfFloors)
                    self.testtt.prices = [NewObject.prices.fullFirstPrice, NewObject.prices.fullSecondPrice, NewObject.prices.fullThridPrice]
                    self.testtt.credits = [NewObject.prices.creditFirstPrice, NewObject.prices.creditSecondPrice, NewObject.prices.creditThridPrice]
                }
                let serialQueue = DispatchQueue(label: "queuename")
                serialQueue.sync {
                    for (_, link) in NewObject.linksOnImages.enumerated() {
                        
                        let getImage = ApiRequest(endPoint: link.linkOnImage)
                        
                        getImage.getImage { result in
                            switch result {
                                
                            case .success(let image) :
                                DispatchQueue.main.sync {
                                    
                                    let finalImage = self.cropImage(image: UIImage(data: image)!)
                                    let imageView = UIImageView(image: finalImage)
                                    imageView.contentMode = .scaleAspectFill
                                    self.imageScrollView.addSubview(imageView)
                                    self.images.append(imageView)
                                    
                                    self.imageScrollIndicator.numberOfPages = NewObject.linksOnImages.count
                                    
                                    
                                    for (index, imageView) in self.images.enumerated() {
                                        imageView.frame.size = self.imageScrollView.frame.size
                                        imageView.frame.origin.x = self.imageScrollView.frame.width * CGFloat(index)
                                        imageView.frame.origin.y = 0
                                    }
                                    
                                    self.imageScrollView.contentSize = CGSize(width: self.imageScrollView.frame.width * CGFloat(self.images.count), height: self.imageScrollView.frame.height)
                                    self.imageScrollView.isPagingEnabled = true
                                }
                            case .failure(let ApiError): print(ApiError)
                            }
                        }
                    }
                }
            case .failure(let ApiError): print(ApiError)
            }
        }
        
//        getInfo.getFullInfoAboutObject(completion: { result in
//            switch result {
//            case .success(let NewObject):
//                print(NewObject)
//                let serialQueue = DispatchQueue(label: "queuename")
//                serialQueue.sync {
//                    for (_, link) in NewObject.links.enumerated() {
//
//                        let getImage = ApiRequest(endPoint: link.linkOnImage)
//
//                        getImage.getImage { result in
//                            switch result {
//
//                            case .success(let image) :
//                                DispatchQueue.main.sync {
//
//                                    let finalImage = self.cropImage(image: UIImage(data: image)!)
//                                    let imageView = UIImageView(image: finalImage)
//                                    imageView.contentMode = .scaleAspectFill
//                                    self.imageScrollView.addSubview(imageView)
//                                    self.images.append(imageView)
//
//                                    self.imageScrollIndicator.numberOfPages = NewObject._links.count
//
//
//                                    for (index, imageView) in self.images.enumerated() {
//                                        imageView.frame.size = self.imageScrollView.frame.size
//                                        imageView.frame.origin.x = self.imageScrollView.frame.width * CGFloat(index)
//                                        imageView.frame.origin.y = 0
//                                    }
//
//                                    self.imageScrollView.contentSize = CGSize(width: self.imageScrollView.frame.width * CGFloat(self.images.count), height: self.imageScrollView.frame.height)
//                                    self.imageScrollView.isPagingEnabled = true
//                                }
//
//                            case .failure(let ApiError):
//                                print(ApiError)
//                            }
//                        }
//                    }
//                }
//
//            case .failure(let error):
//                print(error)
//            }
//        })
    }

    
    func cropImage(image: UIImage) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.width*0.6875) //    1536 x 2048 pixels

        let cgImage = image.cgImage!

        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }

    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        for (index, imageView) in images.enumerated() {
//            imageView.frame.size = imageScrollView.frame.size
//            imageView.frame.origin.x = imageScrollView.frame.width * CGFloat(index)
//            imageView.frame.origin.y = 0
//        }
//
//        imageScrollView.contentSize = CGSize(width: imageScrollView.frame.width * CGFloat(images.count), height: imageScrollView.frame.height)
//        imageScrollView.isPagingEnabled = true
//    }
//
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
