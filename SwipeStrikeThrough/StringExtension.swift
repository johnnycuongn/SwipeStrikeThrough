//
//  StringExtension.swift
//  DCSwipeStrikeThrough
//
//  Created by Johnny on 20/11/20.
//

import Foundation
import UIKit

enum StrikeThroughState {
    case add
    case remove
}

extension String {
    
    /// Strike through a string
    /// - Returns: return  NSArrributedSting
    func strikeThrough(_ state: StrikeThroughState, translation: CGFloat? = nil ) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        
        // Translation / User Pan
        if let translation = translation,
               translation <= CGFloat(attributedString.length),
               translation > 0 {
            switch state {
            case .add:
                let addedRange = NSRange(location: 0, length: Int(translation))
                print(addedRange)
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: addedRange)
                
            case .remove:
                let removedRange = NSRange(location: Int(translation),
                                    length: attributedString.length-Int(translation))
                print(removedRange)
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: removedRange)
            }
        }
        else {
            print("No Trans")
            // When there is no translation
            switch state {
            case .add:
            
                attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
            case .remove:
                attributedString.removeAttribute(NSAttributedString.Key.strikethroughStyle, range: NSMakeRange(0, attributedString.length))
            }
        }
        
        return attributedString
    }
}
