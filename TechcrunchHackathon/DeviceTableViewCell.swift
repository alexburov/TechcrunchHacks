//
//  DeviceTableViewCell.swift
//  TechcrunchHackathon
//
//  Created by PRO: Olexiy Burov on 9/10/16.
//  Copyright © 2016 Bilbo Baggins. All rights reserved.

import UIKit

class DeviceTableViewCell: UITableViewCell
{
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceStateLabel: UILabel!
    
    @IBOutlet weak var deviceImage: UIImageView!
    func setData(name: String, state: String)
    {
        deviceNameLabel.text = name
        
        let color = state == "Running" ? UIColor.greenColor() : UIColor.redColor()
        deviceStateLabel.text = state
        deviceStateLabel.textColor = color
        
        
        var image: UIImage!
        
        if name == "MacBook"
        {
            if state == "Running"
            {
                image = UIImage(named: "laptop_on")
            }
            else
            {
                image = UIImage(named: "laptop_off")
            }
        }
        else if name == "Lights"
        {
            if state == "Running"
            {
                image = UIImage(named: "lamp_on")
            }
            else
            {
                image = UIImage(named: "lamp_off")
            }
        }
        else if name == "Fridge"
        {
            image = UIImage(named: "fridge_off")
        }
        else if name == "Microwave"
        {
            image = UIImage(named: "microwave_off")
        }
        else if name == "Iron"
        {
            image = UIImage(named: "iron_off")
        }
        else if name == "Coffee Maker"
        {
            image = UIImage(named: "coffee_off")
        }
        else if name == "Cooker"
        {
            image = UIImage(named: "cooker_off")
        }
        else if name == "Washer"
        {
            image = UIImage(named: "washer_off")
        }
        else if name == "Electric Vehicle"
        {
            image = UIImage(named: "tesla_logo")
        }
        
        deviceImage.image = image
    }
}
