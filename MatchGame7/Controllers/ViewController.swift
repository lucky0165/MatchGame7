//
//  ViewController.swift
//  MatchGame7
//
//  Created by Łukasz Rajczewski on 02/03/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    
    var cards = [Card]()
    
    var firstCardIndex: IndexPath?
    
    var soundManager = SoundManager()
    
    var timer: Timer?
    
    var miliseconds = 30 * 1000
    
    var state = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        soundManager.playSound(soundType: .shuffle)
        cards = model.getCards()
        
    }
    
    @IBAction func startPressed(_ sender: UIButton) {

        state = true
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    @objc func timerFired() {
        
        miliseconds -= 1
        
        let seconds: Double = Double(miliseconds) / 1000
        
        timeLabel.text = String(format: "Time remaining: %.2f", seconds)
        
        if miliseconds <= 0 {
            timer?.invalidate()
            
            checkForEnd()
        }
        
        
    }
    
    func checkForMatch(secondCardIndex: IndexPath) {
        
        let cardOne = cards[firstCardIndex!.row]
        let cardTwo = cards[secondCardIndex.row]
        
        let cellCardOne = collectionView.cellForItem(at: firstCardIndex!) as? CardCollectionViewCell
        let cellCardTwo = collectionView.cellForItem(at: secondCardIndex) as? CardCollectionViewCell
        
        if cardOne.imageName == cardTwo.imageName {
            
            soundManager.playSound(soundType: .correct)
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cellCardOne?.remove()
            cellCardTwo?.remove()
            
            
            checkForEnd()
            
        } else {
            
            soundManager.playSound(soundType: .wrong)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cellCardOne?.flipDown()
            cellCardTwo?.flipDown()
        }
        
        
        firstCardIndex = nil
    }
    
    func checkForEnd() {
        
        var hasWon = true
        
        for card in cards {
            
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon {
            
            // user win the game
            showAlert(title: "Congratulations!", msg: "You win the game!")
            
            timer?.invalidate()
            
            for _ in 1...4 {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.soundManager.playSound(soundType: .correct)
                }
            }
            
        } else {
            
            if miliseconds <= 0 {
                
                
                showAlert(title: "Unfortunately!", msg: "Better luck next time!")

                for _ in 1...4 {
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.soundManager.playSound(soundType: .wrong)
                    }
                }
    
            }
    
        }
}
    
    func showAlert(title: String, msg: String) {
        
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Try again!", style: .default) { (action) in
            
            self.state = false
            self.miliseconds = 30 * 1000
            self.cards = self.model.getCards()
            self.collectionView.reloadData()
            
        }
        
        alert.addAction(action)
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
}

// MARK: - CollectionView DataSource & Delegate Methods

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
        
        if miliseconds <= 0 || state == false {
            return
        }
        
        
        let tappedCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if tappedCell?.card?.isFlipped == false && tappedCell?.card?.isMatched == false {
            
            soundManager.playSound(soundType: .flip)
            
            tappedCell?.flipUp()
            
            if firstCardIndex == nil {
                
                firstCardIndex = indexPath
                
            } else {
                
                checkForMatch(secondCardIndex: indexPath)
                
            }
            
        }
        
    }
    
}
