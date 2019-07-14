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
  
  private let barChartView = BarChartView()
  @objc var dataDictionaries: NSDictionary = [:] {
    didSet {
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
  
  private func setUpChartsView(frame: CGRect) {
    self.addSubview(barChartView)
    barChartView.translatesAutoresizingMaskIntoConstraints = false
    let top = NSLayoutConstraint(item: barChartView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0)
    let bottom = NSLayoutConstraint(item: barChartView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
    let leading = NSLayoutConstraint(item: barChartView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0)
    let trailing = NSLayoutConstraint(item: barChartView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
    self.addConstraints([top, bottom, leading, trailing])
  }
  
  private func setBarChart(with jsonArray: [String: Any]) {
    let values = parseJSON(with: jsonArray)
    createDataSet(values: values.values)
    setUpFormatter(labels: values.dates)
    setBarChartProperties()
  }
  
  private func createDataSet(values: [Int]) {
    var dataEntry: [BarChartDataEntry] = []
    for i in 0..<values.count {
      let dataPoint = BarChartDataEntry(x: Double(i), y: Double(values[i]))
      dataEntry.append(dataPoint)
    }
    let chartDataset = BarChartDataSet(entries: dataEntry, label: "Revenue")
    let chartData = BarChartData()
    chartData.addDataSet(chartDataset)
    chartData.setDrawValues(false)
    chartDataset.colors = [UIColor.purple]
    barChartView.data = chartData
  }
  
  private func setUpFormatter(labels: [String]) {
    let formatter = Formatter()
    formatter.xAxisLabels = labels
    let xAxis = XAxis()
    xAxis.valueFormatter = formatter
    barChartView.xAxis.valueFormatter = xAxis.valueFormatter
  }
  
  private func setBarChartProperties() {
    barChartView.noDataTextColor = .white
    barChartView.noDataText = "No Data Available."
    barChartView.xAxis.labelPosition = .bottom
    barChartView.drawGridBackgroundEnabled = true
    barChartView.chartDescription?.enabled = false
    barChartView.legend.enabled = false
    barChartView.rightAxis.enabled = false
    barChartView.leftAxis.drawGridLinesEnabled = false
    barChartView.leftAxis.drawZeroLineEnabled = true
    barChartView.extraBottomOffset = 25.0
    barChartView.xAxis.labelRotationAngle = 90
  }

  private func parseJSON(with jsonArray: [String: Any]) -> (dates: [String], values: [Int]) {
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
}

fileprivate class Formatter: NSObject, IAxisValueFormatter {
  var xAxisLabels: [String] = []
  func stringForValue(_ value: Double, axis: AxisBase?) -> String {
    guard xAxisLabels.count > Int(value) else { return "No Label" }
    return xAxisLabels[Int(value)]
  }
}
