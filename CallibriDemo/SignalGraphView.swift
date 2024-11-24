//
//  SignalGraphView.swift
//  TestSDKSwift
//
//  Created by Aseatari on 29.11.2022.
//

import Foundation
import CorePlot

class SignalGraphView: CPTGraphHostingView, CPTPlotDataSource, CPTPlotSpaceDelegate {
    
    var plotData : NSMutableArray = [0.0]
    var currentIndex: Int!
    var plot: CPTScatterPlot!
    var maxDataPoints = 250 * 5
    
    func initGraph(samplingFrequency: Int, channelName: String, yMin: CGFloat, yMax: CGFloat) {
        self.allowPinchScaling = false
        self.plotData.removeAllObjects()
        self.currentIndex = 0
                
        maxDataPoints = samplingFrequency * 5
        
        //Configure graph
        let graph = CPTXYGraph(frame: self.bounds)
        graph.plotAreaFrame?.masksToBorder = false
        self.hostedGraph = graph
        graph.backgroundColor = UIColor.white.cgColor
        graph.paddingBottom = 10
        graph.paddingLeft = 40.0
        graph.paddingTop = 10
        graph.paddingRight = 10.0
        
        //Style for graph title
        let titleStyle = CPTMutableTextStyle()
        titleStyle.color = CPTColor.black()
        titleStyle.fontName = "HelveticaNeue-Bold"
        titleStyle.fontSize = 20.0
        titleStyle.textAlignment = .center
        graph.titleTextStyle = titleStyle

        //Set graph title
        graph.title = channelName
        graph.titlePlotAreaFrameAnchor = .top
        graph.titleDisplacement = CGPoint(x: 0.0, y: 0.0)
        
        let axisSet = graph.axisSet as! CPTXYAxisSet
        
        let axisTextStyle = CPTMutableTextStyle()
        axisTextStyle.color = CPTColor.black()
        axisTextStyle.fontName = "HelveticaNeue-Bold"
        axisTextStyle.fontSize = 10.0
        axisTextStyle.textAlignment = .center
        let lineStyle = CPTMutableLineStyle()
        lineStyle.lineColor = CPTColor.black()
        lineStyle.lineWidth = 5
        let gridLineStyle = CPTMutableLineStyle()
        gridLineStyle.lineColor = CPTColor.gray()
        gridLineStyle.lineWidth = 0.5
       

        if let x = axisSet.xAxis {
            x.majorIntervalLength   = (samplingFrequency) as NSNumber
            x.minorTicksPerInterval = UInt(samplingFrequency)
            x.labelTextStyle = axisTextStyle
            x.minorGridLineStyle = gridLineStyle
            x.axisLineStyle = lineStyle
            x.axisConstraints = CPTConstraints(lowerOffset: 0.0)
            x.delegate = self
        }

        if let y = axisSet.yAxis {
            y.majorIntervalLength   = 5000
            y.minorTicksPerInterval = UInt(samplingFrequency)
            y.minorGridLineStyle = gridLineStyle
            y.labelTextStyle = axisTextStyle
            y.axisLineStyle = lineStyle
            y.axisConstraints = CPTConstraints(lowerOffset: 5.0)
            y.delegate = self
        }

        // Set plot space
        let xMin = 0.0
        let xMax = maxDataPoints
        let yMin = yMin
        let yMax = yMax
        guard let plotSpace = graph.defaultPlotSpace as? CPTXYPlotSpace else { return }
        plotSpace.xRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(xMin), lengthDecimal: CPTDecimalFromDouble(Double(xMax) - xMin))
        plotSpace.yRange = CPTPlotRange(locationDecimal: CPTDecimalFromDouble(yMin), lengthDecimal: CPTDecimalFromDouble(yMax - yMin))
        
        let plotLineStile = CPTMutableLineStyle()
        plotLineStile.lineJoin = .round
        plotLineStile.lineCap = .round
        plotLineStile.lineWidth = 2
        plotLineStile.lineColor = CPTColor.red()
        
        // Grid lines
//        if let axisSet = graph.axisSet as? CPTXYAxisSet {
//            // X-Axis
//            let xAxis = axisSet.xAxis
//            let yAxis = axisSet.yAxis
//            
//            let majorGridLineStyle = CPTMutableLineStyle()
//            majorGridLineStyle.lineWidth = 1.0
//            majorGridLineStyle.lineColor = CPTColor.gray()
//            
//            let minorGridLineStyle = CPTMutableLineStyle()
//            minorGridLineStyle.lineWidth = 10
//            minorGridLineStyle.lineColor = CPTColor.lightGray()
//            
//            // Configure X-Axis grid lines
//            xAxis?.majorGridLineStyle = majorGridLineStyle
//            xAxis?.minorGridLineStyle = minorGridLineStyle
//            xAxis?.majorIntervalLength = 2.0
//            xAxis?.minorTicksPerInterval = 1
//            xAxis?.title = "X-Axis"
//            
//            // Configure Y-Axis grid lines
//            yAxis?.majorGridLineStyle = majorGridLineStyle
//            yAxis?.minorGridLineStyle = minorGridLineStyle
//            yAxis?.majorIntervalLength = 20.0
//            yAxis?.minorTicksPerInterval = 4
//            yAxis?.title = "Y-Axis"
//        }
        
        plot = CPTScatterPlot()
        plot.dataLineStyle = plotLineStile
        plot.identifier = "signal-graph" as NSCoding & NSCopying & NSObjectProtocol
        guard let graph1 = self.hostedGraph else { return }
        plot.dataSource = (self as CPTPlotDataSource)
        plot.delegate = (self as CALayerDelegate)
        graph.add(plot, to: graph1.defaultPlotSpace)
    }
    
    func dataChanged(newValues: [NSNumber]){
        let graph = plot.graph
        let plotSpace = graph?.defaultPlotSpace as? CPTXYPlotSpace
        currentIndex += newValues.count
        plotData.addObjects(from: newValues)
        var location: NSInteger = 0
        if (currentIndex >= maxDataPoints) {
            location = currentIndex - maxDataPoints
        }
        plotSpace?.xRange = CPTPlotRange(location: NSNumber(value: location), length: NSNumber(value: maxDataPoints))
        
        plot.reloadData()
    }
    
    
    func numberOfRecords(for plot: CPTPlot) -> UInt {
        return UInt(plotData.count)
    }
    
    func numbers(for plot: CPTPlot, field fieldEnum: UInt, recordIndexRange indexRange: NSRange) -> [Any]? {

        if(fieldEnum == CPTScatterPlotField.X.rawValue){
            var array:[NSNumber] = []
            for i in indexRange.location..<indexRange.location + indexRange.length {
                array.append(NSNumber.init(value: i))
            }
            return array;
        }else if(fieldEnum == CPTScatterPlotField.Y.rawValue){
            let indexes: NSIndexSet? = NSIndexSet(indexesIn: indexRange)
            return indexes?.map { plotData[$0] }
        }
        
        return []
    }
    
}
