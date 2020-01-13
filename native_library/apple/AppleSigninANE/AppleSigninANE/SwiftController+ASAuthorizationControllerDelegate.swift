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

import AuthenticationServices

@available(iOS 13.0, tvOS 13.0, OSX 10.15, *)
@objc extension SwiftController: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let err = error as? ASAuthorizationError {
            self.dispatchEvent(name: AppleSignInEvent.error, value: AppleSignInEvent(error: err).toJSONString())
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController,
                                        didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            self.dispatchEvent(name: AppleSignInEvent.success,
                               value: AppleSignInEvent(appleIDCredential: credential).toJSONString())
        } else if let credential = authorization.credential as? ASPasswordCredential {
            self.dispatchEvent(name: AppleSignInEvent.success,
                               value: AppleSignInEvent(passwordCredential: credential).toJSONString())
        }
    }
}
