import UIKit

struct Parametrs {
    var size = ""
    var square = ""
    var numberOfRooms = ""
    var numberOfFloors = ""
}

class InfoAboutObjectView: UIView {
    
    private let generalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - LeftStack
    private let leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var sizeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rooms")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let numberOfFloorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var numberOfFloorsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stairs")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - RightStack
    private let rightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    
    private let squareLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "square")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Medium", size: 13)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var numberOfRoomsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "beds")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var allLabel = [self.sizeLabel, self.numberOfFloorsLabel, self.squareLabel, self.numberOfRoomsLabel]
    lazy var allImage = [self.sizeImageView, self.numberOfFloorsImageView, self.squareImageView, self.numberOfRoomsImageView]
    
    var paramers = Parametrs() {
        didSet {
            changeText()
        }
    }
    
    var addShadow: Bool
    
    init(frame: CGRect = .zero, addShadow: Bool = false) {
        self.addShadow = addShadow
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "White")
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    override func layoutSubviews() {
        if addShadow {
            self.dropShadow()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        for i in 0...1 {
            allImage[i].translatesAutoresizingMaskIntoConstraints = false
            allImage[i].heightAnchor.constraint(equalToConstant: 35).isActive = true
            allImage[i].widthAnchor.constraint(equalToConstant: 35).isActive = true
            allLabel[i].translatesAutoresizingMaskIntoConstraints = false
            allLabel[i].widthAnchor.constraint(equalToConstant: 90).isActive = true
            let stack: UIStackView = {
                let stack = UIStackView(arrangedSubviews: [allImage[i], allLabel[i]])
                stack.axis = .horizontal
                stack.alignment = .center
                stack.spacing = 5
                return stack
            }()
            leftStack.addArrangedSubview(stack)
        }
        
        for i in 2...3 {
            allImage[i].translatesAutoresizingMaskIntoConstraints = false
            allImage[i].heightAnchor.constraint(equalToConstant: 35).isActive = true
            allImage[i].widthAnchor.constraint(equalToConstant: 35).isActive = true
            allLabel[i].translatesAutoresizingMaskIntoConstraints = false
            allLabel[i].widthAnchor.constraint(equalToConstant: 90).isActive = true
            let stack: UIStackView = {
                let stack = UIStackView(arrangedSubviews: [allImage[i], allLabel[i]])
                stack.axis = .horizontal
                stack.alignment = .center
                stack.spacing = 5
                return stack
            }()
            rightStack.addArrangedSubview(stack)
        }
        
        generalStack.addArrangedSubview(leftStack)
        generalStack.addArrangedSubview(rightStack)
        
        addSubview(generalStack)
        
        
        generalStack.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        generalStack.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    
    private func changeText() {
        self.sizeLabel.text = NSLocalizedString("Size", comment: "") + "\n\(self.paramers.size) " + NSLocalizedString("meters", comment: "")
        self.squareLabel.text = NSLocalizedString("Square", comment: "") + "\n\(self.paramers.square) " + NSLocalizedString("m2", comment: "")
        self.numberOfRoomsLabel.text =  NSLocalizedString("Rooms", comment: "") + "\n\(self.paramers.numberOfRooms) " + NSLocalizedString("pc.", comment: "")
        self.numberOfFloorsLabel.text = NSLocalizedString("Floors", comment: "") + "\n\(self.paramers.numberOfFloors)"
    }

}

