# sudo
Start-Process wpr -verb runAs -Args "-start GeneralProfile"


# install winget
# $progressPreference = 'silentlyContinue'
# Write-Information "Downloading WinGet and its dependencies..."
# Invoke-WebRequest -Uri https://aka.ms/getwinget -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle
# Invoke-WebRequest -Uri https://aka.ms/Microsoft.VCLibs.x64.14.00.Desktop.appx -OutFile Microsoft.VCLibs.x64.14.00.Desktop.appx
# Invoke-WebRequest -Uri https://github.com/microsoft/microsoft-ui-xaml/releases/download/v2.7.3/Microsoft.UI.Xaml.2.7.x64.appx -OutFile Microsoft.UI.Xaml.2.7.x64.appx
# Add-AppxPackage Microsoft.VCLibs.x64.14.00.Desktop.appx
# Add-AppxPackage Microsoft.UI.Xaml.2.7.x64.appx
# Add-AppxPackage Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

# install toolchain
#NOTE: leave the -UseBasicParsing flag it has to be there
# wget -UseBasicParsing -OutFile "arm-gnu-toolchain-12.3.rel1-mingw-w64-i686-arm-none-eabi.exe" "https://developer.arm.com/-/media/Files/downloads/gnu/12.3.rel1/binrel/arm-gnu-toolchain-12.3.rel1-mingw-w64-i686-arm-none-eabi.exe?rev=aa6116d1af064a16bdf76e4e58ad7d9f&hash=366EA764314E1A4615E216DDBE7C437E" 
# wget -UseBasicParsing -OutFile "arm-gnu-toolchain-12.3.rel1-mingw-w64-i686-arm-none-eabi.exe" "https://developer.arm.com/-/media/Files/downloads/gnu-rm/10-2020q4/gcc-arm-none-eabi-10-2020-q4-major-win32.exe?revision=9a4bce5a-7577-4b4f-910d-4585f55d35e8&rev=9a4bce5a75774b4f910d4585f55d35e8&hash=9770A44FEA9E9CDAC0DD9A009190CC8B"
# .\gcc-arm-none-eabi-10-2020-q4-major-win32.exe
# winget install -e --id Arm.GnuArmEmbeddedToolchain
# winget install -e --id Kitware.CMake
# winget install -e --id Ninja-build.Ninja
# winget install -e --id DimitriVanHeesch.Doxygen
# winget install -e --id Python.Python.3.10
# winget install -e --id Git.Git
# winget install -e --id Microsoft.VisualStudio.2022.BuildTools
# winget install -e --id Microsoft.VisualStudioCode

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install git
choco install ninja
choco install gcc-arm-embedded
choco install mingw # contains gcc and python
choco install vscode

refreshenv # to update enviromen vars

echo running pico-setup
git clone https://github.com/agmui/sample_rm_pico_app.git || exit /b 1
cd sample_rm_pico_app
git submodule update --init --recommend-shallow 
cd rm_pico_dev
git submodule update --init --recommend-shallow 
cd lib/pico-sdk/
git submodule update --init --recommend-shallow 
setx PICO_SDK_PATH $PWD

cd ../../../

# installing vscode extensions
$json_file = Get-Content 'C:\%CD%\.vscode\extensions.json' | Out-String | ConvertFrom-Json
$json_file | Get-Member -MemberType NoteProperty | ForEach-Object {
    $key = $_.Name
    [PSCustomObject]@{Key = $key; Value = $obj."$key"}
}
code --install-extension ms-vscode.cpptools

start "" cmd /b /c code "%PICO_REPOS_PATH%" && exit 0

