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
import SwiftyJSON
import AuthenticationServices

@available(iOS 13.0, tvOS 13.0, OSX 10.15, *)
class AppleSignInEvent: NSObject {
    public static let error = "AppleSignInANE.OnError"
    public static let success = "AppleSignInANE.OnSuccess"
    public static let credentialState = "AppleSignInANE.OnCredentialState"
    var callbackId: String?
    var error: ASAuthorizationError?
    var appleIDCredential: ASAuthorizationAppleIDCredential?
    var passwordCredential: ASPasswordCredential?
    var credentialState: Int?
    convenience init(callbackId: String? = nil, error: ASAuthorizationError? = nil,
                     appleIDCredential: ASAuthorizationAppleIDCredential? = nil,
                     passwordCredential: ASPasswordCredential? = nil, credentialState: Int? = nil) {
        self.init()
        self.callbackId = callbackId
        self.error = error
        self.appleIDCredential = appleIDCredential
        self.passwordCredential = passwordCredential
        self.credentialState = credentialState
    }
    
    public func toJSONString() -> String {
        var props = [String: Any]()
        props["callbackId"] = callbackId
        props["credentialState"] = credentialState
        props["error"] = error?.toDictionary()
        props["appleIDCredential"] = appleIDCredential?.toDictionary()
        // props["passwordCredential"] = passwordCredential?.toDictionary()
        
        return JSON(props).description
    }
    
}
