# ~/.config/zsh/aliases.zsh — managed by ~/dotfiles (stow package: zsh)

if command -v eza >/dev/null; then
  alias ls='eza --group-directories-first'
  alias ll='eza -l --git --icons --group-directories-first'
  alias la='ll -a'
  alias lt='eza --tree --level=2 --icons'
fi

command -v bat >/dev/null && alias cat='bat --paging=never'
