# ~/.zshrc — managed by ~/dotfiles (stow package: zsh)

# --- Oh My Zsh -------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""            # prompt comes from starship (see bottom)
plugins=(git)

[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# --- Environment -----------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

export PROJECTS_DIR="${PROJECTS_DIR:-$HOME/projects}"

if command -v nvim >/dev/null 2>&1; then
  export EDITOR="nvim"
  export VISUAL="nvim"
fi

# --- Modular config --------------------------------------------------------
for f in "$HOME"/.config/zsh/*.zsh(N); do
  source "$f"
done

# --- Machine-local overrides (not tracked) ---------------------------------
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

# --- Prompt ----------------------------------------------------------------
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"
