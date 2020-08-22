#!/bin/sh

AneVersion="1.5.0"
FreSwiftVersion="4.5.0"

rm -r tvos_dependencies/device
rm -r tvos_dependencies/simulator

wget https://github.com/tuarua/Swift-IOS-ANE/releases/download/$FreSwiftVersion/tvos_dependencies.zip
unzip -u -o tvos_dependencies.zip
rm tvos_dependencies.zip

wget https://github.com/tuarua/Apple-Signin-ANE/releases/download/$AneVersion/tvos_dependencies.zip
unzip -u -o tvos_dependencies.zip
rm tvos_dependencies.zip

wget -O ../native_extension/ane/AppleSignInANE.ane https://github.com/tuarua/Apple-Signin-ANE/releases/download/$AneVersion/AppleSignInANE.ane?raw=true
