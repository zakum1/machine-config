export PATH=$PATH:/Users/james/bin
export NPM_TOKEN=token
export NPM_PUBLISH_TOKEN=token
export NODE_ENV=development

# export PS1="\h:\W \u\$ "
export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "

# iterm2 shell integration
source ~/.iterm2_shell_integration.bash


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
