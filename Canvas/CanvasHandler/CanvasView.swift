//
//  CanvasView.swift
//  Canvas
//
//  Created by Sachitha on 8/20/18.
//  Copyright © 2018 Sachitha. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    //layers
    
    
    //curent selected tool
    var tool:tools = .pen
    
    var groups:[Group] = []
    
    func resetAll(){
        groups = []
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }

    func addNewLayer(){
        let layer:UIImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: frame.size))
        // get next layer index and put in tag
        // tag == index
        var group:Group = Group()
        
        group.layers.append(layer)
        groups.append(group)
        self.addSubview(layer)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let currentPoint = touch.location(in: self)
        
        switch tool {
        case .pen:
            //top gropup in view
            var top_group:Group = groups.last!
            top_group.startPoint = currentPoint
            top_group.strokeSets.append([])
            groups[groups.count - 1] = top_group
            break
            
        case .hand:
            break
            
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        switch tool {

        case .pen:
            var top_group:Group = groups.last!
            let stroke = Stroke(startPoint: top_group.startPoint, endPoint: currentPoint, color: UIColor.blue.cgColor, strokeWidth: 5.0)
            top_group.strokeSets[top_group.strokeSets.count - 1].append(stroke)
            top_group.startPoint = currentPoint
            groups[groups.count - 1] = top_group
            break
            
        case .hand:
            break
            
        }
        DrawStroke()

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)

        switch tool {
            
        case .pen:
             var top_group:Group = groups.last!
            let stroke = Stroke(startPoint: top_group.startPoint, endPoint: currentPoint, color: UIColor.blue.cgColor, strokeWidth: 5.0)
            top_group.strokeSets.append([stroke])
            top_group.startPoint = nil
            break
        case .hand:
            
            break
        }
        
      
    }
    //drowing funtions
    func DrawStroke(){

        let renderer = UIGraphicsImageRenderer(size: self.frame.size)
        let rendererImage = renderer.image { context in

            context.cgContext.setFillColor(UIColor.red.cgColor)
            context.cgContext.setStrokeColor(UIColor.black.cgColor)
            context.cgContext.setLineWidth(10)
            context.cgContext.beginPath()
            for group in groups {
                for strokeSet in group.strokeSets {
                    for stroke in strokeSet{
                        context.cgContext.move(to: stroke.startPoint)
                        context.cgContext.addLine(to: stroke.endPoint)
                    }
                }
            }
            context.cgContext.setLineCap(.round)
            context.cgContext.strokePath()
//            let paragraphStyle = NSMutableParagraphStyle()
//            paragraphStyle.alignment = .center
//
//            let attrs = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Thin", size: 36)!, NSAttributedStringKey.paragraphStyle: paragraphStyle]
//
//            let string = "How much wood would a woodchuck\nchuck if a woodchuck would chuck wood?"
//            string.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, attributes: attrs, context: nil)
        }
        groups.last?.layers.last?.image = rendererImage
    }
    
    

}
