import UIKit

struct Parametrs {
    var size = ""
    var square = ""
    var numberOfRooms = ""
    var numberOfFloors = ""
}

class MainInfoAboutObject: UIView {
    
    private let generalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let leftStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let rightStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private let sizeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var sizeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rooms")
        imageView.frame.size = CGSize(width: 10, height: 10)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let squareLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let numberOfRoomsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private let numberOfFloorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        label.tintColor = .black
        label.textAlignment = .left
        return label
    }()
    
    private lazy var squareImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "square")
        imageView.frame.size = CGSize(width: 35, height: 35)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var numberOfRoomsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "beds")
        imageView.frame.size = CGSize(width: 35, height: 35)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var numberOfFloorsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "stairs")
        imageView.frame.size = CGSize(width: 35, height: 35)
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
        self.backgroundColor = .white
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
        self.sizeLabel.text = "Размер\n\(self.paramers.size) метров"
        self.squareLabel.text = "Площадь\n\(self.paramers.square) м2"
        self.numberOfRoomsLabel.text = "Помещений\n\(self.paramers.numberOfRooms) шт."
        self.numberOfFloorsLabel.text = "Этажность\n\(self.paramers.numberOfFloors)"
    }

}

