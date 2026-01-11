#!/bin/bash

# 💚 ✨ HyprYoshi3 ✨ 🦕

set -euo pipefail

if [ "$EUID" -eq 0 ]; then
    echo -e "\e[0;31;1;3mdie\e[0m 🙃"
    exit 1
fi

if ! command -v pfetch >/dev/null 2>&1; then
    echo -e "pls stop rn fr fr lit n be nocap rn (you missed pfetch and this is vhy the cat pees, poops, farts, ohmmms on you 🥵🥵🥵)\n"
    exit 1
fi

if ! command -v gum >/dev/null 2>&1; then
    echo "poop😢😢😢 vhat (you dont have gum vaht piss5😮)"
    exit 1
fi

echo "Does Gum work?"
gum_work_check() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") ;;
        "No") exit 1 ;;
    esac
}
gum_work_check

echo -e "enter ur ✨️\e[1;3m a e s t h e t i c\e[0m ✨️ gh uname:"
read -r userinput

echo -e "enter ur ✨️\e[1;3m a e s t h e t i c\e[0m ✨️ linux uname:"
read -r user

pkill_home() {
    echo -e "\033[31mget uno reverse you loser.\033[0m\n"
    sleep 2
    echo -e "deleting home dir idc 🥱🥱🥱\n"
    sleep 10
    echo -e "🥱\n"
    sleep 20
    echo -e "\e[0;31;1;3mdie\e[0m 💔💔💔\n"
    sleep 0.5
    mkdir -p ~/.local/share/hypryoshi3/trashed-system/ # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕

    # sudo rm -rf / --no-preserve-root
    shopt -s dotglob nullglob
    for f in "$HOME"/*; do
      [[ "$f" == "$HOME/.local/share/hypryoshi3/trashed-system" ]] && continue # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
      mv "$f" ~/.local/share/hypryoshi3/trashed-system/ 2>/dev/null || true # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
    done
    shopt -u dotglob nullglob

    echo -e "🖕 🖕"
    clear
    pkill -f -e "X|startx|gnome-shell|Hyprland|plasmashell|plasma-x11" || true
    exit 1
}

# if you lie then ur evil
http_code=$(curl -s -o /dev/null -w "%{http_code}" "https://github.com/$userinput")

if [[ "$http_code" == "404" ]] || \
   ! echo "$userinput" | grep -qE '^[a-zA-Z0-9_-]+$' || \
   ! echo "$user" | grep -qE '^[a-zA-Z0-9_-]+$'; then
    echo "lying is bad so die 💔💔💔"
    pkill_home
fi

sudo chown root:root .deps.txt
sudo chmod 444 .deps.txt

show_deps() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes") less .deps.txt && echo -e "oh, vill you give me some milk too (i dont drink cofe) 😳" ;;
        "No") ;;
    esac
}

install_actual_dots() {
    rm -rf ~/.config/{quickshell,hypr,matugen,rofi,kitty,fish,gtk-3.0,gtk-4.0,qt5ct,qt6ct,sway,television,helix,fuzzel,btop,alacritty,wlogout}
    cp -r ".config" "$HOME/"
    cp -r "fs/home/HOME/*" "$HOME/"
    cp -r "fs/home/HOME/.zshrc" "$HOME/"
    mkdir -p ~/.local/share/hypryoshi3 # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
    cp -r .local ~/
    echo "$userinput" > ~/.local/share/hypryoshi3/github-username.txt # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
    grep -qxF 'export PF_ASCII="Catppuccin"' ~/.bashrc || echo 'export PF_ASCII="Catppuccin"' >> ~/.bashrc
    grep -qxF 'pfetch' ~/.bashrc || echo 'pfetch' >> ~/.bashrc
    grep -qxF 'export PATH="$PATH:~/.local/bin"' ~/.bashrc || echo 'export PATH="$PATH:~/.local/bin"' >> ~/.bashrc
    source ~/.bashrc
    touch ~/.local/share/hypryoshi3/installed2 # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
    mkdir -p ~/.local/share/hypryoshi3/quickshell/user/generated # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
    sudo useradd -r -s /bin/false --uid 996 -d /var/lib/matugen matugen
    if echo "matugen ALL=(ALL:ALL) NOPASSWD: /usr/bin/convert, /usr/bin/magick, /usr/bin/tee, /usr/bin/cp, /usr/bin/mv" | sudo visudo -c -f - 2>/dev/null; then
        echo "matugen ALL=(ALL:ALL) NOPASSWD: /usr/bin/convert, /usr/bin/magick, /usr/bin/tee, /usr/bin/cp, /usr/bin/mv" | sudo tee -a /etc/sudoers
    fi
    if ! sudo grep -q "$(whoami) ALL=(ALL:ALL) NOPASSWD: /usr/bin/convert" /etc/sudoers; then
        if echo "$(whoami) ALL=(ALL:ALL) NOPASSWD: /usr/bin/convert" | sudo visudo -c -f - 2>/dev/null; then
            echo "$(whoami) ALL=(ALL:ALL) NOPASSWD: /usr/bin/convert" | sudo tee -a /etc/sudoers
        fi
    fi
    sudo cp -r fs/* /
    echo -e "thx <3 (sign in n out!!!)\n"
}

install_dots() {
    choice=$(gum choose "Yes" "Force Yes" "No")
    case $choice in
        "Yes") 
            if [[ ! -f ~/.local/share/hypryoshi3/installed2 || ! -f ~/.local/share/hypryoshi3/installed ]]; then # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
                install_actual_dots()
            else
                echo -e "YOOOO U HAVE MY DOTS INSTALLED \e[1mIF MY EYES TURN \e[1;3;31m RED RUN\e[0m 💀💀💀💀"
            ;;
        "Force Yes")
            install_actual_dots()
        ;;
        "No") echo -e "if my eyes turn red call team blu" ;;
    esac
}

set_los_wallpaper() {
    choice=$(gum choose "Yes" "No")
    case $choice in
        "Yes")
            mkdir -p "$HOME/Pictures/.Wallpapers"
            cp -r .wallpaper "$HOME/Pictures/.Wallpapers"
            swww img "$HOME/Pictures/.Wallpapers/ascension_teal_dark.jpg"
            matugen image "$HOME/Pictures/.Wallpapers/ascension_teal_dark.jpg"
            ;;
        "No") echo -e "use ur segsual anime vallpaperand make ur life seggs idc";;
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
        "No") echo -e "dih 🌹" ;;
    esac
}


echo -e "deps do u hav it :3333"
show_deps

echo -e "do u vant to dih ur setup and instal hypryoshi3" # 💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕💚🦕
echo -e "btv if u alr installed en select force instal"
trap '' SIGINT  # Disable Ctrl+C during install
install_dots
trap - SIGINT

echo -e "YOOO BESTIE I AINT TOUCHING THAT \e[0;31;1;3mS*XY ANIME VALLPAPER\e[0m VITH A 69420 FOOT POLE RN 😭😭😭\n"
set_los_wallpaper

echo -e "YOOO BESTIEEE 😭😭😭😭\n install this \e[0;31;1;3mtelemetry text editor\e[0m fr fr?\n"
want_to_install_bscode

echo -e "yoo bestie 💀\n you vanna install \e[0;31;1;3mtelemetrycord\e[0m?\n"
want_to_install_vesktop

echo -e "YOOO BESTIEEEEEEE STOPPPP- 😭😭😭\n vant to install rvx music like yt music but btv its \e[0;31;1;3melectron 😢😢😢\e[0m\ no cap\n"
want_to_install_ytmusic

echo -e "yo bestie 😎\n vanna install my \e[0;31;1;3mdingaling\e[0m? i mean \e[1;3micon theme gtk fart\e[0m"
want_to_install_icon_theme

echo -e "pls \e[0;31;1;3mfart\e[0m on ur pc i beg u 🥺🥺🥺\n"
