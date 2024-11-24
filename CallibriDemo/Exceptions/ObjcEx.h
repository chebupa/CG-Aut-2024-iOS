#import <Foundation/Foundation.h>

@interface ObjcEx : NSObject

+ (BOOL)catchException:(void(^)(void))tryBlock error:(__autoreleasing NSError **)error;

@end
