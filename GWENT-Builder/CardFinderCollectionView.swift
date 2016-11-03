//
//  CardFinderCollectionView.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/2/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import gwentBusiness

extension CardFinderController:UICollectionViewDataSource , UICollectionViewDelegate
{
    
    //MARK: Metodos de UICollectionView
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive || filterActive) {
            return FilteredCards.count
        }
        return Cards.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //    alert.dismiss(animated: true, completion: nil)
        
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        cell.frame.size.width = (collectionView.frame.size.width  ) / 2
        cell.frame.size.height = (collectionView.frame.size.height - 2) / 2
        //Dynamic size of image and label
        cell.image.frame.size.width = (cell.frame.size.width * 2.2) / 3
        cell.image.frame.size.height = (cell.frame.size.height * 2.2) / 3
        //(cell.frame.size.height - (cell.frame.size.height / 3))
        cell.lbName.frame = CGRect(x: 0, y: cell.frame.size.height - (cell.frame.size.height / 5) , width: cell.frame.size.width, height: (cell.frame.size.height / 5))
        cell.lbName.numberOfLines = 2
        
        
        //Cell data
        if (searchActive || filterActive)
        {
            cell.lbName.text = (FilteredCards[indexPath.item].name)
            cell.image.image = UIImage(contentsOfFile:  SessionController.sharedInstance.GetImagePath(name: FilteredCards[indexPath.item].cover)  )
        }
        else
        {
            cell.lbName.text = (Cards[indexPath.item].name)
            cell.image.image = UIImage(contentsOfFile:  SessionController.sharedInstance.GetImagePath(name: Cards[indexPath.item].cover)  )
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        Selected = indexPath.item
        
        // performSegue(withIdentifier: "OldCardViewer", sender: nil)
        performSegue(withIdentifier: "NewCardViewer", sender: nil)
        
        
    }
    func collectionCellPress(sender:UIButton)
    {
        Selected = sender.tag
        performSegue(withIdentifier: "NewCardViewer", sender: nil)
    }
    

    
}
