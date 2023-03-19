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
  # Make temp directory
  cd "$(mktemp -d)" || exit 1

  # Install metro
  if [ -d ~/.steam ]; then
    read -p "Would you like to remove any previous installation of catppuccin? [y/n] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -fr "$HOME/.steam/steam/skins/catppuccin-"*
    fi
    mkdir -p ~/.steam/steam/skins/
    git clone https://github.com/minischetti/metro-for-steam ~/.steam/steam/skins/"catppuccin-$opt"
    install_path="$HOME/.steam/steam/skins/catppuccin-$opt"
  elif [ -d ~/.var/app/com.valvesoftware.Steam ]; then
    echo "Would you like to remove any previous installation of catppuccin? [Y/n]"
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      rm -fr "$HOME/.var/app/com.valvesoftware.Steam/.steam/steam/skins/catppuccin-"*
    fi
    mkdir -p ~/.var/app/com.valvesoftware.Steam/.steam/steam/skins
    git clone https://github.com/minischetti/metro-for-steam ~/.var/app/com.valvesoftware.Steam/.steam/steam/skins/"catppuccin-$opt"
    install_path="$HOME/.var/app/com.valvesoftware.Steam/.steam/steam/skins/catppuccin-$opt"
  else
    echo "Sorry, i couldn't find your steam installation"
    echo "Please paste the path to '.steam' below"
    echo "EXAMPLE: ~/.local/share/steam"
    read -f -r "--> " steampath
    mkdir "$steampath/steam/skins/catppuccin"
    git clone https://github.com/minischetti/metro-for-steam "$steampath/steam/skins/catppuccin-$opt"
    install_path="$steampath/steam/skins/catppuccin-$opt"
  fi

  # Install the metro patch
  git clone https://github.com/redsigma/UPMetroSkin
  cp -r UPMetroSkin/"Unofficial 4.x Patch"/"Main Files [Install First]"/* "$install_path"

  # Finally install the catppuccin flavor of the users choosing
  git clone https://github.com/catppuccin/steam.git
  cd steam || exit 1
  cp -fr "themes/$opt"/* "$install_path"

  # Little thank you message to the installer
  echo "Thank you for installing catppuccin ${opt} for steam :3"
}

# Install dependencies
declare -A install_command
dependencies=("curl" "unzip" "git")
install_command=(
  ["apt-get"]="sudo apt-get install"
  ["dnf"]="sudo dnf install"
  ["emerge"]="sudo emerge"
  ["nix-shell"]="nix-shell -p"
  ["pacman"]="sudo pacman -S"
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
else
  echo "==> Couldn't determine your package manager, install hints unavailable."
  echo "==> Please install the following packages, before running the script again:"
  echo ">" "${dependencies[@]}"
  exit 1
fi
