//
//  SecondViewController.swift
//  TechcrunchHackathon
//
//  Created by PRO: Olexiy Burov on 9/10/16.
//  Copyright © 2016 Bilbo Baggins. All rights reserved.

import UIKit

class TrainController: UIViewController
{
    @IBOutlet weak var image: UIImageView!
    
    var showedAlert = false
    
    let executor = RequestExecutor()

    @IBOutlet weak var temperatureLabel: UILabel!
    var harmonics = Array(count: 51, repeatedValue: 0)
        {
        didSet
        {
            let temperatureValue = harmonics[49]
            temperature = convertToFahrenheit(temperatureValue)
            fetchNewHarmonics()
        }
    }
    
    var temperature = 0.0
        {
        didSet
        {
            updateThermometer()
            
            if temperature < 65 && !showedAlert
            {
                showedAlert = true
                showAlert()
            }
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        fetchNewHarmonics()
    }
    
    private func fetchNewHarmonics()
    {
        executor.sendRequest {
            (data) in
            if data != nil
            {
                self.harmonics = data!
            }
        }
    }
    
    private func convertToFahrenheit(rawValue: Int) -> Double
    {
        let mVolts = ((Double(rawValue) / 4096.0) * 1.14) * 1000
        let celcius = mVolts / 10
        return (celcius * (9/5) + 32)
    }
    
    func updateThermometer()
    {
        temperatureLabel.text = String(format: "%.1f F", temperature)
        
        var tempImage: UIImage!
        
        let index = temperature / 13
        tempImage = UIImage(named: "Slide\(index)")
        
        image.image = tempImage
    }
    
    func showAlert()
    {
        let alert = UIAlertController(title: "Low temperature", message: "The temperature went below set limit of 75 F", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        alert.addAction(UIAlertAction(title: "Manage Temperature", style: .Default, handler: nil))
        
        presentViewController(alert, animated: true, completion: nil)
    }
}

