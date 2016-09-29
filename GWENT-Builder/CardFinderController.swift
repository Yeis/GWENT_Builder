//
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
public class CardFinderController:UIViewController , UICollectionViewDelegate , UISearchBarDelegate , UICollectionViewDataSource
{
    //Variables 
    var Cards:[Card] = [Card]()
    var FilteredCards:[Card] = [Card]()
    var Objects:[NSManagedObject]!
    var Selected:Int!
    var searchActive:Bool = false
    var artworkWrapper:String = ""
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!

    
     override public func viewDidLoad() {
        super.viewDidLoad()
        //setup of Delegates 
        collectionView!.dataSource = self
        collectionView!.delegate = self
        searchBar.delegate = self
        let nib = UINib(nibName: "CardViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
        
       
        
        //load de los objetos en la base de datos
        let data = GWENT_Data()
        Objects = data.loadCards()
        for item in Objects
        {
            let artworkSet = item.mutableSetValue(forKey: "artworks")
        
            artworkSet.forEach(procesarArtwork)
            
            
            Cards.append(Card(_name: (item.value(forKey: "name") as? String)! , _cover: artworkWrapper))
            artworkWrapper = ""
        }
       
      
        collectionView.reloadData()
     
    }
    func procesarArtwork(art:Any)
    {
        let _art =  art as! NSManagedObject
        if artworkWrapper == ""
        {
          artworkWrapper  =  _art.value(forKey: "imagePath") as! String!
        }
    }
    public override func viewDidAppear(_ animated: Bool) {
        //Layout de la Coleccion
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:   (collectionView.frame.size.width - 2 ) / 2, height: (collectionView.frame.size.height  - 2) / 2 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        collectionView.collectionViewLayout = layout
        
        //Debug
//        debugPrint(collectionView.frame.size.width)
//        debugPrint((collectionView.frame.size.height ) / 1.5 )

        


        

    }
    
     public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Metodos de UICollectionView
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(searchActive) {
            return FilteredCards.count
        }
        return Cards.count
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
        
        
        //Debug
//        cell.lbName.backgroundColor = UIColor.red
//        cell.backgroundColor = UIColor.green
//        debugPrint(SessionController.sharedInstance.GetImagePath(name: FilteredCards[indexPath.item].cover))
//
        
        

        
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        Selected = indexPath.item

        performSegue(withIdentifier: "CardViewer", sender: nil)

    }
   
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "CardViewer")
        {
            let svc = segue.destination as! CardViewer
            svc.card = Cards[Selected]
        }
    }
    
    //MARK: Metodos del Collection Layout
    
    
    //MARK: Metodos de searchBar
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
    
    
    
}
