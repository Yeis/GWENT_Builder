//
//  CardSelectorCell.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/8/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//
import UIKit
import gwentBusiness
import RxSwift
class CardSelectorCell: UITableViewCell {

    
    static let Identifier = "CardSelectorCell"
    var Quantity = Variable(0)
    var Card:Card!
    let disposeBag =  DisposeBag()
//    private func setupCartObserver()
//    {
//        //1
//        ShoppingCart.sharedCart.chocolates.asObservable()
//            .subscribe(onNext:
//                {
//                    chocolates in
//                    self.cartButton.title = "\(chocolates.count) \u{1f36b}"
//            }).addDisposableTo(disposeBag)
//    }
    @IBOutlet var imagen: UIImageView!
  
    @IBOutlet var lbCardName: UILabel!
    
    @IBOutlet var lbQuantity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        QuantitySetup()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureWithCard(card: Card)
    {
        lbCardName.text = card.name
        imagen.image = UIImage(contentsOfFile:  SessionController.sharedInstance.GetImagePath(name: card.cover))
        self.Card = card
        //we check if the card has a Quantity alredy 
        if(card.quantity! > 0 )
        {
            self.Quantity.value = card.quantity!
        }
    }
    
    //RX Functions
    private func QuantitySetup()
    {
        Quantity.asObservable().subscribe(onNext:{
            number in
            self.lbQuantity.text = "\(number)"
        }).addDisposableTo(disposeBag)
    }
    //Actions
    @IBAction func addOnePress(_ sender: AnyObject)
    {
        Quantity.value = Quantity.value + 1
        
        //Add card to deck 
        if ( SessionController.sharedInstance.currentDeck.Cards.count > 0 &&   SessionController.sharedInstance.currentDeck.Cards.contains{ $0.name == self.Card.name  })
        {
            //it exists 
            _ = SessionController.sharedInstance.currentDeck.Cards.map{
                if($0.name == self.Card.name){
                    $0.quantity = $0.quantity! + 1
                }
            }
        }
        else
        {
            let cardToBeAdded = self.Card
            cardToBeAdded?.quantity = self.Quantity.value
            SessionController.sharedInstance.currentDeck.Cards.append(cardToBeAdded!)
        }
        
    }
    
    @IBAction func removeOnePress(_ sender: AnyObject) {
        Quantity.value =  Quantity.value - 1

    }
    
    
    
}
