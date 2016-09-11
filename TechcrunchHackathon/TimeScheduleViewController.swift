//
//  TimeScheduleViewController.swift
//  TechcrunchHackathon
//
//  Created by PRO: Olexiy Burov on 9/11/16.
//  Copyright © 2016 Bilbo Baggins. All rights reserved.
//

import UIKit
import Charts

class TimeScheduleViewController: UIViewController
{
    @IBOutlet weak var barChart: BarChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        populateChart()
    }
    
    private func setup() {
        barChart.descriptionText = ""
        barChart.noDataTextDescription = "You need to provide data for the chart."
        
        barChart.drawGridBackgroundEnabled = false;
        
        barChart.leftAxis.axisMinValue = 0.0
        barChart.leftAxis.axisMaxValue = 100.0
        barChart.rightAxis.enabled = false
        barChart.xAxis.labelPosition = .Bottom
        barChart.legend.enabled = false
    }
    
    private func populateChart() {
        var yValuesCons = [BarChartDataEntry]()
        var morningPrices = [ChartDataEntry]()
        var dayPrices = [ChartDataEntry]()
        var eveningPrices = [ChartDataEntry]()

        
        morningPrices.append(BarChartDataEntry(value: 50, xIndex: 0))
        dayPrices.append(BarChartDataEntry(value: 65, xIndex: 1))
        eveningPrices.append(BarChartDataEntry(value: 70, xIndex: 2))

        var xValues = ["Untill 12PM", "12PM - 6PM", "6PM - 9PM"]
        
        
        let price1DataSet = BarChartDataSet(yVals: morningPrices, label: "Morning Pricing")
        price1DataSet.setColor(UIColor.greenColor())
        price1DataSet.drawValuesEnabled = false
        let formatter = NSNumberFormatter()
        formatter.positiveFormat = "%d"
        
        let price2DataSet = BarChartDataSet(yVals: dayPrices, label: "Day Pricing")
        price2DataSet.setColor(UIColor.orangeColor())
        price2DataSet.drawValuesEnabled = false
        
        let price3DataSet = BarChartDataSet(yVals: eveningPrices, label: "Evening Pricing")
        price3DataSet.setColor(UIColor.redColor())
        price3DataSet.drawValuesEnabled = false
        
        
        let dataSets = [price1DataSet,price2DataSet,price3DataSet]
        
        for dataset in dataSets
        {
            dataset.valueFormatter?.maximumFractionDigits = 0
            dataset.valueFormatter?.maximumIntegerDigits = 2
            dataset.valueFormatter?.positiveSuffix = " ¢"
        }
        
        
        
        let data = BarChartData(xVals: xValues, dataSets: [price1DataSet,price2DataSet,price3DataSet])

        
        
        barChart.data = data
    }
}