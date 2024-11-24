#ifndef NTSensor_h
#define NTSensor_h

#import <Foundation/Foundation.h>
#import "NTTypes.h"

NS_ASSUME_NONNULL_BEGIN

@interface NTSensor : NSObject
- (instancetype)init NS_UNAVAILABLE;

@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorFamily SensFamily;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray<NSNumber *>*_Nullable  Features;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray<NSNumber *>*_Nullable  Commands;
@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray<NTParameterInfo *>*_Nullable  Parameters;
@property (NS_NONATOMIC_IOSONLY) NSString*_Nonnull Name;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorState State;
@property (NS_NONATOMIC_IOSONLY, readonly) NSString*_Nonnull Address;
@property (NS_NONATOMIC_IOSONLY) NSString*_Nonnull SerialNumber;
@property (NS_NONATOMIC_IOSONLY, readonly) NSNumber*_Nonnull BattPower;
@property (NS_NONATOMIC_IOSONLY, readonly) NSNumber*_Nonnull ChannelsCount;

@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorSamplingFrequency SamplingFrequency;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorGain  Gain;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorDataOffset DataOffset;
@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorFirmwareMode FirmwareMode;

@property (NS_NONATOMIC_IOSONLY, readonly) NTSensorVersion*  Version;


- (void) setBatteryCallback:(void (^_Nullable)(NSNumber*_Nonnull))callback;
- (void) setConnectionStateCallback:(void (^_Nullable)(NTSensorState))callback;


-(void) Connect;
-(void) Disconnect;
-(BOOL) IsSupportedFeature:(enum NTSensorFeature)feature;
-(BOOL) IsSupportedCommand:(enum NTSensorCommand)command;
-(BOOL) IsSupportedParameter:(enum NTSensorParameter)parameter;
-(void) ExecCommand:(enum NTSensorCommand)command;

@end
NS_ASSUME_NONNULL_END


#endif /* NTSensor_h */
