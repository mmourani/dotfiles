### 🧠 Core Path Add Helper
path_add() { [ -d "$1" ] && PATH="$1:$PATH"; }

### 📄 Document Foundry Global Access
alias foundry-mcp="node /Users/user/Sites/document-foundry/mcp-server/dist/server.js"

# Path to your oh-my-zsh configuration
export ZSH=$HOME/.dotfiles/oh-my-zsh
# Using Oh My Posh instead of a ZSH theme
export ZSH_THEME=""

# Plugins
plugins=(
  colorize compleat dirpersist autojump git gulp history cp
  zsh-autosuggestions zsh-syntax-highlighting docker npm
  composer colored-man-pages extract sudo brew kubectl
)

# Load oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Git and completion enhancements
autoload -U add-zsh-hook
autoload -Uz compinit && compinit
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':completion:*:*:git:*' script /usr/local/share/zsh/site-functions/_git

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Auto-load .nvmrc silently (no output at startup)
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use &> /dev/null
  fi
}
add-zsh-hook chpwd load-nvmrc

# Disable corrections
unsetopt correct

# Aliases
alias ls='lsd --icon always --group-dirs first'
alias ll='lsd -l --icon always --group-dirs first'
alias la='lsd -la --icon always --group-dirs first'

# General PATH setup
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.composer/pestphp/pest:$PATH"
export PATH="$HOME/.composer/vendor/bin:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"
export PATH="/opt/homebrew/opt/mongodb-community@5.0/bin:$PATH"
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
export PATH="/opt/homebrew/opt/tcl-tk/bin:$PATH"
export PATH="/opt/homebrew/opt/python@3.12/bin:$PATH"
export PATH="/Users/user/.codeium/windsurf/bin:$PATH"
export PATH="/Users/user/.lmstudio/bin:$PATH"

# Java & Compiler flags
export CPPFLAGS="-I/opt/homebrew/opt/tcl-tk/include"
export LDFLAGS="-L/opt/homebrew/opt/tcl-tk/lib"
export PKG_CONFIG_PATH="/opt/homebrew/opt/tcl-tk/lib/pkgconfig"

# GitHub Copilot CLI
# GitHub Copilot CLI (with error handling)
if command -v gh &>/dev/null && gh extension list 2>/dev/null | grep -q copilot; then
  eval "$(gh copilot alias -- zsh 2>/dev/null || true)"
fi

# Enable colored output
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

# pyenv initialization
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

# Angular CLI autocompletion (only if installed)
command -v ng &>/dev/null && source <(ng completion script)

# Editor
export EDITOR="code --wait"

# Claude AI Fallback System
export CLAUDE_AI_FALLBACK="$HOME/.claude-ai-fallback"

# Function to use when Claude is rate limited
when_claude_limited() {
    echo "🔄 Claude is rate limited, switching to fallback AI..."
    python3 "$HOME/.claude-ai-fallback/multi_ai_cli.py" "$@"
}

# Alias for quick access
alias ai='python3 "$HOME/.claude-ai-fallback/multi_ai_cli.py"'
alias ai-status='python3 "$HOME/.claude-ai-fallback/multi_ai_cli.py" status'
alias claude-fallback='when_claude_limited'

### 🎨 Oh My Posh Prompt Setup (active)
if command -v oh-my-posh &>/dev/null; then
  eval "$(oh-my-posh init zsh --config ~/.poshthemes/pararussel.omp.json)"
fi

# Show a random fortune only in interactive terminals (if fortune is installed)
if [[ $- == *i* ]] && command -v fortune &>/dev/null; then
  fortune
fi
export PATH="/opt/homebrew/opt/mysql/bin:$PATH"
source ~/.shellaliases

# Herd injected PHP binary.
export PATH="/Users/user/Library/Application Support/Herd/bin/":$PATH


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/user/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/user/Library/Application Support/Herd/config/php/85/"


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/user/Library/Application Support/Herd/config/php/84/"

# Claude CLI with memory (repo-aware)
claude_repo_root() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -d "$dir/.git" ]]; then
      echo "$dir"
      return 0
    fi
    dir=$(dirname "$dir")
  done
  echo "/Users/user/Sites/microservices/trading-signals"  # fallback
  return 1
}

claude_mem() {
  local repo_root=$(claude_repo_root)
  if [[ -f "$repo_root/scripts/claude_with_recall.sh" ]]; then
    bash "$repo_root/scripts/claude_with_recall.sh" "$@"
  else
    echo "ERROR: Memory stack not found in current repo ($repo_root)"
    echo "Fallback: Using trading-signals memory stack"
    bash /Users/user/Sites/microservices/trading-signals/scripts/claude_with_recall.sh "$@"
  fi
}

claude_mem_dry() {
  local repo_root=$(claude_repo_root)
  if [[ -f "$repo_root/scripts/claude_with_recall.sh" ]]; then
    bash "$repo_root/scripts/claude_with_recall.sh" --dry-run "$@"
  else
    echo "ERROR: Memory stack not found in current repo ($repo_root)"
    echo "Fallback: Using trading-signals memory stack"
    bash /Users/user/Sites/microservices/trading-signals/scripts/claude_with_recall.sh --dry-run "$@"
  fi
}
alias reset-ci-db="bash scripts/reset_phpunit_db.sh"
alias gate-ci='CI=true DISABLE_LIVE_NETWORK_TESTS=1 bash -c "vendor/bin/pest --configuration=phpunit.ci.xml --compact 2>&1 | tee /tmp/pest_ci.txt >/dev/null; echo EXIT=\${PIPESTATUS[0]}; tail -5 /tmp/pest_ci.txt"'
