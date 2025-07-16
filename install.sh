#!/bin/bash

# first script. Just dummy
# WILL BASED ON AGSV2!!!!!!

if [ $EUID -eq 0 ]; then
    echo -e "FBI OPEN UP"
    exit 1
fi

# Gum check
echo "Does Gum work?"

sudo chown root:root .deps.txt
sudo chmod 555 .deps.txt

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
        "No") ;;
    esac
}
install_dots() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") ;; #cp -r ".config" "$HOME/" ;; # currently dummy.
        "No") echo "Thank you for having a look." && exit 1;;
    esac
}
set_los_wallpaper() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") ;; # cp -r .wallpaper "$HOME/Pictures/.Wallpapers" && swww img $HOME/Pictures/.Wallpapers/ascension_teal_dark.jpg ;; # currently dummy.
        "No") echo -e "For the best experience,\nwe reccomend using the LOS wallpaper";;
    esac
}
gum_work_check

if [ $? -eq 0 ]; then
  echo "Gum works"
else
  echo "Fuck it! Exiting."
  exit 1
fi

echo -e "Do you have the deps? This is CRUCIAL.\nOn LFS, you may wanna see .deps.txt,\nthen compile all the pkgs at the list here. Show it? BTW : then q is exit for less"
show_deps
echo -e "Thank you for checking,\nInstall now?"
install_dots
echo -e "Set the LineageOS wallpaper (WARNING: NO LIGHT MODE)?"
set_los_wallpaper
echo -e "Thank you for using my dotfiles!"
