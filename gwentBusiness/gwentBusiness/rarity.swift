//
//  rarity.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation

public enum rarity
{
    case Common
    case Rare
    case Epic
    case Legendary
    
    
    
    public var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Common: return "Monsters"
        case .Rare: return "Neutal"
        case .Epic: return "Northern_Realms"
        case .Legendary: return "Scoia_Tael"
            
        }
    }
    
    
    public static let allValues = [Common , Rare , Epic ,  Legendary]
    public static var count: Int { return rarity.Legendary.hashValue }

    
}
