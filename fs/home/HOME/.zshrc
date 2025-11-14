# 💚 ✨ HyprYoshi3 ✨ 🦕

#source $HOME/.config/zshrc.d/*.zsh

#autoload -Uz add-zsh-hook

# UNFUNCTION ALL _ksi FUNCTIONS
if [[ -n "$ENABLE_KITTY_INTEGRATION" ]]; then
    source /sources/unofficial/kitty/shell-integration/zsh/kitty-integration
fi

function kitty_prompt_start {
  print -n "\e]133;k;start_kitty\a"
  print -n "\e]133;A\a"
}

function kitty_prompt_end {
  print -n "\e]133;D;$?\a\e]133;k;end_kitty\a"
}

add-zsh-hook precmd kitty_prompt_end
add-zsh-hook preexec kitty_prompt_start

function set_title {
  print -Pn "\e]2;%~\a"
}
add-zsh-hook precmd set_title

eval "$(starship init zsh)"
