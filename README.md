# Neovim configuration

![GitHub](https://img.shields.io/github/license/stijnklomp-text-editors/neovim?style=flat)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/stijnklomp-text-editors/neovim)
![OS](https://img.shields.io/badge/OS-Linux%20%2F%20Windows%20%2F%20macOS-blue)

My personal neovim configuration.

### Getting setup

##### Install Neovim
1. Install [Neovim](https://github.com/neovim/neovim/releases/tag/stable)
	*AppImage installation recommended*

2. Clone the project into the .config directory
3. Put alias for NeoVim in your user shell config file (ex. .bashrc/.zshrc)

```bash
export EDITOR="~/squashfs-root/usr/bin/nvim"
alias nvim="~/squashfs-root/usr/bin/nvim"
```

##### Get Ripgrep plugin working (for Telescope plugin)
1. Install Rust to compile Ripgrep

```bash
# WSL command:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

2. Build

```bash
cd <path-to-plugin>/ripgrep
cargo build --release
./target/release/rg --version
```

### Manage LSP servers, DAP servers, linters, and formatters

Install something with Mason by typing `<cmd>:Mason</cmd>`

##### Add a language
1. Install correct language (e.g. `npm install typescript`)
2. Run `<cmd>:TSInstall <language></cmd>` within Neovim (e.g. `<cmd>:TSInstall typescript</cmd>`)
	2.1. Install language compiler if needed (e.g. `sudo apt install build-essential`)

### Notes

##### Use Neovim with Git
Add the following to your global `.gitconfig`:
```bash
[core]
    editor = "~/squashfs-root/usr/bin/nvim"
```
