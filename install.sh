#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

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
			read -p "Would you like to remove any previous installation of catppuccin? [y/n] " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				rm -fr "$dir/steam/skins/catppuccin-"*
			fi
			cd "$(mktemp -d)"
			mkdir -p "$dir/steam/skins/catppuccin-$opt"
			install_path="$dir/steam/skins/catppuccin-$opt"
			git clone https://github.com/minischetti/metro-for-steam "$install_path"
			git clone https://github.com/redsigma/UPMetroSkin
			cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"
			git clone https://github.com/catppuccin/steam.git
			cp -fr "steam/themes/$opt"/* "$install_path"
      echo "Thanks for installing catppuccin $opt for steam :3"
			break
		else
			echo "Sorry, i couldn't find your steam installation."
			echo "Please input the path to your steam install"
			echo "e.g. $HOME/steam"
			read -p -r "==> " steam
			read -p "Would you like to remove any previous installation of catppuccin? [y/n] " -n 1 -r
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				rm -fr "$steam/steam/skins/catppuccin-"*
			fi
			cd "$(mktemp -d)"
			mkdir -p "$steam/steam/skins/catppuccin-$opt"
			install_path="$steam/steam/skins/catppuccin-$opt"
			git clone https://github.com/minischetti/metro-for-steam "$install_path"
			git clone https://github.com/redsigma/UPMetroSkin
			cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"
			git clone https://github.com/catppuccin/steam.git
			cp -fr "steam/themes/$opt"/* "$install_path"
      echo "Thanks for installing catppuccin $opt for steam :3"
		fi
	done
}

declare -A install_command
dependencies=("curl" "unzip" "git")
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
		echo "Installing theme!"
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
