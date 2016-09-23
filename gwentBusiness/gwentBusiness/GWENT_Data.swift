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
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "User",
                                                 in:managedContext)
        
        let _user = NSManagedObject(entity: entity!,
                                    insertInto: managedContext)
        
        //3
        _user.setValue(user.name , forKey: "name")
        
        do {
            //5
            if  users.count == 0{
                users.append(_user)
                
            }
            else
            {
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
        //if nothing return empty list
        return [NSManagedObject]()
    }
    
    //MARK: Cards
    public func saveCard(card:Card)
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let managedContext = appDelegate.managedObjectContext
        var Cards:[NSManagedObject] = loadCards()
        //2
        let entity =  NSEntityDescription.entity(forEntityName: "Card",
                                                 in:managedContext)
        
        let _card = NSManagedObject(entity: entity!,
                                    insertInto: managedContext)
        
        //3
        _card.setValue(card.name , forKey: "name")
        _card.setValue(card.artwork, forKey: "imagePath")
        do {
            //5
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
        //if nothing return empty list
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
    
    
}
