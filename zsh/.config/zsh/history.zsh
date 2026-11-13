# ~/.config/zsh/history.zsh — managed by ~/dotfiles (stow package: zsh)
# Oh My Zsh already enables share_history and ignore_space; this adds more.
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_all_dups   # drop older copies of a repeated command
setopt hist_find_no_dups      # no duplicates when searching with Ctrl-R / arrows
setopt hist_reduce_blanks
