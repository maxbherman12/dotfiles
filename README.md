# dotfiles

Managed with [GNU stow](https://www.gnu.org/software/stow/). Each top-level directory is a
*package* whose contents mirror `$HOME`.

| Package    | Links to                                   |
| ---------- | ------------------------------------------ |
| `zsh`      | `~/.zshrc`, `~/.zprofile`, `~/.config/zsh/` |
| `git`      | `~/.config/git/config`, `~/.config/git/ignore` (identity stays in `~/.gitconfig`) |
| `bin`      | `~/.local/bin/proj-pick`, `~/.local/bin/treehouse-pick` |
| `starship` | `~/.config/starship.toml`                  |
| `nvim`     | `~/.config/nvim/` (LazyVim)                |
| `ghostty`  | `~/.config/ghostty/config.ghostty`         |
| `lazygit`  | `~/Library/Application Support/lazygit/config.yml` (delta pager, `\|` cycles inline/side-by-side) |

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

| Tool | Usage |
| ---- | ----- |
| zoxide | `z dot` jumps to the best-matching dir you've visited, `zi` picks with fzf |
| fzf | `Ctrl-R` history, `Ctrl-T` insert a file path, `Alt-C` cd into a subdir |
| autosuggestions | grey ghost text from history, `→` accepts (off by default; uncomment in `tools.zsh`) |
| eza | `ls`, `ll` (long + git status), `la` (with hidden), `lt` (tree) |
| bat | `cat` with syntax highlighting |
| delta | git's pager: side-by-side diffs, `n`/`N` jump between files |

Git aliases: `st`, `sw`, `co`, `lg` (graph log), `last`, `amend`, `undo` (soft-reset last commit), `unstage`.

## Neovim (LazyVim)

- Languages: Python, TypeScript/React, Tailwind (Next.js), Go, JSON, YAML, Markdown, Docker, TOML
- ESLint + Prettier, nvim-dap debugger (`<leader>d…`), neotest (`<leader>t…`)
- `jj` → Normal mode
- oil.nvim: `-` opens the parent dir, `<leader>-` floating oil, `nvim .` opens oil
- yanky: `[y`/`]y` cycle yank history after a paste, `<leader>p` yank picker
- treesitter-context: current function/component pinned at the top while scrolling
- claudecode.nvim (`<leader>a…`): `<leader>ac` toggle Claude, visual `<leader>as` send selection, `<leader>aa`/`<leader>ad` accept/deny diffs
- First launch installs plugins; run `:Mason` to watch LSPs/debuggers install.
- Commit `lazy-lock.json` after updating plugins so every machine matches.

## Adding a package

```sh
mkdir -p ~/dotfiles/foo/.config/foo
mv ~/.config/foo/config ~/dotfiles/foo/.config/foo/
./install.sh foo   # and add `foo` to ALL_PACKAGES in install.sh
```
