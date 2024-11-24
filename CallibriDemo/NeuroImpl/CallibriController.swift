//
//  BrainBitController.swift
//  BrainBitDemo
//
//  Created by Aseatari on 20.02.2023.
//

import Foundation
import neurosdk2

typealias SensorsChangedCallback = (_ sensors: [NTSensorInfo]) -> Void

typealias SensorStateCallback = (_ state : NTSensorState)  -> Void
typealias DevicePowerCallback = (_ power : NSNumber)  -> Void
typealias SignalDataCallback = (_ data: [NTCallibriSignalData]) -> Void

class CallibriController{
    
    static let shared = CallibriController()
    private init() { }
    
// MARK: - Scanner
    var scanner: NTScanner?

    func startSearch(sensorsChanged:  @escaping SensorsChangedCallback){
        if(scanner != nil){
            scanner = nil
        }
        if(scanner == nil){
            scanner = NTScanner(sensorFamily: [NTSensorFamily.leCallibri.rawValue, NTSensorFamily.leKolibri.rawValue])
        }
        scanner?.setSensorsCallback(sensorsChanged)
        scanner?.startScan()
    }
    
    func stpoSearch(){
        scanner?.stopScan()
    }
    
    var availableSensors: [NTSensorInfo]? {
        get{
            scanner?.sensors
        }
    }
    
// MARK: - Device
    var sensor: NTCallibri?
    
    var connectionStateChanged: SensorStateCallback?
    var batteryChanged: DevicePowerCallback?
	
    func createAndConnect(sensorInfo: NTSensorInfo, onConnectionResult: @escaping SensorStateCallback){
        DispatchQueue.global(qos: .userInitiated).async { [self, onConnectionResult] in
            do {
                try ObjcEx.catchException {
                    self.sensor = self.scanner?.createSensor(sensorInfo) as? NTCallibri
                }
            } catch let error {
                print(error.localizedDescription)
            }
            if(sensor != nil){
                sensor?.setConnectionStateCallback(connectionStateChanged)
                sensor?.setBatteryCallback(batteryChanged)
                
                sensor?.signalTypeCallibri = .ECG
                sensor?.samplingFrequency = NTSensorSamplingFrequency.hz1000
                sensor?.hardwareFilters = [NSNumber(value: NTSensorFilter.hpfBwhLvl1CutoffFreq1Hz.rawValue)]
                
                connectionStateChanged?(NTSensorState.inRange)
                onConnectionResult(NTSensorState.inRange)
            }
            else
            {
                onConnectionResult(NTSensorState.outOfRange)
            }
        }
        
    }
    
    func connectCurrent(onConnectionResult: @escaping SensorStateCallback){
        if(connectionState == NTSensorState.outOfRange){
            DispatchQueue.global(qos: .userInitiated).async { [self, onConnectionResult] in
                sensor?.connect()
                onConnectionResult(NTSensorState(rawValue: (sensor?.state)!.rawValue) ?? NTSensorState.outOfRange)
            }
        }
    }
    
    func disconnectCurrent(){
        sensor?.disconnect()
    }
    
    func closeSensor(){
        sensor = nil
    }
    
