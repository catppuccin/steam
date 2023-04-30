#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

rose="\033[38;2;237;135;150m"
orange="\033[38;2;245;169;127m"
peach="\033[38;2;238;212;159m"
green="\033[38;2;166;218;149m"
blue="\033[38;2;125;196;228m"
pink="\033[38;2;198;160;246m"
white="\033[38;2;255;255;255m"

function welcome() {
echo -e "${rose} ⠀⠀⠀⠀⠀⠀⠀⠀⣀⣤⣴⣶⣶⣿⣿⣿⣿⣷⣶⣦⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo -e "${orange}⠀⠀⠀⠀⠀⠀⣠⣶⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀"
echo -e "${peach}⠀⠀⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⢿⣿⣿⣷⣄⠀⠀⠀⠀"
echo -e "${green}⠀⠀⢠⣾⣿⣿⠀⠀⠀⠉⠛⢿⣿⠿⠿⠿⠿⠿⢿⠟⠁⠀⠀⠀⢿⣿⣿⣿⣷⡀⠀⠀"
echo -e "${blue}⠀⢠⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣿⡄⠀"
echo -e "${pink}⢀⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠹⣿⣿⣿⣿⣿⣷⠀"
echo -e "${rose}⢸⣿⣿⣿⣿⡿⠁⠀⠀⠀⠀⠀${white}⣠⣶⠶⣶⡄⠀⠀⢠⠾⠿⠶⡄⠀${rose}⠈⢿⣿⣿⣿⣿⡇"
echo -e "${orange}⣿⣿⣿⣿⣿⠃⠀⠀⠀⠀⠀⠀${white}⠋⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀${orange}⠘⣿⣿⣿⣿⣷"
echo -e "${peach}⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${pink}⠘⠻⠟⠀⠀⠀⠀⠀⠀⠀${peach}⣿⣿⣿⣿⡿"
echo -e "${green}⢹⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀${white}⠐⠦⠴⠓⠚⠀⠀⠀⠀⠀${green}⢠⣿⣿⣿⣿⡇"
echo -e "${blue}⠈⣿⣿⣿⣿⣆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⡿⠀"
echo -e "${pink}⠀⠘⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣠⣿⣿⣿⣿⣿⠃⠀"
echo -e "${rose}⠀⠀⠘⢿⣿⣿⣿⣿⣦⠀⠀⠀⠀⠀⠀⠀⢠⣀⡀⣀⡀⠀⢰⣿⣿⣿⣿⣿⡿⠁⠀⠀"
echo -e "${orange}⠀⠀⠀⠀⠻⣿⣿⣿⡟⠀⠀⠀⠀⠀⠀⠀${rose}⠸⣿⠟⠻⠇⠀⠀⣿⣿⣿⡿⠋⠀⠀⠀⠀"
echo -e "${peach}⠀⠀⠀⠀⠀⠀⠙⠿⠇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠟⠋⠀⠀⠀⠀⠀⠀${white}"
echo
echo "Welcome to Catppuccin for steam!"
echo "Let's get your theme set up :3  "
echo
}

function install-theme() {
	flavors=(
		'frappe'
		'latte'
		'mocha'
		'macchiato'
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
			read -p "Would you like to remove any previous installation of Catppuccin? [y/n] " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				rm -fr "$dir/steam/skins/Catppuccin-"*
			fi
			cd "$(mktemp -d)"
			mkdir -p "$dir/steam/skins/Catppuccin-$opt"
			install_path="$dir/steam/skins/Catppuccin-$opt"
			git clone https://github.com/minischetti/metro-for-steam "$install_path"
			git clone https://github.com/redsigma/UPMetroSkin
			cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"
      curl --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/resource/webkit.css" -o "$install_path/resource/webkit.css"
      curl --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/custom.styles" -o "$install_path/custom.styles"
      echo "Thanks for installing Catppuccin $opt for Steam :3"
			break
		else
			echo "Sorry, i couldn't find your steam installation."
			echo "Please input the path to your steam install"
			echo "e.g. $HOME/steam"
			read -r -p "==> " steam
			read -p "Would you like to remove any previous installation of Catppuccin? [y/n] " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				rm -fr "$steam/steam/skins/[cC]atppuccin-"*
			fi
			cd "$(mktemp -d)"
			mkdir -p "$steam/steam/skins/Catppuccin-$opt"
			install_path="$steam/steam/skins/Catppuccin-$opt"
			git clone https://github.com/minischetti/metro-for-steam "$install_path"
			git clone https://github.com/redsigma/UPMetroSkin
			cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"
      curl --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/resource/webkit.css" -o "$install_path/resource/webkit.css"
      curl --url "https://raw.githubusercontent.com/catppuccin/steam/main/themes/$opt/custom.styles" -o "$install_path/custom.styles"
      echo "Thanks for installing Catppuccin $opt for Steam :3"
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
  ["zypper"]="zypper in"
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
elif command -v zypper &>/dev/null; then
	check_dependencies "zypper"
else
	echo "==> Couldn't determine your package manager, install hints unavailable."
	echo "==> Please install the following packages, before running the script again:"
	echo ">" "${dependencies[@]}"
	exit 1
fi
