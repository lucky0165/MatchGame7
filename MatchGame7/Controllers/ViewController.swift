//
//  ViewController.swift
//  MatchGame7
//
//  Created by Łukasz Rajczewski on 02/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    let model = CardModel()

    var cards = [Card]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cards = model.getCards()
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cards.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cards[indexPath.row]
        
        cell.configureCell(card)
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tappedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if tappedCell?.card?.isFlipped == false {
            tappedCell?.flipUp()
        } else {
            tappedCell?.flipDown()
        }
        
        
        
    }
    
    
    
    
    
    
}