    var connectionState: NTSensorState? {
        get{
            sensor?.state
        }
    }
    
// MARK: - Parameters
    func fullInfo() -> String {
        var val_info = "Parameters: "
        for param in sensor?.parameters ?? [] {
            val_info += "\n\tName: \(paramEnumToString(param: param.param))"
            val_info += "\n\t\tAccess: \(accessEnumToString(access: param.paramAccess))"
            switch(param.param){
            case .name:
                val_info += "\n\t\tValue: \(String(describing: sensor?.name))"
                break
            case .state:
                val_info += "\n\t\tValue: \(String(describing: sensor?.state))"
                break
            case .address:
                val_info += "\n\t\tValue: \(String(describing: sensor?.address))"
                break
            case .serialNumber:
                val_info += "\n\t\tValue: \(String(describing: sensor?.serialNumber))"
                break
            case .hardwareFilterState:
                val_info += "\n\t\tValue: "
                let filters = sensor?.hardwareFilters
                for filter in filters ?? [] {
                    val_info += "\n\t\t\t \(hwFilterToString(f: NTSensorFilter(rawValue: filter.uint8Value) ?? NTSensorFilter.hpfBwhLvl1CutoffFreq1Hz))"
                }
                break
            case .firmwareMode:
                val_info += "\n\t\tValue: \(modeEnumToString(mode: sensor?.firmwareMode ?? .application))"
                break
            case .samplingFrequency:
                val_info += "\n\t\tValue: \(sfEnumToString(sf: sensor?.samplingFrequency ?? .unsupported))"
                break
            case .gain:
                val_info += "\n\t\tValue: \(gainToString(gain: sensor?.gain ?? .gainUnsupported))"
                break
            case .offset:
                val_info += "\n\t\tValue: \(dOffsetToString(offset: sensor?.dataOffset ?? .offsetUnsupported))"
                break
            case .externalSwitchState:
                val_info += "\n\t\tValue: \(extSwInputToString(extSwInput: sensor?.extSwInput ?? .mioElectrodesRespUSB))"
                break
            case .adcInputState:
                val_info += "\n\t\tValue: \(adcInpToString(adcInp: sensor?.adcInput ?? .test))"
                break
            case .accelerometerSens:
                val_info += "\n\t\tValue: \(accSencToString(accSens: sensor?.accSens ?? .sensitivityUnsupported))"
                break
            case .gyroscopeSens:
                val_info += "\n\t\tValue: \(gyroSensToString(gyroSens: sensor?.gyroSens ?? .sensitivityUnsupported))"
                break
            case .stimulatorAndMAState:
                val_info += "\n\t\tStimulator state: \(String(describing: sensor?.stimulatorMAStateCallibri?.stimulatorState))"
                val_info += "\n\t\tMA state: \(String(describing: sensor?.stimulatorMAStateCallibri?.maState))"
                break
            case .stimulatorParamPack:
                val_info += "\n\t\tCurrent: \(String(describing: sensor?.stimulatorParamCallibri?.current))"
                val_info += "\n\t\tFrequency: \(String(describing: sensor?.stimulatorParamCallibri?.frequency))"
                val_info += "\n\t\tPulse width: \(String(describing: sensor?.stimulatorParamCallibri?.pulseWidth))"
                val_info += "\n\t\tStimulus duration: \(String(describing: sensor?.stimulatorParamCallibri?.stimulusDuration))"
                break
            case .motionAssistantParamPack:
                val_info += "\n\t\tGyro start: \(String(describing: sensor?.motionAssistantParamCallibri?.gyroStart))"
                val_info += "\n\t\tGyro stop: \(String(describing: sensor?.motionAssistantParamCallibri?.gyroStop))"
                val_info += "\n\t\tLimb: \(String(describing: sensor?.motionAssistantParamCallibri?.limb))"
                val_info += "\n\t\tMin pause (in ms): \(String(describing: sensor?.motionAssistantParamCallibri?.minPauseMs))"
                break
            case .firmwareVersion:
                val_info += "\n\t\tFW version: \(String(describing: sensor?.version.fwMajor)).\(String(describing: sensor?.version.fwMinor)).\(String(describing: sensor?.version.fwPatch))"
                val_info += "\n\t\tHW version: \(String(describing: sensor?.version.hwMajor)).\(String(describing: sensor?.version.hwMinor)).\(String(describing: sensor?.version.hwPatch))"
                val_info += "\n\t\tExtension: \(String(describing: sensor?.version.extMajor))"
                break
            case .memsCalibrationStatus:
                val_info += "\n  Value: \(String(describing: sensor?.memCalibrateState))"
                break
            case .motionCounterParamPack:
                val_info += "\n\t\tInsense threshold MG: \(String(describing: sensor?.motionCounterParamCallibri?.insenseThresholdMG))"
                val_info += "\n\t\tInsense threshold sample: \(String(describing: sensor?.motionCounterParamCallibri?.insenseThresholdSample))"
                break
            case .motionCounter:
                val_info += "\n\t\tInsense threshold MG: \(String(describing: sensor?.motionCounterCallibri))"
                val_info += "\n\t\tInsense threshold sample: \(String(describing: sensor?.motionCounterParamCallibri?.insenseThresholdSample))"
                break
            case .battPower:
                val_info += "\n\t\tValue: \(String(describing: sensor?.battPower))"
                break
            case .sensorFamily:
                val_info += "\n\t\tValue: \(String(describing: sensor?.sensFamily))"
                break
            case .sensorMode:
                val_info += "\n\t\tValue: \(String(describing: sensor?.firmwareMode))"
                break
            case .irAmplitude, .redAmplitude, .envelopeAvgWndSz, .envelopeDecimation, .samplingFrequencyResist, .samplingFrequencyMEMS, .samplingFrequencyFPG, .amplifier:
                break
            case .sensorChannels:
                //val_info += "\n\t\tValue: \(sensor?.channelsCount)"
                break
            @unknown default:
                break
            }
        }
        
        val_info += "\nFeatures:"
        for feature in sensor?.features ?? [] {
            val_info += "\n\t\(featureNumberToString(number: feature))"
        }
        
        val_info += "\nCommands:"
        for commandElement in sensor?.commands ?? [] {
            val_info += "\n\t\(commandNumberToString(number: commandElement))"
        }

        return val_info
//        val info = buildString {
//                    append("Parameters: ")
//
//
//                    append("\tColor: \(sensor?.colorCallibri)")
//
//                    if(sensor?.isSupportedFeature(SensorFeature.Signal) == true){
//                        append("\nSignal type: \n\t\(sensor?.signalTypeCallibri)")
//                    }
//
//                    append("\n\nCommands: ")
//                    for(command in sensor?.supportedCommand!!){
//                        append("\n\t\(command.name)")
//                    }
//
//                    append("\n\nFeatures: ")
//                    for(feature in sensor?.supportedFeature!!){
//                        append("\n\t\(feature.name)")
//                    }
    }
    
