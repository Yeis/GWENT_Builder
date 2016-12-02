//
//  DeckCardSelector.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/3/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class DeckCardSelector:UIViewController

{
   //Properties
    @IBOutlet var tableview: UITableView!
    var searchBarNav:UISearchBar!
    let disposeBag = DisposeBag()
    var Selected:Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        setupCellConfiguration()
        SearchBarSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        //mandar mensaje para ver el status
        tableview.reloadData()
    }
    //MARK: Setup FUnctions
    func SearchBarSetup(){
        //setup of searchView
        
        searchBarNav = UISearchBar(frame: CGRect(x:0, y:0,width: 200, height: 20))
        searchBarNav.delegate = self
        searchBarNav.placeholder = "Search Card.."
        searchBarNav.barStyle = UIBarStyle.black
        let NavBarItem = UIBarButtonItem(customView:searchBarNav)
        self.navigationItem.rightBarButtonItem = NavBarItem
    }
    func tableViewSetup()
    {
        let nib = UINib(nibName: "CardSelectorCell", bundle: nil)
        tableview.register(nib, forCellReuseIdentifier: "CardSelectorCell")
    }
    
    //MARK: RX Functions
    
    private func setupCellConfiguration()
    {
         SessionController.sharedInstance.deckCards.asObservable().bindTo(tableview
            .rx
            .items(cellIdentifier:  CardSelectorCell.Identifier , cellType: CardSelectorCell.self))
        { row , card , cell in
            cell.configureWithCard(card: card)
            }.addDisposableTo(disposeBag)
        
        tableview.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.Selected = indexPath.row
                self.performSegue(withIdentifier: "NewCardViewer", sender: nil)
            }).addDisposableTo(disposeBag)

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  
        if(segue.identifier == "NewCardViewer"){
            let svc = segue.destination as! NewCardViewer
            svc.deckMode = true
            svc.card = SessionController.sharedInstance.deckCards.value[Selected]
        }
    }
    
    
}
extension DeckCardSelector: UISearchBarDelegate
{
    func dismissKeyboard() {
        searchBarNav.resignFirstResponder()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}
