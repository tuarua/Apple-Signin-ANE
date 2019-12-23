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

public class AppleSignInANE extends EventDispatcher {
    private static var _appleSignIn:AppleSignInANE;

    /** @private */
    public function AppleSignInANE() {
        if (_appleSignIn) {
            throw new Error(AppleSignInANEContext.NAME + " is a singleton, use .appleSignIn");
        }
        if (AppleSignInANEContext.context) {
            var theRet:* = AppleSignInANEContext.context.call("init");
            if (theRet is ANEError) throw theRet as ANEError;
        }
        _appleSignIn = this;
    }

    public function signIn(requestedScopes:Vector.<String> = null):void {
        if (!isSupported()) return;
        AppleSignInANEContext.context.call("signIn", requestedScopes);
    }

    public function getCredentialState(forUserID:String, listener:Function):void {
        if (!isSupported()) return;
        AppleSignInANEContext.context.call("getCredentialState", forUserID,
                AppleSignInANEContext.createEventId(listener));
    }

    /** The ANE instance. */
    public static function get appleSignIn():AppleSignInANE {
        if (!_appleSignIn) {
            new AppleSignInANE();
        }
        return _appleSignIn;
    }

    private function isSupported():Boolean {
        if (os.isIos && os.majorVersion >= 13) return true;
        if (os.isTvos && os.majorVersion >= 13) return true;
        if (os.isMacos && os.majorVersion >= 10 && os.minorVersion >= 15) return true;
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
