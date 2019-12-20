#!/bin/sh

AneVersion="1.3.0"
FreKotlinVersion="1.9.1"
SupportV4Version="1.0.0"

wget -O android_dependencies/com.tuarua.frekotlin-$FreKotlinVersion.ane https://github.com/tuarua/Android-ANE-Dependencies/blob/master/anes/kotlin/com.tuarua.frekotlin-$FreKotlinVersion.ane?raw=true
wget -O android_dependencies/androidx.legacy.legacy-support-v4-$SupportV4Version.ane https://github.com/tuarua/Android-ANE-Dependencies/blob/master/anes/support/androidx.legacy.legacy-support-v4-$SupportV4Version.ane?raw=true
wget -O ../native_extension/ane/ShareANE.ane https://github.com/tuarua/Share-ANE/releases/download/$AneVersion/ShareANE.ane?raw=true
