//
//  DataPoint.swift
//  TechcrunchHackathon
//
//  Created by PRO: Olexiy Burov on 9/10/16.
//  Copyright © 2016 Bilbo Baggins. All rights reserved.
//

import Foundation

 struct DataPoint
{
    var timestamp: String?
    var harmonicsVector: HarmonicsVector?
    
    init (harmonicsVector: HarmonicsVector, timestamp: String)
    {
        self.harmonicsVector = harmonicsVector
        self.timestamp = timestamp
    }
}