#!/bin/bash

# CHECKS FOR SUDO ACCESS (added because of those who have seperate partitions for /home and /root) 

if [ "$EUID" -ne 0 ]
  then echo "Please don't run as root" && exit
  exit
fi

# MAKE DIRECTORY SO THAT YOUR HOME DIRECTORY DOESN'T GET DIRTY

cd /home/$USER
mkdir -p junk-drawer
cd junk-drawer

# Install git and wget

echo "What distro do you use?"
echo "1) Arch Linux"
echo "2) Fedora Linux"
echo "3) Gentoo/Funtoo Linux"
echo "4) Ubuntu/Debian and Ubuntu/Debian based distros"
echo "5) Void Linux"
echo "6) NixOS"
echo "7) Alpine Linux"
echo "8) openSUSE Linux"
read -p "Please input a number between 1 and 8: " DISTRO
case $DISTRO in 
[1])
	sudo pacman -S git wget unzip --needed
	;;

[2])
  sudo dnf install wget git unzip
	;;

[3])
  sudo emerge wget git unzip
  ;;

[4])
	sudo apt install wget git unzip
	;;
  
[5])
  sudo xbps-install wget git unzip
  ;;
  
[6])
  sudo nix-shell -p wget git unzip
  ;;
  
[7])
  sudo apk add wget git unzip
  ;;
  
[8])
  sudo zypper install wget git unzip
  ;;
esac

# Download, unzip, and execute SFP (formerly Steam Friends Patcher)

wget https://github.com/PhantomGamers/SFP/releases/download/0.0.14/SFP_UI-SelfContained-linux-x64.zip
unzip SFP_UI-SelfContained-linux-x64.zip
chmod +x SFP_UI
./SFP_UI

# Download the original Steam for Metro (Will create a directory for it so that things stay clean) 

wget https://github.com/minischetti/metro-for-steam/archive/refs/tags/v4.4.zip
mkdir ./metro && mv v4.4.zip ./metro/ && cd ./metro

# Unzip Metro and remove the ZIP file

unzip ./v4.4.zip
rm -f ./v4.4.zip

# Ask for the path to the users .steam file so that it can be used with Flatpak installations,
# then makes a folder in the .steam/steam/skins directory called 'metro' to unzip metro to.
# Also makes the skins folder if it doesn't exist

read -p "Where is your steam installation? Copy the path (e.g. /home/thebearodactyluwu/.steam) and paste it here: " steaminstall
mkdir -p "$steaminstall/steam/skins/metro"

# Sets the METRO variable to the previously created metro folder, then copies the 
# extracted contents of metro to said metro folder

METRO='$steaminstall/steam/skins/metro'
cp -r * $steaminstall/steam/skins/metro
rm -rf *

# Downloads the latest release of the Metro Patch

wget https://github.com/redsigma/UPMetroSkin/archive/refs/tags/9.1.44.zip
unzip 9.1.44.zip
cp -r ./9.1.44/'Unofficial 4.x Patch'/'Main Files [Install First]'/* $METRO
echo "What is your flavour?\n 1) Frappe\n 2) Latte\n 3) Macchiato\n 4) Mocha\n"

# Asks the user which flavour they'd like to install
# FLAVOR is the theme folder
# FLAVOUR is literally just the flavor name so that the little echo scripts at the end look good

case $FLAVOR in 
[1])
	FLAVOR='themes/frappe'
  FLAVOUR='Frappe'
	;;

[2])
	FLAVOR='themes/latte'
  FLAVOUR='Latte'
	;;

[3])
  FLAVOR='themes/macchiato'
  FLAVOUR='Macchiato'
  ;;

[4])
	FLAVOR='themes/mocha'
  FLAVOUR='Mocha'
	;;
esac
git clone https://github.com/catppuccin/steam
cd steam
cp -r $FLAVOR $METRO

# Gives the user instructions to complete the installation

echo "Steps to install theme:"
echo " 1) Open Steam and go into settings"
echo " 2) Change the skin to metro"
echo " 3) Steam will prompt you to restart!"
echo "    Just press OK, and presto!"
echo "    You have installed: "
echo
echo "    Catppuccin " $FLAVOUR
echo
echo "    On Steam!"
clear
sleep 15

# Removes the junk-drawer folder from earlier

cd /home/$USER
rm -rf junk-drawer

# Little easter egg for those who don't mind waiting about 15 seconds a lot 
echo "Why're you still here? You"
echo "should be playing ULTRAKILL"
echo "or something!"

# Opens steam for the user. Good for procrastinators and such.
# Remove "<<lol" and the last line (should say lol as well) to enable this

<<lol
echo "Fine. i'll open Steam for you."
clear
cd "$steaminstall/steam"
./steam.sh
lol

# Stops the script

exit
