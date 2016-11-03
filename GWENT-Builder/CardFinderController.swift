///
//  CardFinderController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/21/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import gwentBusiness
public class CardFinderController:UIViewController , UICollectionViewDelegate , UISearchBarDelegate , UICollectionViewDataSource , UITableViewDataSource, UITableViewDelegate
{
    // Variables
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    var Cards:[Card] = [Card]()
    var FilteredCards:[Card] = [Card]()
    var Objects:[NSManagedObject]!
    var Selected:Int!
    // let alert = UIAlertController(title:  "", message: "Fetching Database" , preferredStyle: UIAlertControllerStyle.alert)
    var searchActive:Bool = false
    var buttonItem:UIBarButtonItem!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchView: UIView!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        // setup of Delegates
        collectionView!.dataSource = self
        collectionView!.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource =  self
        self.automaticallyAdjustsScrollViewInsets = false
        let nib = UINib(nibName: "CardViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
        let tablenib = UINib(nibName: "SearchViewCell", bundle: nil)
        tableView.register(tablenib, forCellReuseIdentifier: "Cell")
        self.title = "Card Finder"
        // setup of searchView
        var image = UIImage(named: "menuicon")
        image = imageController.imageResize(imageObj: image!)
        buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(CardFinderController.ViewRight(time:)))
        buttonItem.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = buttonItem
        // add gesture to searchview
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(CardFinderController.SwipeLeft))
        swipeleft.direction = UISwipeGestureRecognizerDirection.left
        searchView.addGestureRecognizer(swipeleft)
        // add gesture to keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CardFinderController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        // fill searching objects array
        
        // load de los objetos en la base de datos
        let data = GWENT_Data()
        let helper = gwentHelper()
        Objects = data.loadCards()
        for item in Objects{
            Cards.append(helper.getlocalCard(item: item))
        }
        collectionView.reloadData()
        
    }
    public override func viewDidAppear(_ animated: Bool) {
        // Layout de la Coleccion
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:   (collectionView.frame.size.width - 2 ) / 2, height: (collectionView.frame.size.height  - 2) / 2 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
        
        collectionView.reloadData()
        
        ViewLeft(time: 0.0)
        
        // Debug
        // debugPrint(collectionView.frame.size.width)
        // debugPrint((collectionView.frame.size.height ) / 1.5 )
        
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableView Methods
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("Section: " + String(indexPath.section) + " Row: " + String(indexPath.row))
        // var cell = tableView.cellForRow(at: indexPath) as! SearchViewCell
        // cell.backgroundColor = UIColor.white
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchViewCell
        // Types
        if(indexPath.section == 0){
            cell.lbOptionName.text = type.allValues[indexPath.row].description
        }
        // Faction
        else if (indexPath.section == 1)
        {
            cell.lbOptionName.text = faction.allValues[indexPath.row].description
        }
        // Row
        else if (indexPath.section == 2)
        {
            cell.lbOptionName.text = row.allValues[indexPath.row].description
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section)
        {
        case 0:
            return type.count
        case 1:
            return faction.count
        case 2:
            return row.count
        default:break
        }
        return 0
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch (section)
        {
        case 0:
            return "Type"
        case 1:
            return "Faction"
        case 2:
            return "Row"
        default: break
        }
        return ""
    }
    
    //    MARK: Metodos de UICollectionView
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive) {
            return FilteredCards.count
        }
        return Cards.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // alert.dismiss(animated: true, completion: nil)
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        cell.frame.size.width = (collectionView.frame.size.width  ) / 2
        cell.frame.size.height = (collectionView.frame.size.height - 2) / 2
        // Dynamic size of image and label
        cell.image.frame.size.width = (cell.frame.size.width * 2.2) / 3
        cell.image.frame.size.height = (cell.frame.size.height * 2.2) / 3
        // (cell.frame.size.height - (cell.frame.size.height / 3))
        cell.lbName.frame = CGRect(x: 0, y: cell.frame.size.height - (cell.frame.size.height / 5) , width: cell.frame.size.width, height: (cell.frame.size.height / 5))
        cell.lbName.numberOfLines = 2
        
        
        // Cell data
        if (searchActive)
        {
            cell.lbName.text = (FilteredCards[indexPath.item].name)
            cell.image.image = UIImage(contentsOfFile:  SessionController.sharedInstance.GetImagePath(name: FilteredCards[indexPath.item].cover)  )
        }
        else
        {
            cell.lbName.text = (Cards[indexPath.item].name)
            cell.image.image = UIImage(contentsOfFile:  SessionController.sharedInstance.GetImagePath(name: Cards[indexPath.item].cover)  )
        }
        
        // Debug
        // cell.lbName.backgroundColor = UIColor.red
        // cell.backgroundColor = UIColor.green
        // debugPrint(SessionController.sharedInstance.GetImagePath(name: FilteredCards[indexPath.item].cover))

        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        Selected = indexPath.item
        
        // performSegue(withIdentifier: "OldCardViewer", sender: nil)
        performSegue(withIdentifier: "NewCardViewer", sender: nil)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "NewCardViewer")
        {
            let svc = segue.destination as! NewCardViewer
            if(searchActive) {
                svc.card = FilteredCards[Selected]
            }
            else {
                svc.card = Cards[Selected]
            }
        }
    }
    
    // MARK: Metodos del Collection Layout

    // MARK: Metodos de searchBar
    
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
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
        view.endEditing(true)
    }
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        FilteredCards = Cards.filter({ $0.name.contains(searchBar.text!)
        })
        if(FilteredCards.count == 0){
            searchActive = false
        } else {
            searchActive = true;
        }
        self.collectionView.reloadData()
    }

    // MARK: Search View Controls

    func SwipeLeft(gesture: UISwipeGestureRecognizer)
    {
        // hacer que se vaya para abajo con el swipe
        // if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        let swipeGesture = gesture
        
        switch swipeGesture.direction {
        case UISwipeGestureRecognizerDirection.left:
            ViewLeft(time: 0.5)
        default:
            break
        }
    }
    
    func ViewLeft(time:TimeInterval = 0.8)
    {
        let screenSize: CGRect = UIScreen.main.bounds
        let viewWidth = screenSize.width * 0.5
        UIView.animate(withDuration: time, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
            self?.navigationItem.leftBarButtonItem?.isEnabled =  true
            
            // self?.navigationController?.view.bringSubview(toFront: (self?.navBar)!)
            
            self!.searchView.frame.origin.x -= viewWidth //self!.view.bounds.height
            // self!.tableview.alpha = 1.0
            self!.view.layoutIfNeeded()
            }, completion: nil)
        
    }
    func ViewRight(time:TimeInterval = 1.0)
    {
        let screenSize: CGRect = UIScreen.main.bounds
        let viewWidth = screenSize.width * 0.5
        UIView.animate(withDuration: time, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: { [weak self] in
            self?.navigationItem.leftBarButtonItem?.isEnabled =  false
            self!.searchView.frame.origin.x += viewWidth //self!.view.bounds.height
            // self!.tableview.alpha = 1.0
            self!.view.layoutIfNeeded()
            }, completion: nil)
    }
}
