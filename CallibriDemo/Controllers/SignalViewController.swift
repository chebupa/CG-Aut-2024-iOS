import UIKit
import DropDown
import neurosdk2

class SignalViewController: UIViewController {

    @IBOutlet weak var signalView: SignalGraphView!
    
    let dropDown = DropDown()
    
    var isSignal = false;
    
    var timer: Timer?
    let queue = DispatchQueue(label: "thread-safe-samples", attributes: .concurrent)
    var signalSamples = [NSNumber]()
    
    var signalTypesArr = ["EEG", "EMG", "ECG", "EDA", "StrainGaugeBreathing", "ImpedanceBreathing"]
    var signalTypesDropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signalTypesDropDown.dataSource = signalTypesArr
        signalTypesDropDown.selectRow(at: 2)

        signalView.initGraph(samplingFrequency: 100, channelName: "Signal", yMin: 10.0, yMax: -10.0)
        
        timer = Timer.scheduledTimer(timeInterval: 1.0/30.0, target: self, selector: #selector(updateGraph), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        CallibriController.shared.stopSignal()
        timer?.invalidate()
        timer = nil
    }
    
    @IBAction func onStartButtonTapped(_ sender: UIButton) {
        if(!isSignal){
            CallibriController.shared.startSignal { [self] data in
                queue.async(flags: .barrier) { [self] in
                    for pack in data{
                        for sample in pack.samples{
                            signalSamples.append(sample.floatValue * 5000 as NSNumber)
                        }
                    }
                }
            }
            sender.setTitle("Stop", for: .normal)
        }
        else
        {
            CallibriController.shared.stopSignal()
            sender.setTitle("Start", for: .normal)
        }
        isSignal = !isSignal;
    }
    
    @objc func updateGraph() {
        
        queue.sync {
            signalView.dataChanged(newValues: signalSamples)
            
            signalSamples.removeAll()
        }
        
    }
    
    @IBAction func signalSettingsChanged(_ sender: UIButton) {
        signalTypesDropDown.anchorView = sender
        signalTypesDropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        signalTypesDropDown.show()
        signalTypesDropDown.selectionAction = { [weak self] (index: Int, item: String) in
              
              sender.setTitle(item, for: .normal)
            CallibriController.shared.setSignalType(signalType: UInt8(index))
        }
    }
}

