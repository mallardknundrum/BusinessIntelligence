//
//  ChartsView.swift
//  BusinessIntelligence
//
//  Created by Jeremiah Hawks on 7/14/19.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import Charts

class ChartView: UIView {
  
  let barChartView = BarChartView()
//
  var dataEntry: [BarChartDataEntry] = []
  @objc var dataDictionaries: NSDictionary = [:] {
    didSet (newValue) {
      print(newValue)
      var dictionary = [String: Any]()
      for (key, value) in self.dataDictionaries {
        dictionary[key as! String] = value
      }
      setBarChart(with: dictionary)
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setUpChartsView(frame: frame)
  }
  
  func setUpChartsView(frame: CGRect) {
    self.addSubview(barChartView)
    barChartView.translatesAutoresizingMaskIntoConstraints = false
    let top = NSLayoutConstraint(item: barChartView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
    let bottom = NSLayoutConstraint(item: barChartView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
    let leading = NSLayoutConstraint(item: barChartView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
    let trailing = NSLayoutConstraint(item: barChartView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
    self.addConstraints([top, bottom, leading, trailing])
  }
  
  func setBarChart(with jsonArray: [String: Any]) {
    barChartView.noDataTextColor = .white
    barChartView.noDataText = "No Data Available."
    
    let values = parseJSON(with: jsonArray)
    
    for i in 0..<values.values.count {
      let dataPoint = BarChartDataEntry(x: Double(i), y: Double(values.values[i]))
      dataEntry.append(dataPoint)
    }
    
    let chartDataset = BarChartDataSet(entries: dataEntry, label: "Revenue")
    let chartData = BarChartData()
    chartData.addDataSet(chartDataset)
    chartData.setDrawValues(false)
    chartDataset.colors = [UIColor.purple]
    
    let formatter = Formatter()
    formatter.xAxisLabels = values.dates
    let xAxis = XAxis()
    xAxis.valueFormatter = formatter
    barChartView.xAxis.labelPosition = .bottom
    barChartView.drawGridBackgroundEnabled = true
    barChartView.xAxis.valueFormatter = xAxis.valueFormatter
    barChartView.chartDescription?.enabled = false
    barChartView.legend.enabled = false
    barChartView.rightAxis.enabled = false
    barChartView.leftAxis.drawGridLinesEnabled = false
    barChartView.leftAxis.drawZeroLineEnabled = true
    barChartView.data = chartData
    barChartView.extraBottomOffset = 25.0
    barChartView.xAxis.labelRotationAngle = 90
  }

  func parseJSON(with jsonArray: [String: Any]) -> (dates: [String], values: [Int]) {
    guard let revenueDictionary = jsonArray["revenue"] as? [[String: Any]] else { return ([], []) }
    var dates: [String] = []
    var values: [Int] = []
    for item in revenueDictionary {
      guard let date = item["date"] as? String,
        let value = item["value"] as? Double else { break }
      dates.append(String(date.split(separator: " ")[0]))
      values.append(Int(value))
    }
    
    return (Array(dates.reversed()), Array(values.reversed()))
  }
  
  
  let jsonData = """
[
{
"seq": 0,
"date": "2019-03-12 00:14:10",
"value": 77793740.07
},
{
"seq": 1,
"date": "2019-02-12 00:14:10",
"value": 17659305.4
},
{
"seq": 2,
"date": "2019-01-12 00:14:10",
"value": 79457805.93
},
{
"seq": 3,
"date": "2018-12-12 00:14:10",
"value": 12291141.73
},
{
"seq": 4,
"date": "2018-11-12 00:14:10",
"value": 15418844.3
},
{
"seq": 5,
"date": "2018-10-12 00:14:10",
"value": 73533303.23
}
]
""".data(using: .utf8)!
}

class Formatter: NSObject, IAxisValueFormatter {
  var xAxisLabels: [String] = []
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    guard xAxisLabels.count > Int(value) else { return "No Label" }
    return xAxisLabels[Int(value)]
  }
}
