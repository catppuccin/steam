#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

function welcome() {
tput setaf 1; echo "⠀⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣶⣿⣿⣿⣿⣷⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
tput setaf 2; echo "⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀"
tput setaf 3; echo "⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣷⣄⠀⠀⠀⠀"
tput setaf 4; echo "⠀⠀⢠⣾⣿⣿⠀⠀⠀⠉⠛⢿⣿⠿⠿⠿⠿⠿⢿⠟⠁⠀⠀⠀⢿⣿⣿⣿⣷⡀⠀⠀"
tput setaf 5; echo "⠀⢠⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡄⠀"
tput setaf 6; echo "⢀⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣷⠀"
tput setaf 7; echo "⢸⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀⣠⣶⠶⣶⡄⠀⠀⢠⠾⠿⠶⡄⠀⠈⢿⣿⣿⣿⣿⡇"
tput setaf 8; echo "⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀⠋⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⣿⣿⣿⣿⣷"
tput setaf 7; echo "⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠻⠟⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⡿"
tput setaf 6; echo "⢹⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠐⠦⠴⠓⠚⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⡇"
tput setaf 5; echo "⠈⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⡿⠀"
tput setaf 4; echo "⠀⠘⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⠃⠀"
tput setaf 3; echo "⠀⠀⠘⢿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⢠⣀⡀⣀⡀⠀⢰⣿⣿⣿⣿⣿⡿⠁⠀⠀"
tput setaf 2; echo "⠀⠀⠀⠀⠻⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀⠸⣿⠟⠻⠇⠀⠀⣿⣿⣿⡿⠋⠀⠀⠀⠀"
tput setaf 1; echo "⠀⠀⠀⠀⠀⠀⠙⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠟⠋⠀⠀⠀⠀⠀⠀"
tput setaf 7; echo
echo "Welcome to Catppuccin for steam!"
echo "Let's get your theme set up :3  "
echo
}

function install-theme() {
	flavors=(
		'Frappe'
		'Latte'
		'Mocha'
		'Macchiato'
	)

	PS3="Please select a flavor (TIP: You can input a number if you'd like): "
	select opt in "${flavors[@]}"; do
		if [[ -n $opt ]]; then
			break
		else
			echo "Please input a valid flavor!"
		fi
	done

	steamdirs=(
		"$HOME/.steam"
		"$HOME/.var/app/com.valvesoftware.Steam/.steam/"
	)

	for dir in "${steamdirs[@]}"; do
		if [ -d "$dir" ]; then
      read -p "Would you like to remove any previous installation(s) of Catppuccin? [y/n] " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				rm -fr "$dir/steam/skins/[Cc]atppuccin "*
			fi
			cd "$(mktemp -d)"
			mkdir -p "$dir/steam/skins/Catppuccin $opt"
			install_path="$dir/steam/skins/Catppuccin $opt"
			git clone https://github.com/minischetti/metro-for-steam "$install_path" --progress 2>&1 | grep "Receiving objects"
			git clone https://github.com/redsigma/UPMetroSkin --progress 2>&1 | grep "Receiving objects"
			cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"
      curl --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/resource/webkit.css" -o "$install_path/resource/webkit.css" -#
      curl --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/custom.styles" -o "$install_path/custom.styles" -#
      echo "Thanks for installing Catppuccin $opt for Steam :D"
			break
		else
			echo "Sorry, i couldn't find your steam installation."
			echo "Please input the path to your steam install"
			echo "e.g. $HOME/steam"
			read -r -p "==> " steam
      read -p "Would you like to remove any previous installation(s) of Catppuccin? [y/n] " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				rm -fr "$steam/steam/skins/[Cc]atppuccin "*
			fi
			cd "$(mktemp -d)"
			mkdir -p "$steam/steam/skins/Catppuccin $opt"
			install_path="$steam/steam/skins/Catppuccin $opt"
			git clone -q https://github.com/minischetti/metro-for-steam "$install_path" --progress 2>&1 | grep "Receiving objects"
			git clone -q https://github.com/redsigma/UPMetroSkin --progress 2>&1 | grep "Receiving objects"
			cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"
      curl --silent --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/resource/webkit.css" -o "$install_path/resource/webkit.css"
      curl --silent --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/custom.styles" -o "$install_path/custom.styles"
      echo "Thanks for installing Catppuccin $opt for Steam :D"
		fi
	done
}

declare -A install_command
dependencies=("curl" "git")
install_command=(
	["apt-get"]="sudo apt-get install"
	["dnf"]="sudo dnf install"
	["emerge"]="sudo emerge -a"
	["nix-shell"]="nix-shell -p"
	["pacman"]="sudo pacman -S"
	["cave"]="cave resolve"
	["apk"]="apk add"
	["xbps-install"]="xbps-install"
	["brew"]="brew install"
)

function check_dependencies() {
	local pm="$1"
	local missing=()

	for package in "${dependencies[@]}"; do
		if ! command -v "$package" &>/dev/null; then
			missing+=("$package")
		fi
	done

	if [ "${#missing[@]}" -gt 0 ]; then
		echo "==> The following packages are missing:"
		echo "${missing[@]}"
		echo ""
		echo "==> Please install them with:"
		echo "> ${install_command[$pm]}" "${missing[@]}"
		exit 1
	else
    clear
    welcome
		install-theme
	fi
}

if command -v apt-get &>/dev/null; then
	check_dependencies "apt-get"
elif command -v dnf &>/dev/null; then
	check_dependencies "dnf"
elif command -v emerge &>/dev/null; then
	check_dependencies "emerge"
elif command -v nix-shell &>/dev/null; then
	check_dependencies "nix-shell"
elif command -v pacman &>/dev/null; then
	check_dependencies "pacman"
elif command -v cave &>/dev/null; then
	check_dependencies "cave"
elif command -v apk &>/dev/null; then
	check_dependencies "apk"
elif command -v xbps-install &>/dev/null; then
	check_dependencies "xbps-install"
elif command -v brew &>/dev/null; then
	check_dependencies "brew"
else
	echo "==> Couldn't determine your package manager, install hints unavailable."
	echo "==> Please install the following packages, before running the script again:"
	echo ">" "${dependencies[@]}"
	exit 1
fi
