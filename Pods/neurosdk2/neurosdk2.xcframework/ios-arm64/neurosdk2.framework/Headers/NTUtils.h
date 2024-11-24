//
//  NTUtils.h
//  neurosdk
//
//  Created by Aseatari on 06.09.2022.
//

#ifndef NTUtils_h
#define NTUtils_h

#include "NTTypes.h"

extern "C" {
    #include "cmn_type.h"
}

@interface NTUtils : NSObject

+ (void) raise_exception_if: (OpStatus) opStatus;

@end

#endif /* NTUtils_h */
