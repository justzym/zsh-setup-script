#!/bin/bash

# 该脚本用于在 Linux 系统上安装并配置 Oh My Zsh，
# 包括安装 Zsh 和 Git，添加 zsh-autosuggestions 和 zsh-syntax-highlighting 插件，
# 并将主题设置为 random。脚本最后自动切换到 Zsh 并应用配置。

# 检测包管理器的函数
detect_pkg_manager() {
    if command -v apt &> /dev/null; then
        echo "apt"
    elif command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    elif command -v apk &> /dev/null; then
        echo "apk"
    else
        echo "unknown"
    fi
}

# 检测包管理器
PKG_MANAGER=$(detect_pkg_manager)

# 安装 Zsh 和 Git
if [ "$PKG_MANAGER" != "unknown" ]; then
    echo "检测到包管理器：$PKG_MANAGER，正在安装 Zsh 和 Git..."
    case $PKG_MANAGER in
        apt)
            sudo apt update
            sudo apt install -y zsh git
            ;;
        dnf)
            sudo dnf install -y zsh git
            ;;
        pacman)
            sudo pacman -Sy zsh git
            ;;
        apk)
            sudo apk update
            sudo apk add zsh git
            ;;
    esac
else
    echo "错误：不支持的发行版。请手动安装 Zsh 和 Git。"
    exit 1
fi

# 检查 curl 或 wget 是否可用
if ! command -v curl &> /dev/null && ! command -v wget &> /dev/null; then
    echo "错误：未安装 curl 或 wget。请安装其中之一以继续。"
    exit 1
fi

# 安装 Oh My Zsh（完全无交互）
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "正在安装 Oh My Zsh..."
    if command -v curl &> /dev/null; then
        RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended
    else
        RUNZSH=no CHSH=no sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)" --unattended
    fi
else
    echo "Oh My Zsh 已安装，跳过安装步骤。"
fi

# 设置 ZSH_CUSTOM 变量，默认为 ~/.oh-my-zsh/custom
ZSH_CUSTOM=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}

# 安装 zsh-autosuggestions 插件
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "正在安装 zsh-autosuggestions 插件..."
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
else
    echo "zsh-autosuggestions 已存在，跳过安装。"
fi

# 安装 zsh-syntax-highlighting 插件
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "正在安装 zsh-syntax-highlighting 插件..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
else
    echo "zsh-syntax-highlighting 已存在，跳过安装。"
fi

# 备份 .zshrc 文件
if [ -f "$HOME/.zshrc" ]; then
    echo "备份 .zshrc 文件到 ~/.zshrc.bak..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
fi

# 更新 .zshrc 文件以启用插件和设置主题
ZSHRC="$HOME/.zshrc"

# 确保 .zshrc 包含 Oh My Zsh 的基本配置
if ! grep -q "source \$ZSH/oh-my-zsh.sh" "$ZSHRC"; then
    echo "source \$ZSH/oh-my-zsh.sh" >> "$ZSHRC"
fi

# 添加或更新 plugins
if grep -q "^plugins=" "$ZSHRC"; then
    # 避免重复添加插件
    if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
        sed -i '/^plugins=/ s/)/ zsh-autosuggestions zsh-syntax-highlighting)/' "$ZSHRC"
    fi
else
    echo "plugins=(git zsh-autosuggestions zsh-syntax-highlighting)" >> "$ZSHRC"
fi

# 设置主题为 random
if grep -q "^ZSH_THEME=" "$ZSHRC"; then
    sed -i 's/^ZSH_THEME=.*$/ZSH_THEME="random"/' "$ZSHRC"
else
    echo 'ZSH_THEME="random"' >> "$ZSHRC"
fi

# 自动切换到 Zsh 并应用配置
echo "安装和配置完成，正在切换到 Zsh 并应用配置..."

# 检查 Zsh 是否可用
if command -v zsh &> /dev/null; then
    # 应用 .zshrc 配置
    zsh -c "source $HOME/.zshrc && echo 'Zsh 配置已应用。'"

    # 检查并尝试安装 chsh（如果不可用）
    if ! command -v chsh &> /dev/null; then
        echo "未找到 chsh 命令，尝试安装..."
        case $PKG_MANAGER in
            apt)
                sudo apt install -y util-linux
                ;;
            dnf)
                sudo dnf install -y util-linux
                ;;
            pacman)
                sudo pacman -Sy util-linux
                ;;
            apk)
                sudo apk add shadow
                ;;
            *)
                echo "无法自动安装 chsh。请手动编辑 /etc/passwd 将默认 Shell 更改为 $(which zsh)。"
                exit 1
                ;;
        esac
    fi

    # 再次检查 chsh 是否可用并设置默认 Shell
    if command -v chsh &> /dev/null; then
        echo "正在将 Zsh 设置为默认 Shell..."
        chsh -s "$(which zsh)"
        echo "Zsh 已设置为默认 Shell，请重新登录以生效。"
    else
        echo "错误：无法安装 chsh，请手动编辑 /etc/passwd 将默认 Shell 更改为 $(which zsh)。"
        exit 1
    fi
else
    echo "错误：Zsh 未正确安装，请检查安装步骤。"
    exit 1
fi

echo "所有步骤已完成！请重新打开终端以使用 Oh My Zsh。"