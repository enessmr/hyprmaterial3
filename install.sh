#!/bin/bash

if [ $EUID -eq 0 ]; then
    echo -e "FBI OPEN UP U AINT GOD"
    exit 1
fi
if ! command -v pfetch >/dev/null 2>&1; then
    echo -e "🖕 fuck you 🖕\n"
    echo -e "🖕 🖕\n"
    exit 1
fi

# Gum check
echo "Does Gum work?"

sudo chown root:root .deps.txt
sudo chmod 444 .deps.txt

# some voids, i call it cuz im learn c :)
gum_work_check() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") ;;
        "No") exit 1 ;;
    esac
}
show_deps() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") less .deps.txt ;;
        "No") echo -e "🖕 fuck you you stupid ni**a motherfucker loser lolll 🖕\n" ;;
    esac
}
install_dots() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") rm -rf ~/.config/{ags,hypr,matugen,rofi,kitty,fish,gtk-3.0,gtk-4.0,qt5ct,qt6ct,sway,television,helix,fuzzel,btop,alacritty,wlogout} && cp -r ".config" "$HOME/" && read -p "Enter something: " userinput && mkdir -p ~/.local/share/hyprmaterial3 && cp -r .local ~/ && echo "$userinput" > ~/.local/share/hyprmaterial3/github-username.txt && grep -qxF 'export PF_ASCII="Catppuccin"' ~/.bashrc || echo 'export PF_ASCII="Catppuccin"' >> ~/.bashrc && grep -qxF 'pfetch' ~/.bashrc || echo 'pfetch' >> ~/.bashrc && source ~/.bashrc ;; # i did it
        "No") echo "Fluck you for :unoreverse:ing my real dots!" && exit 1;;
    esac
}
set_los_wallpaper() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") cp -r .wallpaper "$HOME/Pictures/.Wallpapers" && swww img $HOME/Pictures/.Wallpapers/ascension_teal_dark.jpg ;; # yay
        "No") echo -e "For the best experience,\nwe reccomend using the LOS wallpaper";;
    esac
}
want_to_install_bscode() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") sudo ./installer/install-bscode.sh ;;
        "No") exit 1 ;;
    esac
}
want_to_install_vesktop() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") sudo ./installer/install_vesktop.sh ;;
        "No") exit 1 ;;
    esac
}
want_to_install_ytmusic() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") sudo ./installer/install-ytmusic.sh ;;
        "No") exit 1 ;;
    esac
}
gum_work_check

if [ $? -eq 0 ]; then
  echo "Gum works"
else
  echo "Fuck it! Exiting."
  exit 1
fi

echo -e "Do you have the deps? This is CRUCIAL.\nOn LFS, you may wanna see .deps.txt,\nthen compile all the pkgs at the list here. Show it? BTW : + q is exit for less"
show_deps
echo -e "Thank you for checking,\nInstall now?"
install_dots
if [[ "$userinput" == *"loser"* ]]; then
    echo -e "\033[31mget uno reverse you loser fucking shitty asshole motherfucker.\033[0m"
    exit 1
fi
echo -e "Set the LineageOS wallpaper (WARNING: NO LIGHT MODE)?\n"
set_los_wallpaper
echo -e "Want to install BSCode (aka VSCode)? (requires sudo btw)\n"
want_to_install_bscode
echo -e "Want to install a loaded SPAS 12 (I mean Vesktop)?\n"
want_to_install_vesktop
echo -e "Want to install a double propelled flamethrower (I mean YT Music. dont worry it has an adblocker)?\n"
want_to_install_ytmusic
ags run &
echo -e "Done! Please restart Hyprland.\n"
