# dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). Each top-level directory is a
*package* whose contents mirror `$HOME`.

| Package    | Links to                                   |
| ---------- | ------------------------------------------ |
| `zsh`      | `~/.zshrc`, `~/.zprofile`, `~/.config/zsh/` |
| `bin`      | `~/.local/bin/proj-pick`, `~/.local/bin/treehouse-pick` |
| `starship` | `~/.config/starship.toml`                  |
| `nvim`     | `~/.config/nvim/` (LazyVim)                |
| `ghostty`  | `~/.config/ghostty/config.ghostty`         |

## New machine

```sh
git clone <this repo> ~/dotfiles
cd ~/dotfiles
./install.sh --brew     # brew bundle + stow everything
```

`./install.sh` without `--brew` only stows. Pass package names to stow a subset
(`./install.sh nvim`). Conflicting real files are moved aside to `*.bak-<timestamp>`.

Machine-specific shell config goes in `~/.zshrc.local` (untracked).

## Shell

| Command | What it does |
| ------- | ------------ |
| `proj`  | `cd $PROJECTS_DIR` (default `~/projects`) |
| `gp`    | fzf over `$PROJECTS_DIR/*`, cd into the pick (overrides omz's `gp` = `git push`) |
| `lw`    | table of every treehouse worktree across all pools, cd into the pick |

Both pickers accept an initial query: `gp mai`, `lw auth`.

## Neovim (LazyVim)

- Languages: Python, TypeScript/React, Tailwind (Next.js), Go, JSON, YAML, Markdown, Docker, TOML
- ESLint + Prettier, nvim-dap debugger (`<leader>d…`), neotest (`<leader>t…`)
- `jj` → Normal mode
- oil.nvim: `-` opens the parent dir, `<leader>-` floating oil, `nvim .` opens oil
- First launch installs plugins; run `:Mason` to watch LSPs/debuggers install.
- Commit `lazy-lock.json` after updating plugins so every machine matches.

## Adding a package

```sh
mkdir -p ~/dotfiles/foo/.config/foo
mv ~/.config/foo/config ~/dotfiles/foo/.config/foo/
./install.sh foo   # and add `foo` to ALL_PACKAGES in install.sh
```
