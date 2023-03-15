#!/bin/bash 
set -euo pipefail
IFS=$'\n\t'

# Install dependencies
if [[ -f /usr/bin/pacman  && ! -f {/usr/bin/wget,/usr/bin/unzip,/usr/bin/git} ]]
then
  sudo pacman -S wget unzip git
elif [[ -f /usr/bin/emerge && ! -f {/usr/bin/wget,/usr/bin/unzip,/usr/bin/git} ]]
then
  sudo emerge -av wget unzip git
elif [[ -f /usr/bin/apt && ! {/usr/bin/wget,/usr/bin/unzip,/usr/bin/git} ]]
then
   sudo apt-get install wget unzip git
elif [[ -d /nix ]]
then
  nix-shell -p wget unzip git
elif [[ -f /usr/bin/dnf && ! -f {/usr/bin/wget,/usr/bin/unzip,/usr/bin/git} ]]
then
  sudo dnf install wget unzip git
else
  readf "Please install the following packages using your package manager:\n curl\n wget\n unzip\n git\n"
  exit
fi

# Make temp directory
cd "$(mktemp -d)" || exit 1

# Get the latest release of SFP and unzip it
mkdir SFP 
cd SFP || exit 1
wget https://github.com/PhantomGamers/SFP/releases/download/0.0.14/SFP_UI-SelfContained-linux-x64.zip
unzip *.zip
chmod +x SFP_UI
./SFP_UI 

# Install metro
if [ -d ~/.steam ]
then
  mkdir -p ~/.steam/steam/skins/
  git clone https://github.com/minischetti/metro-for-steam ~/.steam/steam/skins/catppuccin
  export install_path="$HOME/.steam/steam/skins/catppuccin"
elif [ -d ~/.var/app/com.valvesoftware.Steam ]
then
  mkdir -p ~/.var/app/com.valvesoftware.Steam/.steam/steam/skins
  git clone https://github.com/minischetti/metro-for-steam ~/.var/app/com.valvesoftware.Steam/.steam/steam/skins/catppuccin
  export install_path="$HOME/.var/app/com.valvesoftware.Steam/.steam/steam/skins/catppuccin"
else
  echo "Sorry, i couldn't find your steam installation"
  echo "Please paste the path to '.steam' below"
  read -f -p "--> " steampath
  mkdir "$steampath/steam/skins/catppuccin"
  git clone https://github.com/minischetti/metro-for-steam "$steampath/steam/skins/catppuccin"
  export install_path="$steampath/steam/skins/catppuccin"
fi
 
# Install the metro patch
cd ../ 
mkdir UPMetro
cd UPMetro || exit 1
git clone https://github.com/redsigma/UPMetroSkin ./UPMetroSkin
cp -r UPMetroSkin/'Unofficial 4.x patch'/'Main Files'/* "$install_path"
cd ../ 

# Finally install the catppuccin flavor of the users choosing
git clone https://github.com/catppuccin/steam.git
cd steam || exit 1
printf "Which flavor would you like to install?\n 1) mocha\n 2) frappe\n 3) latte\n 4) macchiato"  
read -r -p "--> " flavor
cp -r "themes/$flavor/"* "$install_path"

# Little thank you message to the installer
echo "Thank you for installing catppuccin ${flavor} for steam :3"

