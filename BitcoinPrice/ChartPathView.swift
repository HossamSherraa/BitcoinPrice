//
//  ChartPathView.swift
//  BitcoinPrice
//
//  Created by Hossam on 16/05/2021.
//

import UIKit
import SwiftUI
import Combine
final class ChartPathView : UIView , UIViewRepresentable , CAAnimationDelegate{
    var points2 : [CGPoint] = []
    var currentIndex = 0
    var timer : Timer?
    var subscribtions : Set<AnyCancellable> = []
    func makeUIView(context: Context) -> ChartPathView {
        ChartPathView(frame: UIScreen.main.bounds)
    }
    
    func updateUIView(_ uiView: ChartPathView, context: Context) {
        
    }
    
    
    
    
    typealias UIViewType = ChartPathView
    
    let points : [CGFloat] =  [0.8 , 0.2 , 0.9 , 0.2 , 0.5 ,0.1 , 0.5 ]
    let bezierConfiguration = BezierConfiguration()
       
    func path(in rect: CGRect) -> UIBezierPath {
        let offsetPerItem =  rect.width / CGFloat( points.count)
        var data : [CGPoint] = []
        for point in points.enumerated() {
            let xPosition = CGFloat(point.offset) * offsetPerItem
            let yPosition = (( rect.height * 0.5 ) * point.element) + 20
            data.append(.init(x: xPosition, y: yPosition))
        }
        
       var bezierConfigredPoints =   bezierConfiguration.configureControlPoints(data: data)
        var _ = bezierConfigredPoints.removeFirst()
        let path = UIBezierPath()
        path.move(to: data.first! )
        bezierConfigredPoints.enumerated().forEach({
            path.addCurve(to: data[$0.offset + 2], controlPoint1: .init(x: $0.element.firstControlPoint.x, y: $0.element.firstControlPoint.y), controlPoint2: .init(x: $0.element.secondControlPoint.x, y: $0.element.secondControlPoint.y))
        })
    
        return path
    }
    
    let fingerLayer = UIView()
    let squareLayer = CALayer()
    let shapeLayer =  CAShapeLayer()
    func buildShapeLayer(rect : CGRect){
        shapeLayer.path = path(in: rect).cgPath
        shapeLayer.lineWidth = 4
        shapeLayer.strokeColor = UIColor.black.cgColor
       shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.frame = rect
        self.layer.addSublayer(shapeLayer)
        
        
        
     
//
//        let animation = CAKeyframeAnimation(keyPath: "position")
//
//        animation.path = shapeLayer.path
//        animation.delegate = self
//        animation.duration = 88.8
//        squareLayer.backgroundColor = UIColor.red.cgColor
//        squareLayer.frame.size = .init(width: 15, height: 15)
//        squareLayer.frame.origin = .zero
//        shapeLayer.addSublayer(squareLayer)
//        timer =  Timer.scheduledTimer(withTimeInterval: 0.0001, repeats: true) { _ in
//
//            if let position =  self.squareLayer.presentation()?.position {
//                if  !position.equalTo(.zero) {
//                    self.points2.append(position)
//
//                }
//
//            }
//
//
//        }
       
//        self.squareLayer.add(animation, forKey: nil)
      
        
        //FINGER
        
        fingerLayer.frame.size = .init(width: 10, height: 10)
        fingerLayer.layer.cornerRadius = 5
       
        fingerLayer.backgroundColor = .red
        
        
       addSubview(fingerLayer)
        
        
        
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(onPan)))
    }
    
    var subscriontions = Set<AnyCancellable>()
    override init(frame: CGRect) {
        super.init(frame: frame)
        buildShapeLayer(rect: frame)

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        timer?.invalidate()
        if flag {
            print("ENDED")
            print(points2.count)
//            points2.forEach({
//                let squaree = CALayer()
//                squaree.backgroundColor = UIColor.red.cgColor
//
//                squaree.frame = .init(origin: $0, size: .init(width: 4 , height: 4))
//                self.layer.addSublayer(squaree)
//
//
//
//            })
            
//            fingerLayer.backgroundColor =  UIColor.green
//            fingerLayer.frame.origin = points2.first!
//            fingerLayer.frame.size = .init(width: 40, height: 40)
        }
        
        
    }
    
    
    @objc
    func onPan(gesture : UIPanGestureRecognizer) {
        let fractionCompletion = (gesture.location(in: nil).x / self.frame.width)
        let halfPoint = UIBezierPath(cgPath: shapeLayer.path!).mx_point(atFractionOfLength: fractionCompletion)
        fingerLayer.center = halfPoint
        
       
       
       
    }
    
}

struct ContentVie2w_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

