//
//  CardCollectionViewCell.swift
//  MatchGame7
//
//  Created by Łukasz Rajczewski on 02/03/2021.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontCardImage: UIImageView!
    @IBOutlet weak var backCardImage: UIImageView!
    
    var card: Card?
    
    func configureCell(_ card: Card) {
        
        self.card = card
    
        frontCardImage.image = UIImage(named: card.imageName)
        
        if card.isMatched == true {
            frontCardImage.alpha = 0
            backCardImage.alpha = 0
            return 
        } else {
            frontCardImage.alpha = 1
            backCardImage.alpha = 1
        }
        
        if card.isFlipped == true {
            flipUp(speed: 0)
        } else {
            flipDown(speed: 0, delay: 0)
        }
        
  
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        
        UIView.transition(from: backCardImage, to: frontCardImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = true
        
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.6) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            UIView.transition(from: self.frontCardImage, to: self.backCardImage, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        }
        
        card?.isFlipped = false 
        
    }
    
    func remove() {
        
        backCardImage.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseInOut) {
            
            self.frontCardImage.alpha = 0
            
        }
    }
    
    
}
