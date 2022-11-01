import UIKit
import SafariServices

class ObjectViewController: UIViewController {
    
    var objectId: String
    var url: String?
    var images = [UIImageView]()
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 700)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = mainScrollView.contentSize
        return view
    }()
    
    private lazy var objectNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Medium", size: 22)
        label.textColor = UIColor(named: "mainTextColor")
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageScrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .lightGray
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let imageScrollIndicator: UIPageControl = {
        let pageController = UIPageControl()
        pageController.currentPageIndicatorTintColor = UIColor(named: "ElGreen")
        pageController.pageIndicatorTintColor = .systemGray5
        pageController.translatesAutoresizingMaskIntoConstraints = false
        return pageController
    }()
    
    let pilesView: PilesView = {
        let view = PilesView()
        return view
    }()
    
    private lazy var infoAboutObjectView: InfoAboutObjectView = {
        let view = InfoAboutObjectView(addShadow: true)
        return view
    }()
    
    let priceSliderView: SliderView = {
        let view = SliderView()
        return view
    }()
    
    private lazy var getConsultationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить консультацию", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 17)
        button.backgroundColor = UIColor(named: "ElGreen")
        button.setTitleColor(UIColor(named: "mainButtonTextColor"), for: UIControl.State.normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let interiorDecorationView: FinishingOptionsView = {
        let view = FinishingOptionsView(sectionName: "Варианты внутренней отделки:", data: ["option1":"Под покраску или обои",
                                                                                            "option2":"Вагонка, имитация бруса",
                                                                                            "option3":"Фанера, шпон",
                                                                                            "option4":"Стендовые панели"])
        return view
    }()
    
    let exteriorDecorationView: FinishingOptionsView = {
        let view = FinishingOptionsView(sectionName: "Варианты наружней отделки:", data: ["option11":"Имитация бруса",
                                                                                            "option12":"Клинкерный кирпич",
                                                                                            "option13":"Металл, дерево",
                                                                                            "option14":"Штукатурный фасад"])
        return view
    }()
    
    
    private lazy var moreDetailButton: UIButton = {
        let button = UIButton()
        button.setTitle("Подробнее на сайте", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat-Medium", size: 17)
        button.backgroundColor = UIColor(named: "ElGreen")
        button.setTitleColor(UIColor(named: "mainButtonTextColor"), for: UIControl.State.normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(objectId: String) {
        self.objectId = objectId
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getFullInfoAboutObject()
    
        view.backgroundColor = UIColor(named: "mainBackGroungColor")
        
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(contentView)
        
        contentView.addSubview(objectNameLabel)
        contentView.addSubview(imageScrollView)
        contentView.addSubview(imageScrollIndicator)
        contentView.addSubview(pilesView)
        contentView.addSubview(priceSliderView)
        contentView.addSubview(getConsultationButton)
        contentView.addSubview(infoAboutObjectView)
        contentView.addSubview(interiorDecorationView)
        contentView.addSubview(exteriorDecorationView)
        contentView.addSubview(moreDetailButton)
        
        imageScrollIndicator.addTarget(self, action: #selector(pageControlDidChanged(_:)), for: .valueChanged)
        moreDetailButton.addTarget(self, action: #selector(openUrl), for: .touchUpInside)
        
        imageScrollView.delegate = self
        
        setConstraints()
    }
    
    private func setConstraints () {
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        mainScrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        objectNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        objectNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        objectNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        objectNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        imageScrollView.topAnchor.constraint(equalTo: objectNameLabel.bottomAnchor, constant: 20).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageScrollView.heightAnchor.constraint(equalToConstant: 190).isActive = true
        
        imageScrollIndicator.topAnchor.constraint(equalTo: imageScrollView.bottomAnchor).isActive = true
        imageScrollIndicator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        imageScrollIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        imageScrollIndicator.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        pilesView.topAnchor.constraint(equalTo: imageScrollIndicator.bottomAnchor, constant: 10).isActive = true
        pilesView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        pilesView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        pilesView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        infoAboutObjectView.topAnchor.constraint(equalTo: pilesView.bottomAnchor, constant: 30).isActive = true
        infoAboutObjectView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        infoAboutObjectView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        infoAboutObjectView.heightAnchor.constraint(equalToConstant: 135).isActive = true
        
        priceSliderView.topAnchor.constraint(equalTo: infoAboutObjectView.bottomAnchor, constant: 20).isActive = true
        priceSliderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        priceSliderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        priceSliderView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        getConsultationButton.topAnchor.constraint(equalTo: priceSliderView.bottomAnchor, constant: 20).isActive = true
        getConsultationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        getConsultationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        getConsultationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        interiorDecorationView.topAnchor.constraint(equalTo: getConsultationButton.bottomAnchor, constant: 20).isActive = true
        interiorDecorationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        interiorDecorationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        interiorDecorationView.heightAnchor.constraint(equalToConstant: 305).isActive = true
        
        exteriorDecorationView.topAnchor.constraint(equalTo: interiorDecorationView.bottomAnchor).isActive = true
        exteriorDecorationView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        exteriorDecorationView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        exteriorDecorationView.heightAnchor.constraint(equalToConstant: 305).isActive = true
        
        moreDetailButton.topAnchor.constraint(equalTo: exteriorDecorationView.bottomAnchor, constant: 10).isActive = true
        moreDetailButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        moreDetailButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        moreDetailButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func openUrl() {
        let svc = SFSafariViewController(url: URL(string: url ?? "https://elpal.ru")!)
        present(svc, animated: true, completion: nil)
    }
    
    @objc func getСonsultation() {
        
    }
    
    private func getFullInfoAboutObject() {
        
        let getInfo = ApiRequest(endPoint: "api/getFullInfoAboutObject/?object_id=\(self.objectId)")
        
        getInfo.getFullInfoAboutObject { result in
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    self.objectNameLabel.text = info.mainInfo!.name
                    self.infoAboutObjectView.paramers = Parametrs(size: info.mainInfo!.size, square: info.mainInfo!.square, numberOfRooms: info.mainInfo!.numberOfRooms, numberOfFloors: info.mainInfo!.numberOfFloors)
                    self.priceSliderView.prices = [info.prices!.fullFirstPrice, info.prices!.fullSecondPrice, info.prices!.fullThridPrice]
                    self.priceSliderView.credits = [info.prices!.creditFirstPrice, info.prices!.creditSecondPrice, info.prices!.creditThridPrice]
                    self.url = info.mainInfo?.linkOnSite
                }
                let serialQueue = DispatchQueue(label: "queuename")
                serialQueue.sync {
                    for (_, link) in info.linksOnImages!.enumerated() {
                        
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
                                    
                                    self.imageScrollIndicator.numberOfPages = info.linksOnImages!.count
                                    
                                    
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
    }

    
    func cropImage(image: UIImage) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.width*0.6875) //    1536 x 2048 pixels

        let cgImage = image.cgImage!

        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
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
