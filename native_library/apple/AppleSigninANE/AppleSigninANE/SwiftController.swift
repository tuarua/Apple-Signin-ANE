/*
*  Copyright 2019 Tua Rua Ltd.
*
*  Licensed under the Apache License, Version 2.0 (the "License");
*  you may not use this file except in compliance with the License.
*  You may obtain a copy of the License at
*
*  http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing, software
*  distributed under the License is distributed on an "AS IS" BASIS,
*  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
*  See the License for the specific language governing permissions and
*  limitations under the License.
*/

import Foundation
import FreSwift
import AuthenticationServices

public class SwiftController: NSObject {
    public static var TAG: String = "SwiftController"
    public var context: FreContextSwift!
    public var functionsToSet: FREFunctionMap = [:]
    
    func createGUID(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return UUID().uuidString.toFREObject()
    }
    
    func getOsVersion(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        let os = ProcessInfo().operatingSystemVersion
        return [os.majorVersion, os.minorVersion, os.patchVersion].toFREObject()
    }
    
    func initController(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        return true.toFREObject()
    }
    
    func signIn(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard #available(iOS 13.0, OSX 10.15, tvOS 13.0, *) else {
            warning("Apple Sign In is iOS13+, macOS10.15+, tvOS13+ only")
            return nil
        }
        let request = ASAuthorizationAppleIDProvider().createRequest()
        if let requestedScopes = [ASAuthorization.Scope](argv[0]) {
            request.requestedScopes = requestedScopes
        }

        // trace("Bundle.main.bundleIdentifier", Bundle.main.bundleIdentifier ?? "unknown")
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
        return nil
    }
    
    func getCredentialState(ctx: FREContext, argc: FREArgc, argv: FREArgv) -> FREObject? {
        guard argc > 1,
            let forUserID = String(argv[0]),
            let callbackId = String(argv[1])
            else { return FreArgError().getError()
        }
        guard #available(iOS 13.0, OSX 10.15, tvOS 13.0, *) else {
            warning("Apple Sign In is iOS13+, macOS10.15+, tvOS13+ only")
            return nil
        }
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: forUserID) { (credentialState, error) in
            if let err = error as? ASAuthorizationError {
                self.dispatchEvent(name: AppleSignInEvent.credentialState,
                                   value: AppleSignInEvent(callbackId: callbackId, error: err).toJSONString())
            } else {
                self.dispatchEvent(name: AppleSignInEvent.credentialState,
                                   value: AppleSignInEvent(callbackId: callbackId,
                                                           credentialState: credentialState.rawValue).toJSONString())
            }
        }
        return nil
    }
}