    private func gyroSensToString(gyroSens: NTSensorGyroscopeSensitivity) -> String
    {
        switch(gyroSens)
        {
        case .sensitivity250Grad:
            return "sensitivity250Grad"
        case .sensitivity500Grad:
            return "sensitivity500Grad"
        case .sensitivity1000Grad:
            return "sensitivity1000Grad"
        case .sensitivity2000Grad:
            return "sensitivity2000Grad"
        case .sensitivityUnsupported:
            return "sensitivityUnsupported"
        @unknown default:
            return "sensitivityUnsupported"
        }
    }
    
    private func extSwInputToString(extSwInput: NTSensorExternalSwitchInput) -> String
    {
        switch(extSwInput)
        {
        case .mioElectrodesRespUSB:
            return "mioElectrodesRespUSB"
        case .mioElectrodes:
            return "mioElectrodes"
        case .mioUSB:
            return "mioUSB"
        case .respUSB:
            return "respUSB"
        @unknown default:
            return "unknown"
        }
    }
    
    private func accSencToString(accSens: NTSensorAccelerometerSensitivity) -> String
    {
        switch(accSens)
        {case .sensitivity2g:
            return "sensitivity2g"
        case .sensitivity4g:
            return "sensitivity4g"
        case .sensitivity8g:
            return "sensitivity8g"
        case .sensitivity16g:
            return "sensitivity16g"
        case .sensitivityUnsupported:
            return "sensitivityUnsupported"
        @unknown default:
            return "sensitivityUnsupported"
        }
        
    }
    
    private func adcInpToString(adcInp: NTSensorADCInput) -> String
    {
        switch(adcInp)
        {case .electrodes:
            return "electrodes"
        case .short:
            return "short"
        case .test:
            return "test"
        case .resistance:
            return "resistance"
        @unknown default:
            return "unknown"
        }
    }
    
    private func dOffsetToString(offset: NTSensorDataOffset) -> String {
        switch(offset)
        {
            
        case .offset0:
            return "offset0"
        case .offset1:
            return "offset1"
        case .offset2:
            return "offset2"
        case .offset3:
            return "offset3"
        case .offset4:
            return "offset4"
        case .offset5:
            return "offset5"
        case .offset6:
            return "offset6"
        case .offset7:
            return "offset7"
        case .offset8:
            return "offset8"
        case .offsetUnsupported:
            return "offsetUnsupported"
        @unknown default:
            return "offsetUnsupported"
        }
    }
    
    private func accessEnumToString(access: NTSensorParamAccess) -> String{
        switch(access){
        case .read:
            return "read"
        case .readWrite:
            return "readWrite"
        case .readNotify:
            return "readNotify"
        @unknown default:
            return "unsupported"
        }
    }
    
    private func stateEnumToString(state: NTSensorState) -> String{
        switch(state){
        case .inRange:
            return "inRange"
        case .outOfRange:
            return "outOfRange"
        @unknown default:
            return "unsupported"
        }
    }
    
