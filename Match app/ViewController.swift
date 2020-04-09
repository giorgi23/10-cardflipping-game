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
        
        //Get the card that the collection view is trying to display and set it
        cell.setCard(cardArray[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            //flip the cell
            cell.flip()
            card.isFlipped = true
            
        } else {
           
            cell.flipBack()
            
            card.isFlipped = false
        }
        
        
        
    }


}

