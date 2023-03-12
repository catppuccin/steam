#!/bin/bash 

# Install dependencies
if [ -f /usr/bin/pacman ] 
then
  sudo pacman -S curl wget unzip git
elif [ -f /usr/bin/emerge ]
then
  sudo emerge -av curl wget unzip git
elif [ -f /usr/bin/apt ]
then
   sudo apt install curl wget unzip git
elif [ -d /nix ]
then
  sudo nix-shell -p curl wget unzip git
elif [ -f /usr/bin/dnf ]
then
  sudo dnf install curl wget unzip git
fi

# Make temp directory
cd "$(mktemp -d)" || exit 1

# Get the latest release of SFP and unzip it
mkdir SFP 
cd SFP 
curl -s https://api.github.com/repos/PhantomGamers/SFP/releases/latest \
| grep "SFP_UI-SelfContained-linux-x64.zip" \
| cut -d : -f 2,3 \
| tr -d \" \
| wget -qi -
unzip *.zip
chmod +x SFP_UI
./SFP_UI 

# Install metro
if [ -d ~/.steam ]
then
  mkdir -p ~/.steam/steam/skins/
  git clone https://github.com/minischetti/metro-for-steam ~/.steam/steam/skins/catppuccin
  export METRO="~/.steam/steam/skins/catppuccin"
elif [ -d ~/.var/app/com.valvesoftware.Steam ]
then
  mkdir -p ~/.var/app/com.valvesoftware.Steam/.steam/steam/skins
  git clone https://github.com/minischetti/metro-for-steam ~/.var/app/com.valvesoftware.Steam/.steam/steam/skins/catppuccin
  export METRO="~/.var/app/com.valvesoftware.Steam/.steam/steam/skins/catppuccin"
fi
 
# Install the metro patch
cd ../ 
mkdir UPMetro
cd UPMetro
git clone https://github.com/redsigma/UPMetroSkin
cp -r 'Unofficial 4.x patch'/'Main Files'/* $METRO
cd ../ 

# Finally install the catppuccin flavor of the users choosing
git clone https://github.com/catppuccin/steam.git
cd steam
printf "Which flavor would you like to install?\n 1) mocha\n 2) frappe\n 3) latte\n 4) macchiato"  
read -r -p "--> " flavor
cp -r themes/$flavor/* $METRO

# Little thank you message to the installer
echo "Thank you for installing catppuccin ${flavor} for steam :3"

