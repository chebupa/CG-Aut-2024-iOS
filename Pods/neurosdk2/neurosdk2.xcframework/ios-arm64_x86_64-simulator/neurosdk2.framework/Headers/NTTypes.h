//
//  NTTypes.h
//  neurosdk
//
//  Created by Aseatari on 29.08.2022.
//

#ifndef NTTypes_h
#define NTTypes_h

@interface NTOpStatus
@end

typedef NS_ENUM (UInt8, NTSensorFamily) {
    NTSensorFamilyUnknown =0,

    NTSensorFamilyLECallibri = 1,
    NTSensorFamilyLEKolibri = 2,


    NTSensorFamilyLEBrainBit =3,


    NTSensorFamilyLEBrainBitBlack =4,


 
    NTSensorFamilyLESmartLeg =7,
    NTSensorFamilyLENeurro =8,
    NTSensorFamilyLEP300= 9,
    NTSensorFamilyLEImpulse=10,

    NTSensorFamilyLEEarBuds=12,

};


@interface NTSensorVersion : NSObject
@property (nonatomic) UInt32 FwMajor;
@property (nonatomic) UInt32 FwMinor;
@property (nonatomic) UInt32 FwPatch;

@property (nonatomic) UInt32 HwMajor;
@property (nonatomic) UInt32 HwMinor;
@property (nonatomic) UInt32 HwPatch;

@property (nonatomic, readonly) UInt32 ExtMajor;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
@interface NTSensorInfo : NSObject
@property (nonatomic) enum NTSensorFamily SensFamily;
@property (nonatomic) UInt8 SensModel;
@property (nonatomic, copy) NSString *_Nonnull Name;
@property (nonatomic, copy) NSString *_Nonnull Address;
@property (nonatomic, copy) NSString *_Nonnull SerialNumber;
@property (nonatomic) BOOL PairingRequared;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithSensFamily:(enum NTSensorFamily)sensFamily sensModel:(UInt8)sensModel name:(NSString *_Nonnull)name address:(NSString *_Nonnull)address serialNumber:(NSString *_Nonnull)serialNumber pairingRequared:(BOOL)pairingRequared NS_DESIGNATED_INITIALIZER;

@end

typedef NS_ENUM (UInt8, NTSensorFeature)
{
    NTSensorFeatureSignal,
    NTSensorFeatureMEMS,
    NTSensorFeatureCurrentStimulator,
    NTSensorFeatureRespiration,
    NTSensorFeatureResist,
    NTSensorFeatureFPG,
    NTSensorFeatureEnvelope,
    NTSensorFeaturePhotoStimulator,
    NTSensorFeatureAcousticStimulator
};

typedef NS_ENUM (UInt8, NTSensorFirmwareMode){
    NTSensorFirmwareModeBootloader,
    NTSensorFirmwareModeApplication
};

typedef NS_ENUM (UInt8, NTSensorCommand)
{
    NTSensorCommandStartSignal,
    NTSensorCommandStopSignal,
    NTSensorCommandStartResist,
    NTSensorCommandStopResist,
    NTSensorCommandStartMEMS,
    NTSensorCommandStopMEMS,
    NTSensorCommandStartRespiration,
    NTSensorCommandStopRespiration,
    NTSensorCommandStartCurrentStimulation,
    NTSensorCommandStopCurrentStimulation,
    NTSensorCommandEnableMotionAssistant,
    NTSensorCommandDisableMotionAssistant,
    NTSensorCommandFindMe,
    NTSensorCommandStartAngle,
    NTSensorCommandStopAngle,
    NTSensorCommandCalibrateMEMS,
    NTSensorCommandResetQuaternion,
    NTSensorCommandStartEnvelope,
    NTSensorCommandStopEnvelope,
    NTSensorCommandResetMotionCounter,
    NTSensorCommandCalibrateStimulation,
    NTSensorCommandIdle,
    NTSensorCommandPowerDown,
    NTSensorCommandStartFPG,
    NTSensorCommandStopFPG,
    NTSensorCommandStartSignalAndResist,
    NTSensorCommandStopSignalAndResist,
    NTSensorCommandStartPhotoStimulation,
    NTSensorCommandStopPhotoStimulation,
    NTSensorCommandStartAcousticStimulation,
    NTSensorCommandStopAcousticStimulation
};

