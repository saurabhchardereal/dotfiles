<h1 align="center">🏠</h1>
<p align='center'><b>~ There's no other place like <code>$HOME</code> ~</b></p>

<div align="center">
    <img alt="Lint Lua" src="https://img.shields.io/github/actions/workflow/status/schardev/dotfiles/.github/workflows/lint_lua.yml?label=Lint%20Lua">
    <img alt="Lint Scripts" src="https://img.shields.io/github/actions/workflow/status/schardev/dotfiles/.github/workflows/lint_shell.yml?label=Lint%20Scripts">
</div>

### Current Setup

- **DE:** [GNOME](https://www.gnome.org/)
- **OS:** [Arch Linux](https://archlinux.org)
- **Terminal:** [Wezterm](https://github.com/wez/wezterm)
- **Shell:** [zsh](https://wiki.archlinux.org/index.php/Zsh)
- **Editor:** [neovim](https://github.com/neovim/neovim)
- **Color Scheme:** [catppuccin](https://github.com/catppuccin)

### Table of Contents

- [ZSH](#ZSH)
- [Neovim](#Neovim)
- [Termux](#Termux)

---

### ZSH

#### Installation

Make sure you have [sheldon](https://github.com/rossmacarthur/sheldon) plugin manager installed in your system.

```bash
# Clone the repo
git clone https://github.com/schardev/dotfiles ~/dotfiles

# Symlink zsh directory to $HOME/.config/zsh and zsh/.zshenv to $HOME
ln -sf ~/dotfiles/config/zsh ${HOME}/.config/zsh
ln -sf ~/dotfiles/config/zsh/.zshenv ${HOME}

# restart shell/terminal
exec zsh
```

### Neovim

#### Requirements

- patched font (eg. [Powerline Fonts](https://github.com/powerline/fonts) or [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts))
- `clang`/`gcc` - For [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- `wget`/`curl` and `gzip`/`tar` - For fetching language servers
- `nodejs` and `npm` - For installing language servers
- `ripgrep` and/or `fd` - For telescope

#### Installation

```bash
# Clone the repo
git clone https://github.com/schardev/dotfiles ~/dotfiles

# Either symlink the nvim directory to your $HOME/.config or copy the contents
ln -sf ~/dotfiles/config/nvim ~/.config/nvim

# Open nvim and it'll automatically start installing plugins
nvim --headless "+Lazy! sync" +qa
```

### Termux

When I'm not on my laptop (or just too lazy to boot it up) I use [Termux](https://github.com/termux) to get my stuff done. It's pretty awesome!

The script will setup termux to have [Catppuccin](https://github.com/catppuccin) colorscheme and [Hack](https://github.com/source-foundry/Hack) fonts by default. It also does my git and dotfiles setup.

#### Installation

```bash
# Clone the repo
git clone https://github.com/schardev/dotfiles ~/dotfiles

# Run the script
./dotfiles/scripts/termux
```
