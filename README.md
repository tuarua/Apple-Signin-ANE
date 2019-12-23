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


### Prerequisites

You will need:
- a Mac. Windows is not supported
- IntelliJ IDEA
- AIR 33.0.2.338+
- Xcode 11.3
- wget on macOS
