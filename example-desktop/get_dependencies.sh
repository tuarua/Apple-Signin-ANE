#!/bin/sh

AneVersion="1.2.0"
FreSwiftVersion="4.2.0"

wget -O ../native_extension/ane/FreSwift.ane https://github.com/tuarua/Swift-IOS-ANE/releases/download/$FreSwiftVersion/FreSwift.ane?raw=true
wget -O ../native_extension/ane/AppleSignInANE.ane https://github.com/tuarua/Apple-Signin-ANE/releases/download/$AneVersion/AppleSignInANE.ane?raw=true
