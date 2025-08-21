# Zsh 设置脚本

这是一个用于在 Linux 系统上安装和配置 Oh My Zsh 的 Bash 脚本，包括安装 Zsh 和 Git，添加 `zsh-autosuggestions` 和 `zsh-syntax-highlighting` 插件，并将主题设置为随机。

## 一键安装

运行以下命令即可下载并执行脚本：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/justzym/zsh-setup-script/main/setup-zsh.sh)"
```

或者，如果你更喜欢使用 `wget`：

```bash
bash -c "$(wget https://raw.githubusercontent.com/justzym/zsh-setup-script/main/setup-zsh.sh -O -)"
```

## 中国用户

中国用户，建议使用以下脚本，下面脚本切换了gitee 镜像源：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/justzym/zsh-setup-script/main/setup-zsh-cn.sh)"
```

或

```bash
bash -c "$(wget https://raw.githubusercontent.com/justzym/zsh-setup-script/main/setup-zsh-cn.sh -O -)"
```

## 功能

- 如果系统中缺少 Zsh 或 Git，则自动安装。
- 无交互式安装 Oh My Zsh。
- 配置 `zsh-autosuggestions` 和 `zsh-syntax-highlighting` 插件。
- 将 Oh My Zsh 主题设置为 `random`。
- 自动将 Zsh 设置为默认 Shell（如果需要，会安装 `chsh`）。

## 支持的系统

- Debian/Ubuntu (`apt`)
- Fedora (`dnf`)
- Arch Linux (`pacman`)
- Alpine Linux (`apk`)

## 注意事项

- 确保系统中已安装 `curl` 或 `wget`。
- 确保系统中已安装 `sudo`。
- 运行脚本后，请重新打开终端以使用 Oh My Zsh。
- 英文版文档请参阅 [README.en.md](README.en.md)。
