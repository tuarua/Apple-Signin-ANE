# Apple-Signin-ANE 

Apple Sign In Adobe Air Native Extension for macOS 10.15+, iOS 13.0+ and tvOS 13.0+

-------------

## iOS

### The ANE + Dependencies

N.B. You must use a Mac to build an iOS app using this ANE. Windows is NOT supported.

From Terminal cd into /example-mobile and run:

```shell
bash get_ios_dependencies.sh
```
This folder, ios_dependencies/device/Frameworks, must be packaged as part of your app when creating the ipa. How this is done will depend on the IDE you are using.
After the ipa is created unzip it and confirm there is a "Frameworks" folder in the root of the .app package.

### App Setup

Set up your app with [Apple Sign in](https://help.apple.com/developer-account/?lang=en#/devde676e696).

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

From Terminal cd into /example-tvos and run:

```shell
bash get_tvos_dependencies.sh
```

This folder, tvos_dependencies/device/Frameworks, must be packaged as part of your app when creating the ipa. How this is done will depend on the IDE you are using.
After the ipa is created unzip it and confirm there is a "Frameworks" folder in the root of the .app package.


### App Setup

As per iOS above.


## macOS

### The ANE + Dependencies

From Terminal cd into /example-desktop and run:

```shell
bash get_dependencies.sh
```

### App Setup

Set up your app with [Apple Sign in](https://help.apple.com/developer-account/?lang=en#/devde676e696).

### Building the App

Even to run locally, Apple Sign In requires you to build a captive runtime release (.app) and sign it. This should be done with a Mac Developer Certificate and Provisioning Profile.

Open */example-desktop/packaging/sign.sh* and modify the values at the top of the file to your own.

Copy your .provisionprofile into */example-desktop/packaging* and rename as *MacDeveloper.provisionprofile*

From the command line cd into */example-desktop/packaging* and run:

```shell
bash /full/path/to/Apple-Signin-ANE/example-desktop/packaging/sign.sh
```

#### Mac App Store and self distributed apps
Apple Sign In is **ONLY SUPPORTED** in apps which are distributed in the App Store.
 
See [Supported capabilities (macOS)](https://help.apple.com/developer-account/#/devadf555df9)

A bash script is provided to create a signed pkg ready for the App Store. Follow the same steps as above with your 3rd Party Mac Developer Certificate and Provisioning Profile.

```shell
bash /full/path/to/Apple-Signin-ANE/example-desktop/packaging/sign_store.sh
```

### Prerequisites

* a Mac. Windows is not supported
* IntelliJ IDEA
* AIR 33.0.2.338+
* Xcode 11.3
* [wget](http://rudix.org/packages/wget.html) on macOS
