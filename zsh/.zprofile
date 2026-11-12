# ~/.zprofile — managed by ~/dotfiles (stow package: zsh)

# Homebrew: Apple Silicon lives in /opt/homebrew, Intel in /usr/local
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv zsh)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv zsh)"
fi
