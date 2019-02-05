/* Copyright 2018 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "FreMacros.h"
#import "ShareANE_LIB.h"
#import <ShareANE_FW/ShareANE_FW.h>

#define FRE_OBJC_BRIDGE TRSHA_FlashRuntimeExtensionsBridge // use unique prefix throughout to prevent clashes with other ANEs
@interface FRE_OBJC_BRIDGE : NSObject<FreSwiftBridgeProtocol>
@end
@implementation FRE_OBJC_BRIDGE {
}
FRE_OBJC_BRIDGE_FUNCS
@end

@implementation ShareANE_LIB
SWIFT_DECL(TRSHA) // use unique prefix throughout to prevent clashes with other ANEs
CONTEXT_INIT(TRSHA) {
    SWIFT_INITS(TRSHA)
    
    /**************************************************************************/
    /******* MAKE SURE TO ADD FUNCTIONS HERE THE SAME AS SWIFT CONTROLLER *****/
    /**************************************************************************/
    
    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRSHA, init)
        ,MAP_FUNCTION(TRSHA, shareText)
        ,MAP_FUNCTION(TRSHA, shareFile)
    };
    
    /**************************************************************************/
    /**************************************************************************/
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRSHA) {
    [TRSHA_swft dispose];
    TRSHA_swft = nil;
    TRSHA_freBridge = nil;
    TRSHA_swftBridge = nil;
    TRSHA_funcArray = nil;
}
EXTENSION_INIT(TRSHA)
EXTENSION_FIN(TRSHA)
@end
