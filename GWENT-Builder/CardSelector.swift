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
class CardSelector: UIViewController {
    //properties
    @IBOutlet var tableView: UITableView!
    var searchBarNav:UISearchBar!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SearchBarSetup()
        
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
    
    
    //MARK: RX Functions
    func tableViewSetup()
    {
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
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
