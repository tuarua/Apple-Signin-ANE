/* Copyright 2019 Tua Rua Ltd.
 
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

#import <Foundation/Foundation.h>
#import "FreMacros.h"
#import "AppleSignInANE_oc.h"
#ifdef OSX
#import <AppleSignInANE/AppleSignInANE-Swift.h>
#else
#import <AppleSignInANE_FW/AppleSignInANE_FW.h>
#define FRE_OBJC_BRIDGE TRASI_FlashRuntimeExtensionsBridge
@interface FRE_OBJC_BRIDGE : NSObject<FreSwiftBridgeProtocol>
@end
@implementation FRE_OBJC_BRIDGE {
}
FRE_OBJC_BRIDGE_FUNCS
@end
#endif
@implementation AppleSignInANE_LIB
SWIFT_DECL(TRASI)

CONTEXT_INIT(TRASI) {
    SWIFT_INITS(TRASI)
    
    static FRENamedFunction extensionFunctions[] =
    {
         MAP_FUNCTION(TRASI, init)
        ,MAP_FUNCTION(TRASI, getOsVersion)
        ,MAP_FUNCTION(TRASI, createGUID)
        ,MAP_FUNCTION(TRASI, signIn)
        ,MAP_FUNCTION(TRASI, getCredentialState)
    };
    
    SET_FUNCTIONS
    
}

CONTEXT_FIN(TRASI) {
    [TRASI_swft dispose];
    TRASI_swft = nil;
#ifdef OSX
#else
    TRASI_freBridge = nil;
    TRASI_swftBridge = nil;
#endif
    TRASI_funcArray = nil;
}
EXTENSION_INIT(TRASI)
EXTENSION_FIN(TRASI)
@end
