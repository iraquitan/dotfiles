# zmodload zsh/zprof
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# load zplug
XDG_CONFIG_HOME=$HOME/.config
source "$XDG_CONFIG_HOME/zsh/zshenv"
source "$XDG_CONFIG_HOME/zsh/zplug/init.zsh"

# oh-my-zsh plugins and libs
zplug "plugins/git", from:oh-my-zsh
zplug "plugins/zsh_reload", from:oh-my-zsh
zplug "plugins/brew", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "plugins/osx", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/completion", from:oh-my-zsh
zplug "lib/clipboard", from:oh-my-zsh, if:"[[ $OSTYPE == *darwin* ]]"
zplug "lib/history", from:oh-my-zsh
zplug "lib/directories", from:oh-my-zsh
zplug "lib/theme-and-appearance", from:oh-my-zsh

# Let zplug manage zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-autosuggestions"
zplug 'knqyf263/pet', as:command, hook-build:'go get -d && go build', if:"[[ $OSTYPE != *darwin* ]]"
zplug "paulirish/git-open", as:plugin
zplug "b4b4r07/zsh-gomi", as:command, use:bin/gomi
zplug "b4b4r07/httpstat", \
    as:command, \
    use:'(*).sh', \
    rename-to:'$1'
# Completions
fpath=("$ZPLUG_HOME/bin" $fpath)
zplug "TheLocehiliosan/yadm", rename-to:_yadm, use:"completion/yadm.zsh_completion", as:command, defer:2
# zplug "jarun/googler", use:"auto-completion/zsh/_googler", as:command, defer:2
zplug "jarun/googler", use:"auto-completion/googler_at/googler_at"

# Local plugins
zplug "$XDG_CONFIG_HOME/zsh/", use:"aliases.zsh", from:local
# Load theme file
zplug "romkatv/powerlevel10k", as:theme, depth:1

# Install plugins if there are plugins that have not been installed
# if ! zplug check --verbose; then
if ! zplug check; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
# zplug load --verbose
zplug load

# pyenv setup
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
# pyenv-virtualenv auto activation
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Thefuck setup
eval "$(thefuck --alias)"

# source $MOTD_DIR/motd.sh

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/iraquitan/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;
export PATH="/usr/local/sbin:$PATH"
export PATH="/usr/local/opt/tcl-tk/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/opt/openssl@1.0.2t/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
