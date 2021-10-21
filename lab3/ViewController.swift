//
//  ViewController.swift
//  lab3
//
//  Created by Илья Нечаев on 21.10.2021.
//

import UIKit
import Charts
import TinyConstraints

class ViewController: UIViewController, ChartViewDelegate {
    lazy var lineChartView: LineChartView = {
        let chartView = LineChartView()
        chartView.backgroundColor = .systemBlue
        
        
        
        chartView.rightAxis.enabled = false
        
        let yAxis = chartView.leftAxis
        yAxis.labelFont = .boldSystemFont(ofSize: 12)
        yAxis.setLabelCount(6, force: false)
        yAxis.labelTextColor = .white
        yAxis.axisLineColor = .white
        yAxis.labelPosition = .insideChart
        
        chartView.xAxis.labelPosition = .bottomInside
        chartView.xAxis.labelFont = .boldSystemFont(ofSize: 12)
        chartView.xAxis.labelTextColor = .white
        chartView.xAxis.axisLineColor = .white
        
        chartView.xAxis.axisMinimum = Double.pi / 2
        chartView.xAxis.axisMaximum = Double.pi * 6
        
        chartView.animate(xAxisDuration: 2.5 )
        
        let leftAxis = chartView.leftAxis
        leftAxis.drawZeroLineEnabled = true
        leftAxis.axisLineWidth = 2
        leftAxis.zeroLineWidth = leftAxis.axisLineWidth
        leftAxis.zeroLineColor = leftAxis.axisLineColor
        
        return chartView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(lineChartView)
        lineChartView.centerInSuperview()
        lineChartView.width(to: view)
        lineChartView.heightToWidth(of: view)
        
        setData()
    }
    
    func setData() {
        let set1 = LineChartDataSet(entries: setValues(), label: "y=sin^3(x)-cos^3(x)")
        
        set1.mode = .cubicBezier
        set1.lineWidth = 3
        set1.drawCirclesEnabled = false
        set1.setColor(.white)
        set1.fill = Fill(color: .white)
        set1.fillAlpha = 0.8
        set1.drawFilledEnabled = true
        
        set1.drawHorizontalHighlightIndicatorEnabled = false
        set1.highlightColor = .systemRed
        
        let data = LineChartData(dataSet: set1)
        data.setDrawValues(false)
        lineChartView.data = data
    }
    
    func setValues() -> [ChartDataEntry] {
        var arrayOfValues: [ChartDataEntry] = []
        
        for x in stride(from: (Double.pi / 2), to: Double.pi * 6, by: +0.001) {
            arrayOfValues.append(ChartDataEntry(x: x, y: pow(sin(x), 3) - pow(cos(x), 3)))
        }
        
        return arrayOfValues
    }
    
}

//MARK: - Protocol ChartViewDelegate
extension ViewController {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        print(entry)
    }
}


