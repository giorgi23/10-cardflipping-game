//
//  ViewController.swift
//  Match app
//
//  Created by Giorgi Jashiashvili on 4/5/20.
//  Copyright © 2020 Giorgi Jashiashvili. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?
    
    var timer:Timer?
    var miliseconds:Float = 100000 // 100 seconds

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    //MARK: - Timer Methods
    
    @objc func timerElapsed() {
        
        miliseconds -= 1
        
        //convert to seconds
        let seconds = String(format: "%.2f", miliseconds/1000)
        
        timerLabel.text = "Time Remaining: \(seconds)"
        
        if miliseconds <= 0 {
            timer?.invalidate()
            
            timerLabel.textColor = UIColor.red
            
            checkGameEnded()
        }
        
    }
    
    //MARK: - Collection view methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Get a collectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! MyCollectionViewCell
        
        //Get the card that the collection view is trying to display
        let cardTodisplay = cardArray[indexPath.row]
        
        //Set it
        cell.setCard(cardTodisplay)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let selectedCell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        
        let selectedCard = cardArray[indexPath.row]
        
        if selectedCard.isFlipped == false && selectedCard.isMatched == false {
            
            //flip the cell
            selectedCell.flip()
            selectedCard.isFlipped = true
            
            //determining if it's the first card that the user flipped or the second
            if firstFlippedCardIndex == nil {
                
                //this is the first card flipped
                firstFlippedCardIndex = indexPath
                
            } else {
                
                //this is the second card being flipped
                checkForMatches(indexPath)
                
                // TODO: store the name of the selected card ifthe first flipped was false
            }
            
            
        }
        
        
        
    }
    
    // MARK: - Game logic Methods
    
    func checkForMatches (_ secondFlippedCardIndex:IndexPath) {
        
        
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? MyCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? MyCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
        
        
        if cardOne.imageName == cardTwo.imageName {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            checkGameEnded()
            
        } else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
            
            
        }
        
        firstFlippedCardIndex = nil
        
    }
    
    func checkGameEnded() {
        
        //find out if any cards are unmatched
        var isWon = true
        
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
            
        }
        
        //if not, user won, stop timer
        if isWon == true {
            
            timer?.invalidate()

            
            
            showAlert("Congrats", "You won")
            
            
        }
        else {
            
            // if yes, check if there is time left
            if miliseconds > 0 {
                return
                
            } else {
                
                showAlert("Lost", "Try again")
            }

       
        }
        
        
        
    }
    
    func showAlert(_ title:String, _ message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        self.present(alert, animated: true, completion: nil)
    }


}

