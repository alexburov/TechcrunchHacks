//
//  SeadsRequest.swift
//  SEADS
//
//  Created by Olexiy Burov on 11/30/15.
//  Copyright © 2015 Olexiy Burov. All rights reserved.
//

import Foundation
//db.sead.systems:8080/466419817?start_time=1445756400&end_time=1445842800&list_format=energy&granularity=60&device=Panel1&type=P

public class SeadsRequest
{
    public var startTime: NSDate!
    public var endTime: NSDate!
    public var listFormat: String!
    public var granuality = 3600
    public var device: String!
    public var type: String!
    
    public init(startTime: NSDate, endTime: NSDate, listFormat: String, device: String, type: String)
    {
        self.startTime = startTime
        self.endTime = endTime
        self.listFormat = listFormat
        self.device = device
        self.type = type
    }
}
