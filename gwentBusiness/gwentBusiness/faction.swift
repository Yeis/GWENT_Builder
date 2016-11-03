//
//  faction.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation


public enum faction
{
    case Monsters
    case Neutral
    case Northern_Realms
    case Scoia_Tael
    case Skellige
    
    
    public var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Monsters: return "Monsters"
        case .Neutral: return "Neutral"
        case .Northern_Realms: return "Northern_Realms"
        case .Scoia_Tael: return "Scoia_Tael"
        case .Skellige: return "Skellige"
            
        }
    }
    
    public static let allValues = [Monsters,Neutral,Northern_Realms , Scoia_Tael ,Skellige]
    public static var count: Int { return faction.Skellige.hashValue + 1  }

}
