# Share-ANE

Share text or files with this Adobe Air Native Extension for iOS 9.0+ and Android 19+.    

-------------

## Android

#### The ANE + Dependencies

cd into /example and run:
- OSX (Terminal)
```shell
bash get_android_dependencies.sh
```
- Windows Powershell
```shell
PS get_android_dependencies.ps1
```

```xml
<extensions>
<extensionID>com.tuarua.frekotlin</extensionID>
<extensionID>com.android.support.support-v4</extensionID>
<extensionID>com.tuarua.ShareANE</extensionID>
...
</extensions>
```

You will also need to include the following in your app manifest. Update accordingly.

```xml
<provider
    android:name="android.support.v4.content.FileProvider"
    android:authorities="air.[your.app.id].share_provider"
    android:exported="false"
    android:grantUriPermissions="true">
    <meta-data android:name="android.support.FILE_PROVIDER_PATHS" 
    android:resource="@xml/air_share_file_paths" />
</provider>
```

-------------

## iOS

#### The ANE + Dependencies

N.B. You must use a Mac to build an iOS app using this ANE. Windows is NOT supported.

From the command line cd into /example and run:

```shell
bash get_ios_dependencies.sh
```

This folder, ios_dependencies/device/Frameworks, must be packaged as part of your app when creating the ipa. How this is done will depend on the IDE you are using.
After the ipa is created unzip it and confirm there is a "Frameworks" folder in the root of the .app package.   

### Prerequisites

You will need:

- IntelliJ IDEA / Flash Builder
- AIR 32.0.0.103 or greater
- Android Studio 3 if you wish to edit the Android source
- Xcode 10.1
- wget on OSX
- Powershell on Windows
