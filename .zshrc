# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Homebrew
export HOMEBREW_PREFIX="$HOME/homebrew"
eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"

# Languages & runtimes
export PATH="$HOME/.cargo/env:$PATH"
export PATH="$PATH:$HOME/flutter/flutter/bin"
export PATH="$PATH:/usr/bin/flutter/bin"
export PATH="$PATH:$HOME/go/bin"

# Tools
export PATH="$HOME/.turso:$PATH"
export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$PATH:$HOME/.local/share/nvim/mason/bin/"
export PATH="$PATH:$HOME/.local/bin"
export PATH="/usr/local/opt/postgresql@15/bin:$PATH"

# Composer
export PATH="$PATH:$HOME/.config/composer"
export PATH="$PATH:$HOME/.config/composer/vendor/bin"

export ANDROID_HOME="$HOME/Android/Sdk/"

alias pip=pip3
alias dc=docker-compose

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"

alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias pest='vendor/bin/pest'
alias pint='vendor/bin/pint'
alias phpunit='vendor/bin/phpunit'

alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

plugins=(
  git 
  vi-mode 
  docker 
  docker-compose 
  nvm 
  npm
  ssh-agent 
  1password 
  golang 
  github 
  colorize 
  fzf 
  # laravel 
  zsh-interactive-cd 
  # zsh-navigation-tools 
  fast-syntax-highlighting
  zsh-syntax-highlighting
  # zsh-autosuggestions
  # zsh-autocomplete
  fzf-tab
  history 
  # sudo 
  # tmux 
  # web-search 
  # yarn 
)

source $ZSH/oh-my-zsh.sh

alias gp="git pull"
alias gs="git status"
alias gpo="git push origin"
alias cl="clear"
alias cls="clear"

alias cdg="cd ~/GitHub/"
alias cdv="cd ~/Documents/Vault/"

export EDITOR=nvim

VI_MODE_SET_CURSOR=true

bindkey -s "^N" "nvim\n"

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

export XCURSOR_PATH=$RUNTIME/usr/share/icons

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/brandon/.lmstudio/bin"
# End of LM Studio CLI section

if [[ "$TERM_PROGRAM" != "vscode" ]]; then
    RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
    if (( $+functions[virtualenv_prompt_info] )); then
      RPS1+='$(virtualenv_prompt_info)'
    fi
    RPS1+=" ${FG[237]}%n@%m%{$reset_color%}"
fi
