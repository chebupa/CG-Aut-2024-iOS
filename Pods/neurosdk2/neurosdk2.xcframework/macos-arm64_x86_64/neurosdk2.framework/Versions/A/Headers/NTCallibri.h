#ifndef NTCallibri_h
#define NTCallibri_h

#include "NTSensor.h"

@interface NTCallibri : NTSensor

@property (NS_NONATOMIC_IOSONLY, copy) NSArray<NSNumber *>*_Nullable  HardwareFilters;
@property (NS_NONATOMIC_IOSONLY) NTSensorExternalSwitchInput ExtSwInput;
@property (NS_NONATOMIC_IOSONLY) NTSensorADCInput ADCInput;
@property (NS_NONATOMIC_IOSONLY) NTSensorAccelerometerSensitivity AccSens;
@property (NS_NONATOMIC_IOSONLY) NTSensorGyroscopeSensitivity GyroSens;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorSamplingFrequency SamplingFrequencyMEMS;
@property (NS_NONATOMIC_IOSONLY, readonly) NTCallibriStimulatorMAState* _Nullable  StimulatorMAStateCallibri;
@property (NS_NONATOMIC_IOSONLY) NTCallibriStimulationParams* _Nullable  StimulatorParamCallibri;
@property (NS_NONATOMIC_IOSONLY) NTCallibriMotionAssistantParams* _Nullable  MotionAssistantParamCallibri;
@property (NS_NONATOMIC_IOSONLY) NTCallibriMotionCounterParam* _Nullable  MotionCounterParamCallibri;
@property (NS_NONATOMIC_IOSONLY, readonly) uint  MotionCounterCallibri;
@property (NS_NONATOMIC_IOSONLY, readonly) NTCallibriColorType  ColorCallibri;
@property (NS_NONATOMIC_IOSONLY) NTCallibriSignalType SignalTypeCallibri;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorSamplingFrequency SamplingFrequencyResp;
@property (NS_NONATOMIC_IOSONLY, readonly) bool MEMCalibrateState;

@property (NS_NONATOMIC_IOSONLY, readwrite) NTSensorSamplingFrequency SamplingFrequency;
@property (NS_NONATOMIC_IOSONLY, readwrite) NTSensorGain Gain;
@property (NS_NONATOMIC_IOSONLY, readwrite) NTSensorDataOffset DataOffset;
@property (NS_NONATOMIC_IOSONLY, readwrite) NTSensorFirmwareMode FirmwareMode;

- (void) setMEMSDataCallback:(void (^_Nullable)(NSArray<NTMEMSData*>*_Nonnull))callback;            // mems
- (void) setQuaternionDataCallback:(void (^_Nullable)(NSArray<NTQuaternionData*>*_Nonnull))callback;        // callibri

- (void) setSignalCallbackCallibri:(void (^_Nullable)(NSArray<NTCallibriSignalData*>*_Nonnull))callback;
- (void) setRespirationCallbackCallibri:(void (^_Nullable)(NSArray<NTCallibriRespirationData*>*_Nonnull))callback;
- (void) setElectrodeStateCallbackCallibri:(void (^_Nullable)(NTCallibriElectrodeState))callback;
- (void) setEnvelopeDataCallbackCallibri:(void (^_Nullable)(NSArray<NTCallibriEnvelopeData*>*_Nonnull))callback;

@end
#endif /* NTCallibri_h */
