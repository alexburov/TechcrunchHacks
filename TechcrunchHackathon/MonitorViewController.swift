//
//  FirstViewController.swift
//  TechcrunchHackathon
//
//  Created by Olexiy Burov on 9/10/16.
//  Copyright © 2016 Bilbo Baggins. All rights reserved.
//

import UIKit

class MonitorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var deviceTableView: UITableView!
    
    @IBOutlet weak var gaugeView: SFGaugeView!
    let executor = RequestExecutor()
    
    var count = 0
    
    var harmonics = Array(count: 51, repeatedValue: 0)
    {
        didSet
        {
            var totalPowerConsumption = 0
            
            if isLampOn()
            {
                totalPowerConsumption += 60
            }
            
            if isLaptopOn()
            {
                totalPowerConsumption += 65
            }
            
            gaugeView.currentLevel = totalPowerConsumption
            deviceTableView.reloadData()
            fetchNewHarmonics()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DeviceTableViewCell", bundle: nil)
//        deviceTableView.registerClass(DeviceTableViewCell.self, forCellReuseIdentifier: "DeviceTableViewCell")
        deviceTableView.registerNib(nib, forCellReuseIdentifier: "DeviceTableViewCell")
        deviceTableView.dataSource = self
        deviceTableView.delegate = self
        deviceTableView.separatorStyle = .None
        
        fetchNewHarmonics()
        
        gaugeView.minlevel = 0
        gaugeView.maxlevel = 500
        gaugeView.currentLevel = 0
        gaugeView.bgColor = gaugeView.tintColor
        gaugeView.needleColor = UIColor.orangeColor()
        gaugeView.autoAdjustImageColors = false
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return 9
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("DeviceTableViewCell") as! DeviceTableViewCell
        
        if indexPath.row == 0 // Lamp
        {
            let state = isLampOn() ? "Running" : "Not running"
            cell.setData("Lights", state: state)
        }
        else if indexPath.row == 1 // MacBook
        {
            let state = isLaptopOn() ? "Running" : "Not running"
            cell.setData("MacBook", state: state)
        }
        else if indexPath.row == 2 // Fridge
        {
            cell.setData("Fridge", state: "Not running")
        }
        else if indexPath.row == 3 // Microwave
        {
            cell.setData("Microwave", state: "Not running")
        }
        else if indexPath.row == 4 // Iron
        {
            cell.setData("Iron", state: "Not running")
        }
        else if indexPath.row == 5 // Coffee maker
        {
            cell.setData("Coffee Maker", state: "Not running")
        }
        else if indexPath.row == 6 // Stove
        {
            cell.setData("Cooker", state: "Not running")
        }
        else if indexPath.row == 7 // Washer
        {
            cell.setData("Washer", state: "Not running")
        }
        else if indexPath.row == 8 // EV
        {
            cell.setData("Electric Vehicle", state: "Not charging")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? DeviceTableViewCell
        {
            if cell.deviceNameLabel.text == "Electric Vehicle"
            {
                performSegueWithIdentifier("showTimePricing", sender: self)
            }
        }
    }
    
    private func isLampOn() -> Bool
    {
        if harmonics[0] > 75
        {
            count = 0
            return true
        }
        else
        {
            count++
            if count < 3
            {
                return true
            }
            else
            {
                return false
            }
        }
    }
    
    private func isLaptopOn() -> Bool
    {
        return harmonics[2] > 5
    }
    
    private func fetchNewHarmonics()
    {
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(MonitorViewController.sendRequest), userInfo: nil, repeats: false)
    }
    
    func sendRequest()
    {
        executor.sendRequest {
            (data) in
            if data != nil
            {
                self.harmonics = data!
            }
        }
    }
}

