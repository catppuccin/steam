#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

for main in index.{"/usr/bin/git","/usr/bin/unzip","/usr/bin/wget"}
do
    command -v "$main" || deps=false
done

function install-theme()
{
# Make temp directory
cd "$(mktemp -d)" || exit 1

# Get the latest release of SFP and unzip it
mkdir SFP
cd SFP || exit 1
wget -q https://github.com/PhantomGamers/SFP/releases/download/0.0.14/SFP_UI-SelfContained-linux-x64.zip
unzip ./*.zip
chmod +x SFP_UI
./SFP_UI

# Install metro
if [ -d ~/.steam ]
then
  rm -fr ~/.steam/steam/skins/catppuccin
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
  read -f -r "--> " steampath
  mkdir "$steampath/steam/skins/catppuccin"
  git clone https://github.com/minischetti/metro-for-steam "$steampath/steam/skins/catppuccin"
  export install_path="$steampath/steam/skins/catppuccin"
fi

# Install the metro patch
cd ../
git clone https://github.com/redsigma/UPMetroSkin
cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"

# Finally install the catppuccin flavor of the users choosing
git clone https://github.com/catppuccin/steam.git
cd steam || exit 1
select flavor in frappe latte macchiato mocha
do 
  cp -r "themes/$flavor/"* "$install_path" || echo "Please input a valid flavor name"
  exit
done

  # Little thank you message to the installer
  echo "Thank you for installing catppuccin ${flavor} for steam :3"
}

# Install dependencies
read -p "Would you like to install the dependencies? " -n 1 -r
echo
if [[ "$REPLY" =~ ^[Yy]$ ]]
then
  dependencies=("wget" "git" "unzip")
  if [ -f "/usr/bin/pacman" ] && [ "$deps" = false ]
  then
    sudo pacman -S "${dependencies[@]}"
  elif [ -f /usr/bin/emerge ] && [ "$deps" = false ]
  then
    sudo emerge -av "${dependencies[@]}"
  elif [ -f /usr/bin/apt ] && [ "$deps" = false ]
  then
     sudo apt-get install "${dependencies[@]}"
  elif [ -d /nix ]
  then
    nix-shell -p "${dependencies[@]}"
  elif [ -f /usr/bin/dnf ] && [ "$deps" = false ]
  then
    sudo dnf install "${dependencies[@]}"
  else
    readf "Please install the following packages using your package manager:\n curl\n wget\n unzip\n git\n"
    exit
  fi
  install-theme
elif [[ ! "$REPLY" =~ ^[Yy]$ ]]
then
  install-theme
fi

