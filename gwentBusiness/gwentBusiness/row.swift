//
//  row.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 10/19/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation


public enum row
{
    case Attack
    case Ranged
    case Siege
    case Event
    
    
    
    public var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Attack: return "Attack"
        case .Ranged: return "Ranged"
        case .Siege: return "Siege"
        case .Event: return "Event"
            
        }
    }
    
    
    public static let allValues = [Attack , Ranged  ,Siege ,  Event]
    public static var count: Int { return row.Event.hashValue }
    
    
}
