//
//  CardCollectionViewCell.swift
//  Matching Game
//
//  Created by Zongzhen Yang on 1/21/19.
//  Copyright © 2019 JackYang. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card ) {
        //keep track of pass in card
        self.card = card;
        fontImageView.image = UIImage(named: card.imageName)
        
        if(card.isMatched){
            backImageView.alpha = 0
            fontImageView.alpha = 0
            return
        }else{
            backImageView.alpha = 1
            fontImageView.alpha = 1
        }
        
        if(card.isFlipped){
            UIView.transition(from: backImageView, to: fontImageView, duration: 0, options: [.transitionFlipFromBottom, .showHideTransitionViews], completion: nil)
        }else{
            UIView.transition(from: fontImageView, to: backImageView, duration: 0, options: [.transitionFlipFromTop, .showHideTransitionViews], completion: nil)
        }
    }
    
    func flip(){
        UIView.transition(from: backImageView, to: fontImageView, duration: 0.4, options: [.transitionFlipFromBottom, .showHideTransitionViews], completion: nil)
    }
    
    func flipBack(){
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.8) {
            UIView.transition(from: self.fontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromTop, .showHideTransitionViews], completion: nil)
        }
        
    }
    
    func remove(){
        
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.4, delay: 0.6, options: .curveEaseOut, animations: {
            self.fontImageView?.alpha = 0
        }, completion: nil)
    }
}
