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
public class CardFinderController:UIViewController , UICollectionViewDelegate , UICollectionViewDataSource 
{
    //Variables 
    var Cards:[Card] = [Card]()
    var Objects:[NSManagedObject]!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!

    
     override public func viewDidLoad() {
        super.viewDidLoad()
        let data = GWENT_Data()
        Objects = data.loadCards()
        for item in Objects
        {
            Cards.append(Card(_name: (item.value(forKey: "name") as? String)! , _artwork: item.value(forKey: "imagePath") as! String))
        }
        collectionView!.dataSource = self
        collectionView!.delegate = self
        let nib = UINib(nibName: "CardViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardCell")
      
       
     
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        //Layout de la Coleccion
        debugPrint(collectionView.frame.size.width)
        debugPrint((collectionView.frame.size.height ) / 1.5 )
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width:   (collectionView.frame.size.width - 2 ) / 2, height: (collectionView.frame.size.height  - 2) / 2 )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 5
        
          collectionView.collectionViewLayout = layout

    }
    
     public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: Metodos de UICollectionView
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Cards.count
    }

    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardViewCell
        cell.backgroundColor = UIColor.green
        //cell.image.image = UIImage(named: "alchemist")
         cell.frame.size.width = (collectionView.frame.size.width  ) / 2
         cell.frame.size.height = (collectionView.frame.size.height - 2) / 2
        
         cell.lbName?.text = (Cards[indexPath.item].name)
         cell.image?.image = UIImage(contentsOfFile:  Cards[indexPath.item].artwork)
        //debugPrint("cell#" + String(indexPath.item)  )
     //   debugPrint("width: " + String(describing: cell.frame.size.width) )
     //   debugPrint( "height: " + String(describing: cell.frame.size.height))
    
        return cell
    }
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")

    }
   
    
    //MARK: Metodos del Collection Layout
    
    
    
}
