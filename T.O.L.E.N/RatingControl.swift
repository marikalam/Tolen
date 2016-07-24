//
//  RatingControl.swift
//  T.O.L.E.N
//
//  Created by Jianfu Zhang on 7/23/16.
//  Copyright © 2016 Jianfu Zhang. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    var rating = 0
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named:"filledStar")
        let emptyStarImage = UIImage(named:"emptyStar")
        
        
        for _ in 0..<5 {
            let button = UIButton()
            
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)), forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        
        let buttonSize = Int(frame.size.height)
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        
        //Offset each button's origin by the length of the button plus spacing.
        
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: width, height: buttonSize)
    }


    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }

}