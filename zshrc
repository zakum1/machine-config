setopt INTERACTIVE_COMMENTS

export PATH=$PATH:$HOME/bin

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

# set defaults to allow npm scripts to not choke
export NPM_TOKEN=token
export NPM_PUBLISH_TOKEN=token
export NODE_ENV=development

# Set up the prompt

autoload -Uz promptinit
promptinit
prompt default

# Load version control information
autoload -Uz vcs_info
autoload -U colors && colors
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:git:*' formats '[%b]%c%u'

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
NEWLINE=$'\n'
PROMPT='%K{green}%F{black}[%D{%L:%M:%S}] %F{black}%K{blue}%n@%m %k%F{cyan} ${PWD/#$HOME/~} %F{green}${vcs_info_msg_0_} ${NEWLINE}> '

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
NEWLINE=$'\n'

# Define machine colors
typeset -A machine_colors
machine_colors=(
    jameslnx1 magenta
    othermachine red
    anothermachine yellow
)

# Get color for current machine, default to blue
MACHINE_COLOR=${machine_colors[$HOST]:-blue}

PROMPT='%K{green}%F{black}[%D{%L:%M:%S}] %F{black}%K{'$MACHINE_COLOR'}%n@%m %k%F{cyan} ${PWD/#$HOME/~} %F{green}${vcs_info_msg_0_} ${NEWLINE}> '

# iterm2 shell integration
[[ -r ~/.iterm2_shell_integration.zsh ]] && source ~/.iterm2_shell_integration.zsh

# zsh syntax highlighting
[[ -r  ~/.zfunctions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && source ~/.zfunctions/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# change colors of prompt:

#PROMPT="%F{cyan}%~%f %F{yellow}${prompt_pure_cmd_exec_time}%f
#%}%(12V.%F{242}%12v%f .)%(?.%F{magenta}.%F{red})${prompt_pure_state[prompt]}%f"

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANDROID_AVD_HOME=~/.android/avd


# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi


# alias cl='echo "  🚨 ✨ 💄 🔒 🛠 ⚡ 🐞 📚 🏗 ♻️ 🚦 🎨 📦 🔖 🚧 🚜  "'
. ~/.developer.sh

# deno
[[ -d ~/.deno ]] && export DENO_INSTALL="~/.deno" && export PATH="$DENO_INSTALL/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/Users/james/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/Users/james/miniforge3/etc/profile.d/conda.sh" ]; then
#         . "/Users/james/miniforge3/etc/profile.d/conda.sh"
#     else
#         export PATH="/Users/james/miniforge3/bin:$PATH"
#     fi
# fi
# unset __conda_setup

# if [ -f "/Users/james/miniforge3/etc/profile.d/mamba.sh" ]; then
#     . "/Users/james/miniforge3/etc/profile.d/mamba.sh"
# fi
# <<< conda initialize <<<

# openedx

export TUTOR_ROOT=~/.local/share/tutor
export TUTOR_PLUGINS_ROOT=~/.local/share/tutor-plugins
export BROWSER=brave

# virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export VIRTUALENVWRAPPER_PYTHON=$(which python3)  # or python if using py2
# export PYVER=$(python --version | awk '{print $2}')
# source ~/.pyenv/versions/${PYVER}/bin/virtualenvwrapper.sh

# circulr

export CIRCULAR_WORKTREE=$HOME/dev/circular

eval "$(direnv hook zsh)"

[[ -d $HOME/perl5  ]] && eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"


##### keep separate command history for different projects

# Global history
HISTFILE=~/.zsh_history
SAVEHIST=10000
HISTSIZE=10000

# Directories where we want separate history
# (add the project roots you care about)
typeset -A PROJECT_HISTORIES
PROJECT_HISTORIES[$HOME/dev/circular]="$HOME/.zsh_history_circular"
PROJECT_HISTORIES[$HOME/dev/ez]="$HOME/.zsh_history_ez"

# Hook on directory change
chpwd() {
  local dir=$PWD
  local found=0
  local oldhistory=$HISTFILE

  for proj_root histfile in "${(@kv)PROJECT_HISTORIES}"; do
    if [[ "$dir" == "$proj_root"* ]]; then
      export HISTFILE=$histfile
      touch "$HISTFILE"
      found=1
      break
    fi
  done

  if [[ $found -eq 0 ]]; then
    export HISTFILE=~/.zsh_history   # fallback global history
  fi
  if [[ "$oldhistory" != $HISTFILE ]]; then
      echo using new history file $HISTFILE
  fi
}

# Run once at shell startup
chpwd