    private func modeEnumToString(mode: NTSensorFirmwareMode) -> String{
        switch(mode){
        case .bootloader:
            return "bootloader"
        case .application:
            return "application"
        @unknown default:
            return "unsupported"
        }
    }
    
    private func sfEnumToString(sf: NTSensorSamplingFrequency) -> String{
        switch(sf){
        case .hz10:
            return "hz10"
        case .hz100:
            return "hz100"
        case .hz125:
            return "hz10"
        case .hz250:
            return "hz250"
        case .hz500:
            return "hz500"
        case .hz1000:
            return "hz1000"
        case .hz2000:
            return "hz2000"
        case .hz4000:
            return "hz4000"
        case .hz8000:
            return "hz8000"
        case .unsupported:
            return "unsupported"
        @unknown default:
            return "unsupported"
        }
    }
    
    private func gainToString(gain: NTSensorGain) -> String{
        switch(gain){
        case .gain1:
            return "gain1"
        case .gain2:
            return "gain2"
        case .gain3:
            return "gain3"
        case .gain4:
            return "gain4"
        case .gain6:
            return "gain6"
        case .gain8:
            return "gain8"
        case .gain12:
            return "gain12"
        case .gain24:
            return "gain24"
        case .gainUnsupported:
            return "unsupported"
        @unknown default:
            return "unsupported"
        }
    }
    
    private func hwFilterToString(f: NTSensorFilter) -> String {
        switch(f){
        case .hpfBwhLvl1CutoffFreq1Hz:
            return "hpfBwhLvl1CutoffFreq1Hz"
        case .hpfBwhLvl1CutoffFreq5Hz:
            return "hpfBwhLvl1CutoffFreq5Hz"
        case .bsfBwhLvl2CutoffFreq45_55Hz:
            return "bsfBwhLvl2CutoffFreq45_55Hz"
        case .bsfBwhLvl2CutoffFreq55_65Hz:
            return "bsfBwhLvl2CutoffFreq55_65Hz"
        case .hpfBwhLvl2CutoffFreq10Hz:
            return "hpfBwhLvl2CutoffFreq10Hz"
        case .lpfBwhLvl2CutoffFreq400Hz:
            return "lpfBwhLvl2CutoffFreq400Hz"
        @unknown default:
            return "unknown"
        }
    }
    
    private func commandNumberToString(number: NSNumber) -> String {
        let bindedEnum = NTSensorCommand(rawValue: number.uint8Value)
        switch(bindedEnum) {
        case .startSignal:
            return "start signal"
        case .stopSignal:
            return "stop signal"
        case .startResist:
            return "start resist"
        case .stopResist:
            return "stop resist"
        case .startMEMS:
            return "start MEMS"
        case .stopMEMS:
            return "stop MEMS"
        case .startRespiration:
            return "start respiration"
        case .stopRespiration:
            return "stop respiration"
        case .startCurrentStimulation:
            return "start current stimulation"
        case .stopCurrentStimulation:
            return "stop current stimulation"
        case .enableMotionAssistant:
            return "enable motion assistant"
        case .disableMotionAssistant:
            return "disable motion assistant"
        case .findMe:
            return "find me"
        case .startAngle:
            return "start angle"
        case .stopAngle:
            return "stop angle"
        case .calibrateMEMS:
            return "calibrate MEMS"
        case .resetQuaternion:
            return "reset quaternion"
        case .startEnvelope:
            return "start envelope"
        case .stopEnvelope:
            return "stop envelope"
        case .resetMotionCounter:
            return "reset motion counter"
        case .calibrateStimulation:
            return "calibrate stimulation"
        case .idle:
            return "idle"
        case .powerDown:
            return "power down"
        case .startFPG:
            return "start FPG"
        case .stopFPG:
            return "stop FPG"
        case .startSignalAndResist:
            return "start signal and resist"
        case .stopSignalAndResist:
            return "stop signal and resist"
        case .startPhotoStimulation:
            return "start photo stimulation"
        case .stopPhotoStimulation:
            return "stop photo stimulation"
        case .startAcousticStimulation:
            return "start acoustic stimulation"
        case .stopAcousticStimulation:
            return "stop acoustic stimulation"
        @unknown default:
            return "unsupported"
        
        }
    }
    
