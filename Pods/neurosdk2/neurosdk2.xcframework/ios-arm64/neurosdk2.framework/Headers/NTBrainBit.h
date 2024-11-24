#ifndef NTBrainBit_h
#define NTBrainBit_h

#import <Foundation/Foundation.h>
#import "NTTypes.h"
#include "NTSensor.h"

@interface NTBrainBit : NTSensor
- (instancetype)init NS_UNAVAILABLE;

- (void) setResistCallbackBrainBit:(void (^_Nullable)(NTBrainBitResistData*_Nonnull))callback;
- (void) setSignalDataCallbackBrainBit:(void (^_Nullable)(NSArray<NTBrainBitSignalData*>*_Nonnull))callback;

@end

#endif /* NTBrainBit_h */
