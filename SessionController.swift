//
//  SessionController.swift
//  GWENT-Builder
//
//  Created by Jose Carlos on 9/20/16.
//  Copyright © 2016 Jose Carlos. All rights reserved.
//

import Foundation
import gwentBusiness


class SessionController
{
    public init(){}
    //Variables
    static let sharedInstance = SessionController()
    var REST:REST_Business = REST_Business()
}
