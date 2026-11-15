# ~/.config/zsh/tools.zsh — managed by ~/dotfiles (stow package: zsh)
# CLI tools from the Brewfile. Each block is skipped if the tool is missing.

# fzf: Ctrl-R history, Ctrl-T files, Alt-C cd
command -v fzf >/dev/null && source <(fzf --zsh)

# zoxide: `z dot` jumps to the best match, `zi` picks with fzf
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# grey ghost-text suggestions from history; → or End accepts
# disabled; uncomment to re-enable (still installed via Brewfile)
# [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
#   source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# (zsh-syntax-highlighting is sourced at the very end of ~/.zshrc)
