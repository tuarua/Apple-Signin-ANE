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
public final class UserDetectionStatus {
    /** Not supported on current platform, ignore the value */
    public static const unsupported:int = 0;
    /** We could not determine the value.  New users in the ecosystem will get this value as well, so you should
     * not blacklist but instead treat these users as any new user through standard email sign up flows
     * */
    public static const unknown:int = 1;
    /** A hint that we have high confidence that the user is real. */
    public static const likelyReal:int = 2;
}
}
