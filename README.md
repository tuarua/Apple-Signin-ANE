# Apple-Signin-ANE 

Apple Sign In Adobe Air Native Extension for macOS 10.15+, iOS 13.0+ and tvOS 13.0+

-------------

## iOS

### The ANE + Dependencies

N.B. You must use a Mac to build an iOS app using this ANE. Windows is NOT supported.

From the command line cd into /example-mobile and run:

```shell
bash get_ios_dependencies.sh
```
This folder, ios_dependencies/device/Frameworks, must be packaged as part of your app when creating the ipa. How this is done will depend on the IDE you are using.
After the ipa is created unzip it and confirm there is a "Frameworks" folder in the root of the .app package.

### App Setup

Set up your app with [Apple Sign in](https://help.apple.com/developer-account/?lang=en#/devde676e696)

You will also need to include the following in your app manifest. Update accordingly.

Update XXXXXXXX with your Apple team identifier

```xml
<Entitlements>
    <![CDATA[
    <key>com.apple.developer.applesignin</key>
    <array>
        <string>Default</string>
    </array>
    <key>com.apple.developer.team-identifier</key>
    <string>XXXXXXXX</string>
    ]]>
</Entitlements>
```

## tvOS

### The ANE + Dependencies

N.B. You must use a Mac to build an tvOS app using this ANE. Windows is NOT supported.

From the command line cd into /example-tvos and run:

```shell
bash get_tvos_dependencies.sh
```

This folder, tvos_dependencies/device/Frameworks, must be packaged as part of your app when creating the ipa. How this is done will depend on the IDE you are using.
After the ipa is created unzip it and confirm there is a "Frameworks" folder in the root of the .app package.


### App Setup

As per iOS above.


## macOS

### The ANE + Dependencies

From the command line cd into /example-desktop and run:

```shell
bash get_dependencies.sh
```

### App Setup

As per iOS above.

### Building the App

Apple Sign In requires you to build a captive runtime release (.app) and then make some modifications.

#### Remove some AIR files

Remove the following files/folders from _Main.app/_

- Contents/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/__MACOSX/
- Contents/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/WebKit.dylib
- Contents/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/WebKit/
- Contents/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/Flash Player.plugin
- Contents/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/Adobe AIR.vch

#### Update Info.plist

Add the following entries to _Contents/Info.plist_

```xml
<key>CFBundleVersion</key>
<string>1.0.0</string>
<key>CFBundleIconFile</key>
<string>AppIcon</string>
<key>CFBundleIconName</key>
<string>AppIcon</string>
```

#### Update Entitlements

Open _bin-release/Entitlements.entitlements_ and update the 2 **XXXXXXXX** with your **Apple Team Identiifer**.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>com.apple.developer.applesignin</key>
	<array>
		<string>Default</string>
	</array>
	<key>com.apple.developer.team-identifier</key>
	<string>XXXXXXXX</string>
	<key>com.apple.security.app-sandbox</key>
	<true/>
	<key>com.apple.security.files.user-selected.read-only</key>
	<true/>
	<key>com.apple.security.get-task-allow</key>
	<true/>
	<key>com.apple.application-identifier</key>
	<string>XXXXXXXX.com.tuarua.AppleSignInANE.ExampleMac</string>
</dict>
</plist>
```

#### Sign the app

Update with your Mac Developer cert signature and run in **Terminal**

```shell
codesign -f -s "[Mac Developer: Team] (XXXXXXXX)" --deep --verbose Main.app/Contents/Frameworks/*
codesign -f -s "[Mac Developer: Team] (XXXXXXXX)" --deep --verbose Main.app/Contents/Resources/*
codesign -f -s "[Mac Developer: Team] (XXXXXXXX)" --entitlements Entitlements.entitlements --verbose Main.app/Contents/MacOS/*
```

#### Run the app!

### Prerequisites

You will need:
- a Mac. Windows is not supported
- IntelliJ IDEA
- AIR 33.0.2.338+
- Xcode 11.3
- wget on macOS
