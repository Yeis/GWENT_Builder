//
//  CardFinderTableView.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 11/2/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import UIKit
import gwentBusiness
extension CardFinderController: UITableViewDataSource, UITableViewDelegate
{
    //MARK: UITableView Methods
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SearchViewCell
        //Set Dynamic Width
        if(cell.isSelected == true){
            cell.backgroundColor = UIColor.white
            cell.lbOptionName.textColor = UIColor.black
        }
        else if(cell.isSelected == false){
            cell.backgroundColor = UIColor.black
            cell.lbOptionName.textColor = UIColor.white
        }
        cell.frame.size.width = (tableView.frame.size.width)
      
        //Types
        if(indexPath.section == 0)
        {
            cell.lbOptionName.text = type.allValues[indexPath.row].description
            cell.img.image = UIImage(named: type.allValues[indexPath.row].description)
        }
            //Faction
        else if (indexPath.section == 1)
        {
            cell.lbOptionName.text = faction.allValues[indexPath.row].description
            cell.img.image = UIImage(named: faction.allValues[indexPath.row].description)
            
        }
            //Row
        else if (indexPath.section == 2)
        {
            cell.lbOptionName.text = row.allValues[indexPath.row].description
            cell.img.image = UIImage(named: row.allValues[indexPath.row].description)
            
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! SearchViewCell
        if(cell.backgroundColor == UIColor.black){
            switch indexPath.section {
            case 0:
                changeBackgroundColor(sectionLength: type.count,tableview: tableView , section: 0)
                filtrado(parametro: cell.lbOptionName.text! , tipo: "type")
                
            case 1 :
                changeBackgroundColor(sectionLength: faction.count,tableview: tableView , section: 1)
                filtrado(parametro: cell.lbOptionName.text! , tipo: "faction")
                
            case 2:
                changeBackgroundColor(sectionLength: row.count,tableview: tableView , section: 2)
                filtrado(parametro: cell.lbOptionName.text! , tipo: "row")
                
            default:
                break;
            }
            tableView.selectRow(at: indexPath, animated: true, scrollPosition:            UITableViewScrollPosition.none)
            cell.backgroundColor = UIColor.white
            cell.lbOptionName.textColor = UIColor.black
            filterActive =  true
        }
        else{
            tableView.deselectRow(at: indexPath, animated: true)
            cell.backgroundColor = UIColor.black
            cell.lbOptionName.textColor = UIColor.white
            Filters[indexPath.section] = ""
            armarQuery()
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SearchViewCell
        tableView.deselectRow(at: indexPath, animated: true)

        cell.backgroundColor = UIColor.black
        cell.lbOptionName.textColor = UIColor.white
        Filters[indexPath.section] = ""
        armarQuery()
    }
    
    func changeBackgroundColor(sectionLength:Int , tableview:UITableView , section:Int)
    {
        var cell:SearchViewCell!
        for i in 0...(sectionLength - 1)
        {
            cell = tableView.cellForRow(at: IndexPath(row: i, section: section)) as! SearchViewCell!
            tableView.deselectRow(at: IndexPath(row: i, section: section), animated: true)
            cell?.backgroundColor = UIColor.black
            cell?.lbOptionName.textColor = UIColor.white
            
        }
    }
    func filtrado(parametro:String , tipo:String)
    {
        filterActive = true 
        switch tipo {
        case "faction":
            Filters[0] = parametro
            break;
        case "row":
            Filters[1] = parametro
            break;
        case "type":
            Filters[2] = parametro
            break;
        default:break;
        }
        armarQuery()
        self.collectionView.reloadData()
    }
    func armarQuery()
    {
        //Empty Case 
        if(Filters[0] == "" && Filters[1] == "" && Filters[2] ==  ""){
            filterActive =  false 
        }
        //Simple Cases
        else if(Filters[0] != "" && Filters[1] == "" && Filters[2] ==  ""){
            FilteredCards = searchActive ? Cards.filter({ $0.faction == Filters[0]}) : FilteredCards.filter({ $0.faction == Filters[0]})
        }
        else if(Filters[0] == "" && Filters[1] != "" && Filters[2] ==  ""){
             FilteredCards = searchActive ? Cards.filter({ $0.rows.contains(Filters[1])}) : FilteredCards.filter({ $0.rows.contains(Filters[1])})
        }
        else if(Filters[0] == "" && Filters[1] == "" && Filters[2] !=  ""){
             FilteredCards = searchActive ? Cards.filter({ $0.type == Filters[2]}) : FilteredCards.filter({ $0.type == Filters[2]})        }
            //Advanced Cases
            //Filter by faction and row
        else if(Filters[0] != "" && Filters[1] != "" && Filters[2] ==  ""){
            FilteredCards = searchActive ? Cards.filter({ $0.faction == Filters[0] && $0.rows.contains(Filters[1])}) : FilteredCards.filter({ $0.faction == Filters[0] && $0.rows.contains(Filters[1])})
        }
            //Filter by faction and type
        else if(Filters[0] != "" && Filters[1] == "" && Filters[2] !=  ""){
                FilteredCards = searchActive ? Cards.filter({ $0.faction == Filters[0] &&  $0.type == Filters[2]}): FilteredCards.filter({ $0.faction == Filters[0] &&  $0.type == Filters[2]})
        }
            //Filter by row and type
        else if(Filters[0] == "" && Filters[1] != "" && Filters[2] !=  ""){
            FilteredCards = searchActive ? Cards.filter({ $0.rows.contains(Filters[1]) && $0.type == Filters[2]}) : FilteredCards.filter({ $0.rows.contains(Filters[1]) && $0.type == Filters[2]})
        }
            //Filter by all
        else if(Filters[0] != "" && Filters[1] != "" && Filters[2] !=  ""){
            FilteredCards = searchActive ? Cards.filter({ $0.faction == Filters[0] && $0.rows.contains(Filters[1]) && $0.type == Filters[2]}) : FilteredCards.filter({ $0.faction == Filters[0] && $0.rows.contains(Filters[1]) && $0.type == Filters[2]})        }
        }

}
