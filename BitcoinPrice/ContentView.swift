//
//  ContentView.swift
//  BitcoinPrice
//
//  Created by Hossam on 16/05/2021.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
       
        GeometryReader<ChartPathView>(content: { geometry in
            ChartPathView(frame: geometry.frame(in:.global))
        })
       
            
    }
}

struct LinesView: Shape {
    let points : [CGFloat] =  [0.8 , 0.2 , 0.9 , 0.2 , 0.5 ,0.1 , 0.5 ]
    let bezierConfiguration = BezierConfiguration()
       
    func path(in rect: CGRect) -> Path {
        let offsetPerItem =  rect.width / CGFloat( points.count)
        var data : [CGPoint] = []
        for point in points.enumerated() {
            let xPosition = CGFloat(point.offset) * offsetPerItem
            let yPosition = (( rect.height * 0.5 ) * point.element) + 20
            data.append(.init(x: xPosition, y: yPosition))
        }
        
       var bezierConfigredPoints =   bezierConfiguration.configureControlPoints(data: data)
        var _ = bezierConfigredPoints.removeFirst()
        var path = Path()
        path.move(to: data.first! )
        bezierConfigredPoints.enumerated().forEach({
            path.addCurve(to: data[$0.offset + 2], control1: .init(x: $0.element.firstControlPoint.x, y: $0.element.firstControlPoint.y), control2: .init(x: $0.element.secondControlPoint.x, y: $0.element.secondControlPoint.y))
        })
    
        return path.strokedPath(.init(lineWidth: 5, lineCap: .round, lineJoin: .round, miterLimit: 10, dash: [1], dashPhase: 5))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