    private func featureNumberToString(number: NSNumber) -> String {
        let bindedEnum = NTSensorFeature(rawValue: number.uint8Value)
        switch(bindedEnum) {
        case .signal:
            return "signal"
        case .MEMS:
            return "MEMS"
        case .currentStimulator:
            return "current stimulator"
        case .respiration:
            return "respiration"
        case .resist:
            return "resist"
        case .FPG:
            return "FPG"
        case .envelope:
            return "envelope"
        case .photoStimulator:
            return "photo stimulator"
        case .acousticStimulator:
            return "acoustic stimulator"
        @unknown default:
            return "unsupported"
        }
    }
    
    private func paramEnumToString(param: NTSensorParameter) -> String{
        switch(param){
        case .name:
            return "name";
        case .state:
            return "state";
        case .address:
            return "address";
        case .serialNumber:
            return "serialNumber";
        case .firmwareMode:
            return "firmwareMode";
        case .samplingFrequency:
            return "samplingFrequency";
        case .gain:
            return "gain";
        case .offset:
            return "offset";
        case .firmwareVersion:
            return "firmwareVersion";
        case .battPower:
            return "battPower";
        case .sensorFamily:
            return "sensorFamily";
        case .sensorMode:
            return "sensorMode";
        case .hardwareFilterState:
            return "hardwareFilterState";
        case .externalSwitchState:
            return "externalSwitchState";
        case .adcInputState:
            return "adcInputState";
        case .accelerometerSens:
            return "accelerometerSens";
        case .gyroscopeSens:
            return "gyroscopeSens";
        case .stimulatorAndMAState:
            return "stimulatorAndMAState";
        case .stimulatorParamPack:
            return "stimulatorParamPack";
        case .motionAssistantParamPack:
            return "motionAssistantParamPack";
        case .memsCalibrationStatus:
            return "memsCalibrationStatus";
        case .motionCounterParamPack:
            return "motionCounterParamPack";
        case .envelopeDecimation:
            return "envelopeDecimation";
        case .samplingFrequencyMEMS:
            return "samplingFrequencyMEMS";
        case .sensorChannels:
            return "sensorChannels";
        case .motionCounter, .amplifier, .irAmplitude, .redAmplitude, .samplingFrequencyResist, .samplingFrequencyFPG, .envelopeAvgWndSz:
            return "unsupported";
        @unknown default:
            return "unsupported";
        }
    }
    
    public var samplingFrequency: Int {
        get{
            var sf: Int = 0
            switch(sensor?.samplingFrequency)
            {
            case .some(.hz10):
                sf = 10
                break
            case .none:
                sf = 0
            case .some(.hz100):
                sf = 100
            case .some(.hz125):
                sf = 125
            case .some(.hz250):
                sf = 250
            case .some(.hz500):
                sf = 500
            case .some(.hz1000):
                sf = 1000
            case .some(.hz2000):
                sf = 2000
            case .some(.hz4000):
                sf = 4000
            case .some(.hz8000):
                sf = 8000
            case .some(.unsupported):
                sf = 0
            case .some(_):
                sf = 0
            }
            
            return sf
        }
    }
    
// MARK: - Signal
    func startSignal(signalRecieved: @escaping SignalDataCallback){
        sensor?.setSignalCallback(signalRecieved)
        
        executeCommand(command: NTSensorCommand.startSignal)
    }
    
    func stopSignal(){
        sensor?.setSignalCallback(nil)
        
        executeCommand(command: NTSensorCommand.stopSignal)
    }
    
    func setSignalType(signalType: UInt8){
        sensor?.signalTypeCallibri = NTCallibriSignalType(rawValue: signalType) ?? .ECG
    }
// MARK: - Envelope
    func startEnv(envelopeRecieved: @escaping (_ data: [NTCallibriEnvelopeData]) -> Void){
        sensor?.setEnvelopeDataCallback(envelopeRecieved)
        
        executeCommand(command: NTSensorCommand.startEnvelope)
    }
    
    func stopEnv(){
        sensor?.setEnvelopeDataCallback(nil)
        
        executeCommand(command: NTSensorCommand.stopEnvelope)
    }
    
// MARK: - Utils
    func executeCommand(command: NTSensorCommand){
        DispatchQueue.global(qos: .userInitiated).async { [self] in
            do {
                try ObjcEx.catchException {
                    self.sensor?.execCommand(command)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }
    }
    
}
