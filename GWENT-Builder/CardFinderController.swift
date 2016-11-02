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
public class CardFinderController:UIViewController 
{
    //MARK: Properties and Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var navBar: UINavigationBar!
    var Cards:[Card] = [Card]()
    var FilteredCards:[Card] = [Card]()
    var Objects:[NSManagedObject]!
    var Selected:Int!
    //let alert = UIAlertController(title:  "", message: "Fetching Database" , preferredStyle: UIAlertControllerStyle.alert)
    var searchActive:Bool = false
    var viewleft:Bool = true
    var buttonItem:UIBarButtonItem!
    var Filters:[String]!
    var searchBarNav:UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var searchView: UIView!
    
    //MARK: UIViewController Functions
     override public func viewDidLoad() {
        super.viewDidLoad()
       
        CollectionViewSetup()
        TableViewSetup()
        SearchBarSetup()
        GesturesSetup()
        Filters = ["" , "" , ""]
        //load de los objetos en la base de datos
        let data = GWENT_Data()
        let helper = gwentHelper()
        Objects = data.loadCards()
        for item in Objects{
            Cards.append(helper.getlocalCard(item: item))
        }
        collectionView.reloadData()
    }
    public override func viewDidAppear(_ animated: Bool) {
        //Posisionate Filter Menu
        PosisionateFilterBar()
        CollectionLayoutSetup()
        
    }
    
    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "NewCardViewer"){
            let svc = segue.destination as! NewCardViewer
            if(searchActive){
                svc.card = FilteredCards[Selected]
            }
            else{
                svc.card = Cards[Selected]
            }
        }
    }
    
    
    //MARK: Setup Functions
    private func  TableViewSetup(){
        //TableView Setup
        tableView.delegate = self
        tableView.dataSource =  self
        tableView.allowsMultipleSelection = true 
        let tablenib = UINib(nibName: "SearchViewCell", bundle: nil)
        tableView.register(tablenib, forCellReuseIdentifier: "Cell")
    }
    private func SearchBarSetup(){
        //setup of searchView
        let image = UIImage(named: "mobile-nav-icon-small")
        buttonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(CardFinderController.ViewRight(time:)))
        searchBarNav = UISearchBar(frame: CGRect(x:0, y:0,width: 200, height: 20))
        searchBarNav.delegate = self
        searchBarNav.placeholder = "Search Card.."
        searchBarNav.barStyle = UIBarStyle.black
        let NavBarItem = UIBarButtonItem(customView:searchBarNav)
        self.navigationItem.rightBarButtonItem = NavBarItem
        self.navigationItem.leftBarButtonItem = buttonItem
    }
    private func PosisionateFilterBar(){
        if viewleft {
            ViewLeft(time: 0.0)
            viewleft = false
            searchView.isHidden = false
        }
    }
    private func GesturesSetup(){
        //add gesture to searchview
        let swipeleft = UISwipeGestureRecognizer(target: self, action: #selector(CardFinderController.SwipeLeft))
        swipeleft.direction = UISwipeGestureRecognizerDirection.left
        searchView.addGestureRecognizer(swipeleft)
        //  add gesture to keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CardFinderController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    func CollectionViewSetup(){
        //CollectionView Setup
        collectionView!.dataSource = self
        collectionView!.delegate = self
        let nib = UINib(nibName: "CardViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
        self.automaticallyAdjustsScrollViewInsets = false
    }
    private func  CollectionLayoutSetup(){
        //Collection Layout
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:   (collectionView.frame.size.width - 2 ) / 2, height: (collectionView.frame.size.height  - 2) / 2 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
     
}
