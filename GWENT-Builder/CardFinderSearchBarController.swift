//
//  CardFinderSearchBarController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/2/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import gwentBusiness

extension CardFinderController:UISearchBarDelegate
{
    //MARK: Metodos de searchBar
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        searchBarNav.resignFirstResponder()
    }
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        ViewLeft(time: 0.8)
        searchActive = true;
    }
    
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if(searchBar.text?.characters.count == 0 ){
            searchActive = false;
        }
    }
    
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text?.characters.count == 0 ){
            searchActive = false;
        }
        dismissKeyboard()
        
        
        
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchActive = false
        armarQuery()
        if(searchText != ""){
        FilteredCards =  !filterActive ?  Cards.filter({ $0.name.contains(searchBar.text!)}) : FilteredCards.filter({ $0.name.contains(searchBar.text!)})
        }
        
        if(searchText.characters.count == 0){
            searchActive = false
        } else {
            searchActive = true;
        }
        self.collectionView.reloadData()
    }
    
    
    //MARK: Search View Controls
    
    
    func SwipeLeft(gesture: UISwipeGestureRecognizer)
    {
        //hacer que se vaya para abajo con el swipe
        //if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        let swipeGesture = gesture
        
        switch swipeGesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            ViewLeft(time: 0.5)
        default:
            break
        }
    }
    
    func ViewLeft(time:TimeInterval)
    {
        let screenSize: CGRect = UIScreen.main.bounds
        let viewWidth = screenSize.width * 0.5
        UIView.animate(withDuration: time, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
            self?.navigationItem.leftBarButtonItem?.isEnabled =  true
            self!.searchView.frame.origin.x -= viewWidth //self!.view.bounds.height
            //self!.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    func ViewRight(time:TimeInterval)
    {
         dismissKeyboard()
        let screenSize: CGRect = UIScreen.main.bounds
        let viewWidth = screenSize.width * 0.5
        UIView.animate(withDuration: time, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
            self?.navigationItem.leftBarButtonItem?.isEnabled =  false
            self!.searchView.frame.origin.x += viewWidth //self!.view.bounds.height
            // self!.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    
    

}
