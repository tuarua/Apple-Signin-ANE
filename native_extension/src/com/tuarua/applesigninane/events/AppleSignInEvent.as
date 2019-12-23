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

package com.tuarua.applesigninane.events {
import com.tuarua.applesigninane.AppleIDCredential;

import flash.events.Event;

public class AppleSignInEvent extends Event {
    public static const SUCCESS:String = "AppleSignInANE.OnSuccess";
    public var appleIDCredential:AppleIDCredential;

    /** @private */
    public function AppleSignInEvent(type:String,
                                     appleIDCredential:AppleIDCredential = null,
                                     bubbles:Boolean = false, cancelable:Boolean = false) {
        super(type, bubbles, cancelable);
        this.appleIDCredential = appleIDCredential;
    }

    public override function clone():Event {
        return new AppleSignInEvent(type, this.appleIDCredential, bubbles, cancelable);
    }

    public override function toString():String {
        return formatToString("AppleSignInEvent", "type", "type", "bubbles", "cancelable");
    }
}
}