typedef NS_ENUM (UInt8, NTSensorParameter) {
    NTSensorParameterName,
    NTSensorParameterState,
    NTSensorParameterAddress,
    NTSensorParameterSerialNumber,
    NTSensorParameterHardwareFilterState,
    NTSensorParameterFirmwareMode,
    NTSensorParameterSamplingFrequency,
    NTSensorParameterGain,
    NTSensorParameterOffset,
    NTSensorParameterExternalSwitchState,
    NTSensorParameterADCInputState,
    NTSensorParameterAccelerometerSens,
    NTSensorParameterGyroscopeSens,
    NTSensorParameterStimulatorAndMAState,
    NTSensorParameterStimulatorParamPack,
    NTSensorParameterMotionAssistantParamPack,
    NTSensorParameterFirmwareVersion,
    NTSensorParameterMEMSCalibrationStatus,
    NTSensorParameterMotionCounterParamPack,
    NTSensorParameterMotionCounter,
    NTSensorParameterBattPower,
    NTSensorParameterSensorFamily,
    NTSensorParameterSensorMode,
    NTSensorParameterIrAmplitude,
    NTSensorParameterRedAmplitude,
    NTSensorParameterEnvelopeAvgWndSz,
    NTSensorParameterEnvelopeDecimation,
    NTSensorParameterSamplingFrequencyResist,
    NTSensorParameterSamplingFrequencyMEMS,
    NTSensorParameterSamplingFrequencyFPG,
    NTSensorParameterAmplifier,
    NTSensorParameterSensorChannels
};

typedef NS_ENUM (UInt8, NTSensorParamAccess) {
    NTSensorParamAccessRead,
    NTSensorParamAccessReadWrite,
    NTSensorParamAccessReadNotify
};

@interface NTParameterInfo : NSObject
@property (nonatomic) enum NTSensorParameter Param;
@property (nonatomic) enum NTSensorParamAccess ParamAccess;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

typedef NS_ENUM (UInt8, NTSensorState) {
    NTSensorStateInRange,
    NTSensorStateOutOfRange
};

typedef NS_ENUM (UInt8, NTSensorFilter) {
    NTSensorFilterHPFBwhLvl1CutoffFreq1Hz,
    NTSensorFilterHPFBwhLvl1CutoffFreq5Hz,
    NTSensorFilterBSFBwhLvl2CutoffFreq45_55Hz,
    NTSensorFilterBSFBwhLvl2CutoffFreq55_65Hz,
    NTSensorFilterHPFBwhLvl2CutoffFreq10Hz,
    NTSensorFilterLPFBwhLvl2CutoffFreq400Hz,
};

typedef NS_ENUM (UInt8, NTSensorSamplingFrequency) {
    NTSensorSamplingFrequencyHz10,
    NTSensorSamplingFrequencyHz100,
    NTSensorSamplingFrequencyHz125,
    NTSensorSamplingFrequencyHz250,
    NTSensorSamplingFrequencyHz500,
    NTSensorSamplingFrequencyHz1000,
    NTSensorSamplingFrequencyHz2000,
    NTSensorSamplingFrequencyHz4000,
    NTSensorSamplingFrequencyHz8000,
    NTSensorSamplingFrequencyUnsupported
};

typedef NS_ENUM (UInt8, NTSensorGain){
    NTSensorGain1,
    NTSensorGain2,
    NTSensorGain3,
    NTSensorGain4,
    NTSensorGain6,
    NTSensorGain8,
    NTSensorGain12,
    NTSensorGain24,
    NTSensorGainUnsupported
};

typedef NS_ENUM (UInt8, NTSensorDataOffset) {
    NTSensorDataOffset0 = 0x00,
    NTSensorDataOffset1 = 0x01,
    NTSensorDataOffset2 = 0x02,
    NTSensorDataOffset3 = 0x03,
    NTSensorDataOffset4 = 0x04,
    NTSensorDataOffset5 = 0x05,
    NTSensorDataOffset6 = 0x06,
    NTSensorDataOffset7 = 0x07,
    NTSensorDataOffset8 = 0x08,
    NTSensorDataOffsetUnsupported = 0xFF
};

typedef NS_ENUM (UInt8, NTSensorExternalSwitchInput) {
    NTSensorExternalSwitchInputMioElectrodesRespUSB,
    NTSensorExternalSwitchInputMioElectrodes,
    NTSensorExternalSwitchInputMioUSB,
    NTSensorExternalSwitchInputRespUSB
};

typedef NS_ENUM (UInt8, NTSensorADCInput) {
    NTSensorADCInputElectrodes,
    NTSensorADCInputShort,
    NTSensorADCInputTest,
    NTSensorADCInputResistance
};


typedef NS_ENUM (UInt8, NTSensorAccelerometerSensitivity) {
    NTSensorAccelerometerSensitivity2g,
    NTSensorAccelerometerSensitivity4g,
    NTSensorAccelerometerSensitivity8g,
    NTSensorAccelerometerSensitivity16g,
    NTSensorAccelerometerSensitivityUnsupported
};

