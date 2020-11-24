//
//  Strikethrough.swift
//  DCSwipeStrikeThrough
//
//  Created by Johnny on 20/11/20.
//

import Foundation
import UIKit

public class StrikeThroughLabel: UILabel {
    
    var isStriked: Bool = false
    var labelWidth: CGFloat?
    var wordWidth: CGFloat?
    
    var translationStopPos: CGFloat {
        guard labelWidth != nil else { return 0 }
        return labelWidth!/2.8
    }
    
    var viewStopPos: CGFloat {
        guard superview != nil else { return 0 }
        return (superview?.frame.size.width)! / 1.5
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        addPanRightGestureRecognizer()
        

        let fontAttributes = [NSAttributedString.Key.font: self.font]
        let myText = self.text!
        let myWord = "a"
        labelWidth = (myText as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any]).width
        wordWidth = (myWord as NSString).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any]).width

    }

    
    private func addPanRightGestureRecognizer() {
        let panRight = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan(recognizer:)))
    
        
        self.addGestureRecognizer(panRight)
        self.isUserInteractionEnabled = true
    
    }
    
    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let xTranslation: CGFloat = recognizer.translation(in: superview).x
        var endPoint: CGPoint = CGPoint(x: 0, y: 0)
        
        // USER did swipe right
        guard xTranslation > 0, text?.count != nil else { return }
        
        switch recognizer.state {
        case .changed:
            if isStriked == false {
                self.attributedText = self.text!.strikeThrough(.add, translation: xTranslation/wordWidth!)
            }
            else {
                self.attributedText = self.text!.strikeThrough(.remove, translation: xTranslation/wordWidth!)
            }
        case .ended:
            endPoint = recognizer.location(in: superview)
            // IF there is no strikethrough
            // -> USER adding strikethrough
            if isStriked == false {
                if xTranslation > translationStopPos || endPoint.x > viewStopPos  {
                    self.attributedText = self.text?.strikeThrough(.add)
                    isStriked = true
                } else {
                    self.attributedText = self.text?.strikeThrough(.remove)
                    isStriked = false
                }
            }
            // IF there is strikethrough
            // -> USER removing strikethrough
            else {
                if xTranslation > translationStopPos || endPoint.x > viewStopPos {
                    self.attributedText = self.text?.strikeThrough(.remove)
                    isStriked = false
                } else {
                    self.attributedText = self.text?.strikeThrough(.add)
                    isStriked = true
                }
            }
            
        default:
            break
        }
    }
    
}
