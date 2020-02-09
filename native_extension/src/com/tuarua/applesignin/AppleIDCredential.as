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
package com.tuarua.applesignin {
public class AppleIDCredential {
    /** An opaque user ID associated with the AppleID used for the sign in. This identifier will be stable across
     * the 'developer team', it can later be used as an input to @see ASAuthorizationRequest to request user
     * contact information.
     * The identifier will remain stable as long as the user is connected with the requesting client.
     * The value may change upon user disconnecting from the identity provider.
     */
    public var user:String;

    /** A copy of the state value that was passed to ASAuthorizationRequest.*/
    public var state:String;

    /** This value will contain a list of scopes for which the user provided authorization.
     * These may contain a subset of the requested scopes on @see ASAuthorizationAppleIDRequest.
     * The application should query this value to identify which scopes were returned as it maybe
     * different from ones requested.
     */
    public var authorizedScopes:Array;

    /** A short-lived, one-time valid token that provides proof of authorization to the server component of the app.
     * The authorization code is bound to the specific transaction using the state attribute passed in the
     * authorization request. The server component of the app can validate the code using Apple’s identity
     * service endpoint provided for this purpose.
     */
    public var authorizationCode:String;

    /** A JSON Web Token (JWT) used to communicate information about the identity of the user in a secure way to the
     * app. The ID token will contain the following information: Issuer Identifier, Subject Identifier, Audience,
     * Expiry Time and Issuance Time signed by Apple's identity service.*/
    public var identityToken:String;

    /** An optional email shared by the user.  This field is populated with a value that the user authorized.
     */
    public var email:String;

    /** An optional full name shared by the user.  This field is populated with a value that the user authorized.*/
    public var fullName:PersonNameComponents;


    /** @abstract Check this property for a hint as to whether the current user is a "real user".
     * see ASUserDetectionStatus for guidelines on handling each status
     */
    public var realUserStatus:int;

    public function AppleIDCredential() {
    }
}
}