typedef NS_ENUM (UInt8, NTSensorGyroscopeSensitivity) {
    NTSensorGyroscopeSensitivity250Grad,
    NTSensorGyroscopeSensitivity500Grad,
    NTSensorGyroscopeSensitivity1000Grad,
    NTSensorGyroscopeSensitivity2000Grad,
    NTSensorGyroscopeSensitivityUnsupported
};




typedef NS_ENUM (UInt8, NTCallibriStimulatorState) {
    NTCallibriStimulatorStateNoParams = 0,
    NTCallibriStimulatorStateDisabled = 1,
    NTCallibriStimulatorStateEnabled = 2,
    NTCallibriStimulatorStateUnsupported = 0xFF
};

@interface NTCallibriStimulatorMAState : NSObject
    @property (nonatomic) enum NTCallibriStimulatorState stimulatorState;
    @property (nonatomic) enum NTCallibriStimulatorState MAState;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

/// <summary>
/// Stimulator parameters
/// Limitations:
/// (Current * Frequency * PulseWidth / 100) <= 2300 uA
/// </summary>
@interface NTCallibriStimulationParams : NSObject
    /// <summary>
    /// Stimulus amplitude in  mA. 1..100
    /// </summary>
@property (nonatomic) UInt8 Current;
    /// <summary>
    /// Duration of the stimulating pulse by us. 20..460
    /// </summary>
@property (nonatomic) UInt16 PulseWidth;
    /// <summary>
    /// Frequency of stimulation impulses by Hz. 1..200.
    /// </summary>
@property (nonatomic) UInt8 Frequency;
    /// <summary>
    /// Maximum stimulation time by ms. 0...65535.
    /// Zero is infinitely.
    /// </summary>
@property (nonatomic) UInt16 StimulusDuration;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithCurrent:(UInt8)current pulseWidth:(UInt16)pulseWidth frequency:(UInt8)frequency stimulusDuration:(UInt16)stimulusDuration NS_DESIGNATED_INITIALIZER;

@end

typedef NS_ENUM (UInt8, NTCallibriMotionAssistantLimb) {
    NTCallibriMotionAssistantLimbRightLeg = 0,
    NTCallibriMotionAssistantLimbLeftLeg = 1,
    NTCallibriMotionAssistantLimbRightArm = 2,
    NTCallibriMotionAssistantLimbLeftArm = 3,
    NTCallibriMotionAssistantLimbUnsupported = 0xFF
};

@interface NTCallibriMotionAssistantParams : NSObject
@property (nonatomic) UInt8 GyroStart;
@property (nonatomic) UInt8 GyroStop;
@property (nonatomic) enum NTCallibriMotionAssistantLimb Limb;
    /// <summary>
    /// multiple of 10. This means that the device is using the (MinPauseMs / 10) value.;
    /// Correct values: 10, 20, 30, 40 ...
    /// </summary>
@property (nonatomic) UInt8 MinPauseMs;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithGyroStart:(UInt8)gyroStart gyroStop:(UInt8)gyroStop limb:(enum NTCallibriMotionAssistantLimb)limb minPauseMs:(UInt8)minPauseMs NS_DESIGNATED_INITIALIZER;

@end

@interface NTCallibriMotionCounterParam : NSObject
    /// <summary>
    /// Insense threshold mg. 0..500
    /// </summary>
@property (nonatomic) UInt16 InsenseThresholdMG;
    /// <summary>
    /// Algorithm insense threshold in time (in samples with the MEMS sampling rate) 0..500
    /// </summary>
@property (nonatomic) UInt16 InsenseThresholdSample;

- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithInsenseThresholdMG:(UInt16)insenseThresholdMG insenseThresholdSample:(UInt16)insenseThresholdSample NS_DESIGNATED_INITIALIZER;

@end

@interface NTCallibriSignalData : NSObject
@property (nonatomic, readonly) UInt32 PackNum;
@property (nonatomic, readonly) NSArray<NSNumber*>* _Nonnull Samples;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

@interface NTCallibriRespirationData : NSObject
@property (nonatomic, readonly) UInt32 PackNum;
@property (nonatomic, readonly) NSArray<NSNumber*>* _Nonnull Samples;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

typedef NS_ENUM (UInt8, NTCallibriElectrodeState) {
    NTCallibriElectrodeStateNormal,
    NTCallibriElectrodeStateHighResistance,
    NTCallibriElectrodeStateDetached
};
@interface NTQuaternionData : NSObject
@property (nonatomic, readonly) UInt32 PackNum;
@property (nonatomic, readonly) Float32 W;
@property (nonatomic, readonly) Float32 X;
@property (nonatomic, readonly) Float32 Y;
@property (nonatomic, readonly) Float32 Z;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

