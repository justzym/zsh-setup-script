# Zsh Setup Script

This is a Bash script to install and configure Oh My Zsh on Linux systems, including installing Zsh and Git, adding `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins, and setting a random theme.

## One-Click Installation

Run the following command to download and execute the script:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/justzym/zsh-setup-script/main/setup-zsh.sh)"
```

Or, if you prefer `wget`:

```bash
bash -c "$(wget https://raw.githubusercontent.com/justzym/zsh-setup-script/main/setup-zsh.sh -O -)"
```

## Features
- Installs Zsh and Git if not present.
- Installs Oh My Zsh without user prompts.
- Configures `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins.
- Sets the Oh My Zsh theme to `random`.
- Automatically sets Zsh as the default shell (installs `chsh` if needed).

## Supported Systems
- Debian/Ubuntu (`apt`)
- Fedora (`dnf`)
- Arch Linux (`pacman`)
- Alpine Linux (`apk`)

## Notes
- Ensure `curl` or `wget` is installed on your system.
- Reopen your terminal after running the script to use Oh My Zsh.
- For the Chinese version, see [README.md](README.md).
