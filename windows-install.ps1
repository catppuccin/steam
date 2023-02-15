#Requires -RunAsAdministrator

MD C:\tmp
CD C:\tmp
$sfpsource = 'https://github.com/PhantomGamers/SFP/releases/download/0.0.14/SFP_UI-SelfContained-win10-x64.zip'
$sfpdestination = 'C:\tmp\sfp_ui.zip'
Invoke-WebRequest -Uri $sfpsource -OutFile $sfpdestination
Expand-Archive -Path sfp_ui.zip -DestinationPath C:\tmp
.\SFP_UI.exe
$metrosource = 'https://github.com/minischetti/metro-for-steam/archive/refs/tags/v4.4.zip'
$metrodestination = 'C:\tmp\metro.zip'
Invoke-WebRequest -Uri $metrosource -OutFile $metrodestination
MD C:\tmp\METRO
Expand-Archive -Path metro.zip -OutFile 'C:\tmp'
MD C:\Program Files\Steam\skins\metro
CD C:\tmp\metro-for-steam-4.4
Copy-Item -Path 'C:\tmp\METRO\metro-for-steam-4.4\*' -Destination 'C:\Program Files\Steam\skins\metro' -Recurse
$patchsource = 'https://github.com/redsigma/UPMetroSkin/archive/refs/tags/9.1.44.zip'
$patchdestination = 'C:\tmp\9.1.44.zip'
Invoke-WebRequest -Uri $patchsource -OutFile $patchdestination
MD C:\tmp\patch
Expand-Archive -Path 9.1.44.zip -OutFile 'C:\tmp\patch'
CD 'patch\UPMetroSkin-9.1.44\Unofficial 4.x Patch\Main Files [Install First]'
Copy-Item -Path "C:\tmp\patch\UPMetroSkin-9.1.44\Unofficial 4.x Patch\Main Files [Install First]\*" -Destination 'C:\Program Files\Steam\skins\metro' -Recurse
CD C:\tmp
MD C:\tmp\catppuccin
CD catppuccin
$testchoco = powershell choco -v
if(-not($testchoco)){
    Write-Output "Seems Chocolatey is not installed, installing now"
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    choco install git
    git clone https://github.com/catppuccin/steam
    cd steam\themes
    $Flavor = Read-Host -Prompt "Please type one of the following (CASE SENSITIVE): frappe, latte, macchiato, mocha"
    Copy-Item -Path $Flavor -Destination 'C:\Program Files\Steam\skins\metro' -Recurse
}
else{
    choco install git
    git clone https://github.com/catppuccin/steam
    cd steam\themes
    $Flavor = Read-Host -Prompt "Please type one of the following (CASE SENSITIVE): frappe, latte, macchiato, mocha"
    Copy-Item -Path $Flavor -Destination 'C:\Program Files\Steam\skins\metro' -Recurse
}
CD C:\
Remove-Item 'C:\tmp' -Recurse
exit
