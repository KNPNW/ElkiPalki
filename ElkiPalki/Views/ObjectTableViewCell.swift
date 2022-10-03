import UIKit

class ObjectTableViewCell: UITableViewCell {
    static let identifier = "ObjectTableViewCell"
    
    private lazy var shadowView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.boldSystemFont(ofSize: 21)
        label.tintColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var objectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var infoAboutIbject: MainInfoAboutObject = {
        let view = MainInfoAboutObject()
        return view
    }()
    
    private lazy var loadingView: LoadingView = {
        let view = LoadingView()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(shadowView)
        shadowView.addSubview(cardView)
        
        cardView.addSubview(loadingView)
        cardView.addSubview(objectImageView)
        cardView.addSubview(nameLabel)
        
        cardView.addSubview(infoAboutIbject)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowRadius = 10
        
        shadowView.layer.shadowPath = UIBezierPath(roundedRect: shadowView.bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        
        let indentRL: CGFloat = 25
        let indentTB: CGFloat = 40
                
        shadowView.frame = CGRect(x: indentRL, y: indentTB, width: contentView.frame.size.width-(indentRL*2), height: contentView.frame.size.height-(indentTB*2))
        
        
//        shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25).isActive = true
//        shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25).isActive = true
//        shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40).isActive = true
//        shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        
        cardView.widthAnchor.constraint(equalTo: shadowView.widthAnchor).isActive = true
        cardView.heightAnchor.constraint(equalTo: shadowView.heightAnchor).isActive = true
        
        objectImageView.topAnchor.constraint(equalTo: cardView.topAnchor).isActive = true
        objectImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        objectImageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor).isActive = true
        objectImageView.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: 190).isActive = true
        
//        loadingView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor).isActive = true
//        loadingView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -50).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: objectImageView.bottomAnchor, constant: 15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        infoAboutIbject.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        infoAboutIbject.widthAnchor.constraint(equalTo: cardView.widthAnchor).isActive = true
        infoAboutIbject.heightAnchor.constraint(equalToConstant: 130).isActive = true
        
        loadingView.frame = CGRect(x: cardView.frame.width/2-40, y: 65, width: 80, height: 80)
        
        loadingView.draw()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        objectImageView.image = nil
    }
    
    public func configure(with model: ObjectOptions) {
        nameLabel.text = model.object.name
        
        infoAboutIbject.paramers = Parametrs(size: model.object.size, square: String(model.object.square), numberOfRooms: String(model.object.numberOfRooms), numberOfFloors: model.object.numberOfFloors)
        
        let getImage = ApiRequest(endPoint: model.object.linkOnMainImage)
        getImage.getImage { result in
            switch result {
            case .success(let image) :
                DispatchQueue.main.async {
                    let finalImage: UIImage = self.cropImage(image: UIImage(data: image)!)
                    self.objectImageView.image = finalImage
                    self.loadingView.removeFromSuperview()
                }
            case .failure(let ApiError):
                print(ApiError)
            }
        }
    }
    
    func cropImage(image: UIImage) -> UIImage {

        let rect = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.width*0.6875) //    1536 x 2048 pixels

        let cgImage = image.cgImage!

        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }

}

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
