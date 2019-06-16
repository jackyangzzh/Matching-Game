//
//  ViewController.swift
//  Matching Game
//
//  Created by Zongzhen Yang on 1/21/19.
//  Copyright © 2019 JackYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var model = CardModel()
    var cardArray = [Card]()
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var firstFlippedCard:IndexPath?
    var sound = SoundManager()
    
    var timer:Timer?
    var milliseconds:Float = 20000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        cardArray = model.getCards()
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
         sound.playSound(effect: .shuffle)
    }
    
    @objc func timerElapsed() {
        milliseconds -= 1
        let seconds = String(format: "%.2f", milliseconds/1000)
        timerLabel.text = "Time Remaining: \(seconds)"
        timerLabel.textColor = UIColor.black
        
        if(milliseconds <= 0){
            timer?.invalidate()
            timerLabel.textColor = UIColor.red
            checkGameEnded()
        }
    }
    
    //MARK: - UICollectionViw Protocol Methods
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Get cardCollectionViewCell object
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row];
        
        cell.setCard(card)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(milliseconds <= 0){
            return
        }
        
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if(!card.isFlipped && !card.isMatched){
            cell.flip()
            sound.playSound(effect: .flip)
            card.isFlipped = true;
            
            if(firstFlippedCard == nil){
                firstFlippedCard = indexPath
            }else{
                checkForMatches(indexPath)
            }
            
        }
        
    }
    
    func checkForMatches(_ secondIndex: IndexPath){
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCard!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstFlippedCard!.row]
        let cardTwo = cardArray[secondIndex.row]
        
        //Compare two cards
        if(cardOne.imageName == cardTwo.imageName) {
            cardOne.isMatched = true;
            cardTwo.isMatched = true;
            sound.playSound(effect: .match)
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            checkGameEnded()
        }else{
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            sound.playSound(effect: .noMatch)
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        firstFlippedCard = nil
        
    }
    
    var titleName = ""
    var message = ""
    
    func checkGameEnded() {
        var isWon = true
        for card in cardArray {
            if(!card.isMatched) {
                isWon = false
                break
            }
        }
        if(isWon) {
            if(milliseconds > 0){
                timer?.invalidate()
            }
            titleName  = "Congrats!"
            message = "You Win ^_^"
        }else{
            if(milliseconds > 0) {
                return
            }
            titleName = "Darn"
            message = "You Lost =( "
        }
        showAlert(titleName, message)
    }
    
    func showAlert(_ title:String,  _ message:String){
        let alert = UIAlertController(title: titleName, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Continue", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}