@interface NTCallibriEnvelopeData : NSObject
@property (nonatomic, readonly) UInt32 PackNum;
@property (nonatomic, readonly) NSNumber*_Nonnull Sample;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end


struct Point3D {
    double X;
    double Y;
    double Z;
};


@interface NTMEMSData : NSObject
@property (nonatomic, readonly) struct Point3D Accelerometer;
@property (nonatomic, readonly) struct Point3D Gyroscope;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end



typedef NS_ENUM (UInt8, NTIrAmplitude) {
    NTIrAmplitudeIrAmp0 = 0,
    NTIrAmplitudeIrAmp14 = 1,
    NTIrAmplitudeIrAmp28 = 2,
    NTIrAmplitudeIrAmp42 = 3,
    NTIrAmplitudeIrAmp56 = 4,
    NTIrAmplitudeIrAmp70 = 5,
    NTIrAmplitudeIrAmp84 = 6,
    NTIrAmplitudeIrAmp100 = 7,
    NTIrAmplitudeIrAmpUnsupported = 0xFF
};

typedef NS_ENUM (UInt8, NTRedAmplitude) {
    NTRedAmplitudeRedAmp0 = 0,
    NTRedAmplitudeRedAmp14 = 1,
    NTRedAmplitudeRedAmp28 = 2,
    NTRedAmplitudeRedAmp42 = 3,
    NTRedAmplitudeRedAmp56 = 4,
    NTRedAmplitudeRedAmp70 = 5,
    NTRedAmplitudeRedAmp84 = 6,
    NTRedAmplitudeRedAmp100 = 7,
    NTRedAmplitudeRedAmpUnsupported = 0xFF
};

@interface NTBrainBitSignalData : NSObject

@property (nonatomic, readonly) UInt32 PackNum;
@property (nonatomic, readonly) UInt8 Marker;
@property (nonatomic, readonly) NSNumber*_Nonnull O1;
@property (nonatomic, readonly) NSNumber*_Nonnull O2;
@property (nonatomic, readonly) NSNumber*_Nonnull T3;
@property (nonatomic, readonly) NSNumber*_Nonnull T4;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
@interface NTBrainBitResistData : NSObject
    @property (nonatomic, readonly) NSNumber*_Nonnull O1;
    @property (nonatomic, readonly) NSNumber*_Nonnull O2;
    @property (nonatomic, readonly) NSNumber*_Nonnull T3;
    @property (nonatomic, readonly) NSNumber*_Nonnull T4;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end



typedef NS_ENUM (UInt8, NTGenCurrent) {
    NTGenCurrentGenCurr0uA = 0,
    NTGenCurrentGenCurr6nA = 1,
    NTGenCurrentGenCurr12nA = 2,
    NTGenCurrentGenCurr18nA = 3,
    NTGenCurrentGenCurr24nA = 4,
    NTGenCurrentGenCurr6uA = 5,
    NTGenCurrentGenCurr24uA = 6,
    NTGenCurrentGenUnsupported = 0xFF
};




typedef NS_ENUM (UInt8, NTSensorAmpMode)
{
    NTSensorAmpModeInvalid,
    NTSensorAmpModePowerDown,
    NTSensorAmpModeIdle,
    NTSensorAmpModeSignal,
    NTSensorAmpModeResist,
    NTSensorAmpModeSignalResist
};


@interface NTFPGData : NSObject
@property (nonatomic, readonly) UInt32  PackNum;
@property (nonatomic, readonly) NSNumber*_Nonnull IrAmplitude;
@property (nonatomic, readonly) NSNumber*_Nonnull RedAmplitude;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end


typedef NS_ENUM (UInt8, NTCallibriColorType)
{
    NTCallibriColorTypeRed,
    NTCallibriColorTypeYellow,
    NTCallibriColorTypeBlue,
    NTCallibriColorTypeWhite,

    NTCallibriColorTypeUnknown
};

typedef NS_ENUM (UInt8, NTCallibriSignalType)
{
    NTCallibriSignalTypeEEG = 0,
    NTCallibriSignalTypeEMG = 1,
    NTCallibriSignalTypeECG = 2,
    NTCallibriSignalTypeEDA = 3,// GSR
    NTCallibriSignalTypeStrainGaugeBreathing = 4,
    NTCallibriSignalTypeImpedanceBreathing = 5,
    NTCallibriSignalTypeUnknown = 6
};



#endif /* NTTypes_h */
