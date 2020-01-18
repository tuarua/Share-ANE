$AneVersion = "1.3.0"
$FreKotlinVersion = "1.9.5"
$SupportV4Version = "1.0.0"

$currentDir = (Get-Item -Path ".\" -Verbose).FullName
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri https://github.com/tuarua/Share-ANE/releases/download/$AneVersion/ShareANE.ane?raw=true -OutFile "$currentDir\..\native_extension\ane\ShareANE.ane"
Invoke-WebRequest -OutFile "$currentDir\android_dependencies\androidx.legacy.legacy-support-v4-$SupportV4Version.ane" -Uri https://github.com/tuarua/Android-ANE-Dependencies/blob/master/anes/support/androidx.legacy.legacy-support-v4-$SupportV4Version.ane?raw=true
Invoke-WebRequest -OutFile "$currentDir\android_dependencies\com.tuarua.frekotlin-$FreKotlinVersion.ane" -Uri https://github.com/tuarua/Android-ANE-Dependencies/blob/master/anes/kotlin/com.tuarua.frekotlin-$FreKotlinVersion.ane?raw=true