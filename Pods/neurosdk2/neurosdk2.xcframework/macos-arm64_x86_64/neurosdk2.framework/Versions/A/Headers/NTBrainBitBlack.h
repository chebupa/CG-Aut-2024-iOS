#ifndef NTBrainBitBlack_h
#define NTBrainBitBlack_h

#include <Foundation/Foundation.h>
#include "NTBrainBitBlack.h"
#include "NTTypes.h"
#include "NTBrainBit.h"

@interface NTBrainBitBlack : NTBrainBit
- (instancetype _Nonnull )init NS_UNAVAILABLE;

@property (NS_NONATOMIC_IOSONLY) NTSensorAccelerometerSensitivity AccSens;
@property (NS_NONATOMIC_IOSONLY) NTSensorGyroscopeSensitivity GyroSens;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorSamplingFrequency SamplingFrequencyFPG;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorSamplingFrequency SamplingFrequencyMEMS;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorAmpMode AmpMode;
@property (NS_NONATOMIC_IOSONLY) NTIrAmplitude  IrAmplitudeHeadband;
@property (NS_NONATOMIC_IOSONLY) NTRedAmplitude RedAmplitudeHeadband;


- (void) setMEMSDataCallback:(void (^_Nullable)(NSArray<NTMEMSData*>*_Nonnull))callback;
- (void) setAmpModeCallback:(void (^_Nullable)(NTSensorAmpMode))callback;
- (void) setFPGDataCallbackNeuroSmart:(void (^_Nullable)(NSArray<NTFPGData*>*_Nonnull))callback;

-(void) PingNeuroSmart:(Byte)marker;

@end

#endif /* NTBrainBitBlack_h */


