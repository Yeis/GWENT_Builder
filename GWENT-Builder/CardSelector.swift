  //
//  CardSelector.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/1/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import gwentBusiness
class CardSelector: UIViewController {
    //properties
    @IBOutlet var tableView: UITableView!
    var searchBarNav:UISearchBar!
    var Cards = Variable<[Card]>([])
    var Deck:[Card] = [Card]()
    let disposeBag =  DisposeBag()
    var Selected:Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SearchBarSetup()
        tableViewSetup()
        Cards.value = SessionController.sharedInstance.GetSharedCards()
        setupCellConfiguration()
        
    
    }
    override func viewWillAppear(_ animated: Bool) {
        //mandar mensaje para ver el status
        tableView.reloadData()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Setup Functions
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
        tableView.register(nib, forCellReuseIdentifier: "CardSelectorCell")
    }
    
    
    //MARK: RX Functions
    
    private func setupCellConfiguration()
    {
        Cards.asObservable().bindTo(tableView
        .rx
            .items(cellIdentifier:  CardSelectorCell.Identifier , cellType: CardSelectorCell.self))
            { row , card , cell in
                cell.configureWithCard(card: card)
                
        }.addDisposableTo(disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { indexPath in
                self.Selected = indexPath.row
                self.performSegue(withIdentifier: "NewCardViewer", sender: nil)
            }).addDisposableTo(disposeBag)
        
        
        
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "NewCardViewer"){
            let svc = segue.destination as! NewCardViewer
            svc.deckMode = true
            svc.card = Cards.value[Selected]
        }
    }
    

}
extension CardSelector: UISearchBarDelegate
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
