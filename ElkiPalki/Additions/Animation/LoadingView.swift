//
//  LoadingView.swift
//  ElkiPalki
//
//  Created by Кирилл Падалица on 26.09.2022.
//

import UIKit

class LoadingView: UIView {
    
    private var backgroundLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    
    var size: CGFloat
        
    init(frame: CGRect = .zero, size: CGFloat = 80) {
        self.size = size
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect = .zero) {
        
        let lineWidth = 0.1 * size
        
        let radius = size * 0.4
        
        let center = CGPoint(x: layer.frame.width/2, y: layer.frame.height/2)
        
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 3*CGFloat.pi/4, clockwise: true)
        
        foregroundLayer = CAShapeLayer()
        
        foregroundLayer.path = circularPath.cgPath
        foregroundLayer.strokeColor = UIColor(named: "ElGreen")?.cgColor
        foregroundLayer.fillColor = UIColor.clear.cgColor
        foregroundLayer.lineWidth = lineWidth
        foregroundLayer.lineCap = .round
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [
            UIColor(named: "mainBackGroungColor")!.cgColor,
            UIColor(named: "mainBackGroungColor")!.cgColor,
            UIColor(named: "ElGreen")!.cgColor
        ]
        
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.mask = foregroundLayer
        
        layer.addSublayer(gradient)
        
        rotateAnimation(line: layer)
    }
    
    func rotateAnimation(line:CALayer, duration: CFTimeInterval = 1.0) {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0.0
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
            rotateAnimation.duration = duration
            rotateAnimation.repeatCount = .greatestFiniteMagnitude

            line.add(rotateAnimation, forKey: nil)
        }

}
