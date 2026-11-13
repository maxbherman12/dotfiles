# ~/.config/zsh/projects.zsh — managed by ~/dotfiles (stow package: zsh)
# Project navigation helpers. See README "Shell".

# cd into $PROJECTS_DIR
proj() { cd "${PROJECTS_DIR:-$HOME/projects}"; }

# fzf over $PROJECTS_DIR/*, cd into the pick. Overrides omz's gp (git push).
unalias gp 2>/dev/null
gp() {
  local dir
  dir="$(proj-pick "$@")" && [[ -n "$dir" ]] && cd "$dir"
}

# table of every treehouse worktree, cd into the pick
lw() {
  local dir
  dir="$(treehouse-pick "$@")" && [[ -n "$dir" ]] && cd "$dir"
}
