//
//  types.swift
//  gwentBusiness
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation


public enum  type
{
    case Character
    case Disloyal
    case Hero
    case Leader
    case Loyal
    case Special
    case Troop
    
    public var description : String {
        switch self {
        // Use Internationalization, as appropriate.
        case .Character: return "Character"
        case .Disloyal: return "Disloyal"
        case .Hero  : return "Hero"
        case .Leader: return "Leader"
        case .Loyal: return "Loyal"
        case .Special: return "Special"
        case .Troop: return "Troop"
   
        }
    }
    public static let allValues = [Character, Disloyal, Hero,Leader,Loyal,Special,Troop]
    public static var count: Int { return type.Troop.hashValue }
}
