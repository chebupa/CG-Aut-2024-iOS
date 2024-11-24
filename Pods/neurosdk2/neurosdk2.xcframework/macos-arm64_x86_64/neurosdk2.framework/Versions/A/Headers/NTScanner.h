#import <Foundation/Foundation.h>
#import "NTTypes.h"
#import "NTSensor.h"

NS_ASSUME_NONNULL_BEGIN

@interface NTScanner : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (nullable instancetype)initWithSensorFamily:(NSArray*) filters NS_DESIGNATED_INITIALIZER;

/// @description Add subcriber when device found
/// @remark Pass nil to unsubcribe
- (void) startScan;
- (void) stopScan;
- (void) setSensorsCallback:(void (^_Nullable)(NSArray<NTSensorInfo *> *))callback;
- (NTSensor*) createSensor:( NTSensorInfo* _Nonnull )sensorInfo;

@property (NS_NONATOMIC_IOSONLY, readonly, copy) NSArray<NTSensorInfo *> *_Nullable sensors;
@end

NS_ASSUME_NONNULL_END
