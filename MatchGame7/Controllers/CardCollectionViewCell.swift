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
        
        backCardImage.image = UIImage(named: "back")
        frontCardImage.image = UIImage(named: card.imageName)
  
    }
    
    func flipUp() {
        
        UIView.transition(from: backCardImage, to: frontCardImage, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = true
        
    }
    
    func flipDown() {
        
        UIView.transition(from: frontCardImage, to: backCardImage, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft], completion: nil)
        
        card?.isFlipped = false 
        
    }
    
    
}
