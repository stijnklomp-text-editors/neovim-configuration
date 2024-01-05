# Neovim configuration

![GitHub](https://img.shields.io/github/license/stijnklomp-text-editors/neovim?style=flat)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/stijnklomp-text-editors/neovim)
![OS](https://img.shields.io/badge/OS-Linux%20%2F%20Windows%20%2F%20macOS-blue)

My personal neovim configuration.

### Getting setup

##### Prerequisites
Neovim requires **win32 yank** to be installed to work with the **Windows clipboard**:

```bash
curl -slo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```

Clipboard **settings** for **Windows clipboard** in `~/.config/nvim/init.lua`:

```lua
opt.clipboard="unnamedplus"

vim.g.clipboard = {
    name = "win32yank-wsl",
    copy = {
        ["+"] = "win32yank.exe -i --crlf",
        [""] = "win32yank.exe -i --crlf"
    },
    paste = {
        ["+"] = "win32yank.exe -o --crlf",
        [""] = "win32yank.exe -o --crlf"
    },
    cache_enable = 0,
}
```

##### Install Neovim
1. Install [Neovim](https://github.com/neovim/neovim/releases/tag/stable)
	*AppImage installation recommended*

2. Clone the project into the .config directory
3. Put alias for NeoVim in your user shell config file (ex. .bashrc/.zshrc)

```bash
export EDITOR="~/squashfs-root/usr/bin/nvim"
alias nvim="~/squashfs-root/usr/bin/nvim"
```
4. Install [Packer](https://github.com/wbthomason/packer.nvim#quickstart) for package/plugin management

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
~/.local/share/nvim/site/pack/packer/start/packer.nvim

```
5. Open Neovim from terminal `nvim` and run packersync `<cmd>:PackerSync</cmd>`

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
