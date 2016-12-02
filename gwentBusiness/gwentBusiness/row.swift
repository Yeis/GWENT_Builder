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
    case Melee
    case Ranged
    case Siege
    case Event
    
    
    
    public var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Melee: return "Melee"
        case .Ranged: return "Ranged"
        case .Siege: return "Siege"
        case .Event: return "Event"
        }
    }
    
    public static let allValues = [Melee , Ranged  ,Siege ,  Event]
    public static var count: Int { return row.Event.hashValue + 1  }
}
