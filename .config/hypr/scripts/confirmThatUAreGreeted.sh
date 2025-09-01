if [ ! -f "$HOME/.local/share/hyprmaterial3/greeted.txt" ]; then
    notify-send "Welcome to HyprMaterial3!" "This is currently not finished yet. Enjoy your experience!"
    mkdir -p "$HOME/.local/share/hyprmaterial3"
    touch "$HOME/.local/share/hyprmaterial3/greeted.txt"
fi
