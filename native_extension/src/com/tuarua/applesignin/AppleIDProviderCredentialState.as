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
/** Authorization state of an Apple ID credential.*/
public final class AppleIDProviderCredentialState {
    /** The Opaque user ID was revoked by the user.*/
    public static const revoked:int = 0;
    /** The Opaque user ID is in good state.*/
    public static const authorized:int = 1;
    /** The Opaque user ID was not found.*/
    public static const notFound:int = 2;
}
}