//
//  AboutViewController.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 30.04.2022.
//

import UIKit
import MapKit

class AboutViewController: UIViewController {
    
    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 250)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.frame.size = mainScrollView.contentSize
        return view
    }()
    
    private lazy var sloganLabel: UILabel = {
        let label = UILabel()
        label.text = "Строим как для себя,\nхотя в действительности - для вас!"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var teamImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "teamImage")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var metroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "metroImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var metroLabel: UILabel = {
        let label = UILabel()
        label.text = "Нарвская, Балтийская,\nМосковские ворота"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var workTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежедневно с 9:00 до 19:00"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var houseImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "houseImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Санкт-Петербург,\nул. Швецова, 41, корп. 15"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var businessCenter: UILabel = {
        let label = UILabel()
        label.text = "«БЦ Теньтельхофф»"
        label.numberOfLines = 1
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var point: MKPointAnnotation = {
        let point = MKPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(59.897458), longitude: (30.290951))
        point.title = "БЦ Теньтельхофф"
        return point
    }()
    
    private lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.addAnnotation(point)
        view.region = MKCoordinateRegion(center: point.coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "phoneImage")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var contactInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "+7 (812) 241-15-05\nБесплатная консультация"
        label.numberOfLines = 2
        label.font = UIFont(name: "Montserrat-Bold", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var getConsultationButton: UIButton = {
        let button = UIButton()
        button.setTitle("Получить консультацию", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 17)
        button.backgroundColor = UIColor(named: "ElGreen")
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "О Нас"

        view.backgroundColor = UIColor(named: "White")
        
        view.addSubview(mainScrollView)
        
        mainScrollView.addSubview(contentView)
        contentView.addSubview(sloganLabel)
        contentView.addSubview(teamImageView)
        contentView.addSubview(metroImageView)
        contentView.addSubview(metroLabel)
        contentView.addSubview(workTimeLabel)
        contentView.addSubview(houseImageView)
        contentView.addSubview(addressLabel)
        contentView.addSubview(businessCenter)
        contentView.addSubview(mapView)
        contentView.addSubview(phoneImageView)
        contentView.addSubview(contactInfoLabel)
        contentView.addSubview(getConsultationButton)
        
        mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        mainScrollView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        mainScrollView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        
        sloganLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        sloganLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        sloganLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        sloganLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        teamImageView.topAnchor.constraint(equalTo: sloganLabel.bottomAnchor, constant: 20).isActive = true
        teamImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        teamImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        teamImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        metroImageView.topAnchor.constraint(equalTo: teamImageView.bottomAnchor, constant: 20).isActive = true
        metroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        metroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        metroImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        metroLabel.topAnchor.constraint(equalTo: metroImageView.bottomAnchor, constant: 5).isActive = true
        metroLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        metroLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        metroLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        workTimeLabel.topAnchor.constraint(equalTo: metroLabel.bottomAnchor, constant: 15).isActive = true
        workTimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        workTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        workTimeLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        houseImageView.topAnchor.constraint(equalTo: workTimeLabel.bottomAnchor, constant: 20).isActive = true
        houseImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        houseImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        houseImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addressLabel.topAnchor.constraint(equalTo: houseImageView.bottomAnchor, constant: 5).isActive = true
        addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        addressLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        businessCenter.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 15).isActive = true
        businessCenter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        businessCenter.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        businessCenter.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        mapView.topAnchor.constraint(equalTo: businessCenter.bottomAnchor, constant: 15).isActive = true
        mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        mapView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        phoneImageView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 20).isActive = true
        phoneImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        phoneImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        phoneImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        contactInfoLabel.topAnchor.constraint(equalTo: phoneImageView.bottomAnchor, constant: 5).isActive = true
        contactInfoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        contactInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        contactInfoLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        getConsultationButton.topAnchor.constraint(equalTo: contactInfoLabel.bottomAnchor, constant: 10).isActive = true
        getConsultationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        getConsultationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        getConsultationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
}
