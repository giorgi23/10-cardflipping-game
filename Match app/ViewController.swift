//
//  ViewController.swift
//  Match app
//
//  Created by Giorgi Jashiashvili on 4/5/20.
//  Copyright © 2020 Giorgi Jashiashvili. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex:IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        cardArray = model.getCards()
        collectionView.delegate = self
        collectionView.dataSource = self
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
            
        } else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        firstFlippedCardIndex = nil
        
    }


}

