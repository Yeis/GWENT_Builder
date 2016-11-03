//
//  GWENT_Data.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/23/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import gwentBusiness
public class GWENT_Data
{
    //MARK: Core Data Functions
    //MARK: Users
    public func saveUser(user:User)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        var users:[NSManagedObject] = loadUser()
        let entity =  NSEntityDescription.entity(forEntityName: "User", in:managedContext)
        
        let _user = NSManagedObject(entity: entity!, insertInto: managedContext)
        _user.setValue(user.name , forKey: "name")
        
        do {
            if  users.count == 0{
                users.append(_user)
            }
            else {
                users.append(_user)
                
            }
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        catch{}
        
    }
    public func loadUser()->[NSManagedObject]
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "User")
        do {
            let results =
                try managedContext.fetch(request)
            return  results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }catch{}
        // if nothing return empty list
        return [NSManagedObject]()
    }
    
    // MARK: Cards
    public func saveCard(card:Card)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        var Cards:[NSManagedObject] = loadCards()
        let entity =  NSEntityDescription.entity(forEntityName: "Card",
                                                 in:managedContext)
        
        let _card = NSManagedObject(entity: entity!,
                                    insertInto: managedContext)
        
        // guardamos la imagen
        if card.artwork.count != 0
        {
            let artworkEntity = NSEntityDescription.entity(forEntityName: "Artwork", in: managedContext)
            let _artwork = NSManagedObject(entity: artworkEntity!, insertInto: managedContext)
            _artwork.setValue(card.artwork[0], forKey: "imagePath")
            _card.setValue(NSSet(object: _artwork), forKey: "artworks")
            
            if card.artwork.count > 1
            {
                let artworks = _card.mutableSetValue(forKey: "artworks")
                for i in 1...(card.artwork.count - 1)
                {
                    let _artwork = NSManagedObject(entity: artworkEntity!, insertInto: managedContext)
                    _artwork.setValue(card.artwork[i], forKey: "imagePath")
                    artworks.add(_artwork)
                }
            }
        }
        // guardamos el row
        if card.rows.count != 0
        {
            let rowsEntity = NSEntityDescription.entity(forEntityName: "Row", in: managedContext)
            let _row = NSManagedObject(entity: rowsEntity!, insertInto: managedContext)
            _row.setValue(card.rows[0], forKey: "name")
            _card.setValue(NSSet(object: _row), forKey: "rows")
            
            if card.rows.count  > 1
            {
                let rows = _card.mutableSetValue(forKey: "rows")
                for i in 1...(card.rows.count - 1)
                {
                    let _row = NSManagedObject(entity: rowsEntity!, insertInto: managedContext)
                    _row.setValue(card.rows[i], forKey: "name")
                    rows.add(_row)
                }
            }
        }
        // guardamos los subtypes
        if card.subtypes.count != 0
        {
            let subtypesEntity = NSEntityDescription.entity(forEntityName: "Subtype", in: managedContext)
            let _subtype = NSManagedObject(entity: subtypesEntity!, insertInto: managedContext)
            _subtype.setValue(card.subtypes[0], forKey: "name")
            _card.setValue(NSSet(object: _subtype), forKey: "subtypes")
            
            if card.subtypes.count > 1
            {
                let subtypes = _card.mutableSetValue(forKey: "subtypes")
                for i in 1...(card.subtypes.count - 1)
                {
                    let _subtype = NSManagedObject(entity: subtypesEntity!, insertInto: managedContext)
                    _subtype.setValue(card.subtypes[i], forKey: "name")
                    subtypes.add(_subtype)
                }
            }
        }
        // add normal parameters
        _card.setValue(card.name , forKey: "name")
        _card.setValue(card.faction, forKey: "faction")
        _card.setValue(card.rarity, forKey: "rarity")
        _card.setValue(card.text, forKey: "text")
        _card.setValue(card.type, forKey: "type")
        
        do {
            Cards.append(_card)
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        catch{}
        
    }
    
    public func loadCards()->[NSManagedObject]
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Card")
        do {
            let results =
                try managedContext.fetch(request)
            return results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }catch{}
        // if nothing return empty list
        return [NSManagedObject]()
    }
    public func deleteCards()
    {
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Card")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try coord.execute(deleteRequest, with: context)
        } catch let error as NSError {
            debugPrint(error)
        }catch{}
    }
    
    func removeImage(itemName:String, fileExtension: String) {
        let fileManager = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        guard let dirPath = paths.first else {
            return
        }
        let filePath = "\(dirPath)/\(itemName).\(fileExtension)"
        do {
            try fileManager.removeItem(atPath: filePath)
        } catch let error as NSError {
            print(error.debugDescription)
        }}
    
}
