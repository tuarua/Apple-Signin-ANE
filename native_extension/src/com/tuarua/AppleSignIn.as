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

package com.tuarua {
import com.tuarua.fre.ANEError;
import com.tuarua.utils.os;

import flash.events.EventDispatcher;

public class AppleSignIn extends EventDispatcher {
    private static var _shared:AppleSignIn;

    /** @private */
    public function AppleSignIn() {
        if (_shared) {
            throw new Error(AppleSignInANEContext.NAME + " is a singleton, use .appleSignIn");
        }
        if (AppleSignInANEContext.context) {
            var ret:* = AppleSignInANEContext.context.call("init");
            if (ret is ANEError) throw ret as ANEError;
        }
        _shared = this;
    }

    /**
     * Starts the authorization flow.
     *
     * @param requestedScopes The contact information to be requested from the user during authentication.
     */
    public function signIn(requestedScopes:Vector.<String> = null):void {
        if (!isSupported) return;
        AppleSignInANEContext.context.call("signIn", requestedScopes);
    }

    /**
     * Returns the credential state for the given user in a completion handler.
     *
     * @param forUserID An opaque string associated with the Apple ID that your app receives in the credential’s user
     * property after performing a successful authentication request.
     * @param listener A block the method calls to report the state and an optional error condition.
     */
    public function getCredentialState(forUserID:String, listener:Function):void {
        if (!isSupported) return;
        AppleSignInANEContext.context.call("getCredentialState", forUserID,
                AppleSignInANEContext.createCallback(listener));
    }

    /** The ANE instance. */
    public static function shared():AppleSignIn {
        if (!_shared) {
            new AppleSignIn();
        }
        return _shared;
    }

    /**
     * Returns whether Apple Sign In is supported on the OS and version
     */
    public static function get isSupported():Boolean {
        if (os.isIos && os.majorVersion >= 13) return true;
        if (os.isTvos && os.majorVersion >= 13) return true;
        if (os.isMacos && (os.majorVersion >= 11 || (os.majorVersion == 10 && os.minorVersion >= 15))) return true;
        trace("Apple Sign In is iOS13+, macOS10.15+, tvOS13+ only");
        return false;
    }

    /** Disposes the ANE */
    public static function dispose():void {
        if (AppleSignInANEContext.context) {
            AppleSignInANEContext.dispose();
        }
    }

}
}
