//
//  ResistanceController.swift
//  BrainBitDemo
//
//  Created by Aseatari on 21.02.2023.
//

import UIKit

class EnvelopeViewController: UIViewController {
    
    @IBOutlet weak var EnvelopeGraph: SignalGraphView!
    
    var isSignal = false;
    
    var timer: Timer?
    let queue = DispatchQueue(label: "thread-safe-samples", attributes: .concurrent)
    var signalSamples = [NSNumber]()
    
    
    override func viewDidLoad() {
        EnvelopeGraph.initGraph(samplingFrequency: 40, channelName: "Envelope", yMin: 0, yMax: 300.0)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0/30.0, target: self, selector: #selector(updateGraph), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CallibriController.shared.stopEnv()
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func onStartTapped(_ sender: UIButton) {
        if(!isSignal){
            CallibriController.shared.startEnv { [self] data in
                queue.async(flags: .barrier) { [self] in
                    for sample in data{
                        signalSamples.append(sample.sample.floatValue * 1e6 as NSNumber)
                    }
                }
            }
            sender.setTitle("Stop", for: .normal)
        }
        else
        {
            CallibriController.shared.stopEnv()
            sender.setTitle("Start", for: .normal)
        }
        isSignal = !isSignal;
    }
    
    @objc func updateGraph() {
        queue.sync {
            EnvelopeGraph.dataChanged(newValues: signalSamples)
            
            signalSamples.removeAll()
        }
    }
}
