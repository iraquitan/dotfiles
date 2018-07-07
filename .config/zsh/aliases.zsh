# My custom aliases for zsh

# Don't change. The following determines where Oh-My-Zsh is installed.
zsh_cfg=$XDG_CONFIG_HOME/zsh

# My Alias Editing
alias ae='vim $zsh_cfg/aliases.zsh' #my-alias edit
alias alias_reload='source $zsh_cfg/aliases.zsh'  #my-alias reload

# Zsh Profile Editing
alias ze='vim ~/.zshrc'  #zshrc edit
alias zr='source ~/.zshrc'  #zshrc reload
alias ze_env='vim $XDG_CONFIG_HOME/zsh/zshenv'

# Vim profile editing
alias ve='vim $XDG_CONFIG_HOME/vim/vimrc'
alias vim_plug_install='vim +PlugInstall +qall'
alias vim_plug_update='vim +PlugUpdate +qall'
alias vim_plug_upgrade='vim +PlugUpgrade +qall'
alias vim_plug_status='vim +PlugStatus'

# show me files matching "ls grep"
alias lsg='ll | grep'

alias ka9='killall -9'
alias k9='kill -9'

# Alias to Show/Hide files
alias hidehf="defaults write com.apple.finder AppleShowAllFiles FALSE;killall Finder"
alias showhf="defaults write com.apple.finder AppleShowAllFiles TRUE;killall Finder"

# Alias for fast router config GUI
alias router="command -v route && open http://$(route -n get default | grep gateway | awk -F ': ' '{ print $2 }')"

# because typing 'cd' is A LOT of work!!
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'

# Disk usage and finding directory or files
alias dud='du -d 1 -h'
alias duf='du -sh *'
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# History
alias h='history'
alias hgrep="fc -El 0 | grep"

# Dock scroll gestures
alias dockscroll_on='defaults write com.apple.dock scroll-to-open -bool TRUE; killall Dock'
alias dockscroll_off='defaults write com.apple.dock scroll-to-open -bool FALSE; killall Dock'

alias mac_accent_disable='defaults write -g ApplePressAndHoldEnabled -bool false'
alias mac_accent_enable='defaults write -g ApplePressAndHoldEnabled -bool true'

# Terminal Proxy
function terminal_proxy() {
	export http_proxy=${1}
	export HTTPS_PROXY=${1}
	export HTTP_PROXY=${1}
}

function unset_terminal_proxy() {
	unset http_proxy
	unset HTTPS_PROXY
	unset HTTP_PROXY
}

# Alias for Git Custom
function git_setproxy() {
	git config --global http.proxy ${1}
	git config --global https.proxy ${1}
}
function git_unsetproxy() {
	git config --global --unset http.proxy
	git config --global --unset https.proxy
}

# Add MacTeX to path
alias mactex_path='export PATH=$PATH:/Library/TeX/Distributions/.DefaultTeX/Contents/Programs/texbin'

# Check what process is listening on port
function whos_listening () {
	lsof -n -i4TCP:$1 | grep LISTEN
}

alias vagrant_shutdown_all='vagrant global-status | grep virtualbox | cut -c 1-9 | while read line; do echo $line; vagrant halt $line; done;'

alias gitignored='git ls-files --other --ignored --exclude-standard'

# Set a blazingly fast keyboard repeat rate
alias set_bf_kb='defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 12'

# Set keyboard settings to default
alias default_kb='defaults delete NSGlobalDomain KeyRepeat
defaults delete NSGlobalDomain InitialKeyRepeat'

# Flush DNS
alias flushdns='dscacheutil -flushcache;sudo killall -HUP mDNSResponder;say flushed'

# Update dotfiles
function dfu() {
    (
        cd ~/.dotfiles && git pullff && ./install -q
    )
}

# Execute a command in a specific directory
function in() {
    (
        cd ${1} && shift && ${@}
    )
}

# Check if a file contains non-ascii characters
function nonascii() {
    LC_ALL=C grep -n '[^[:print:][:space:]]' ${1}
}

# Mirror a website
alias mirrorsite='wget -m -k -K -E -e robots=off'

# Check octal mod of dir or file
function octmod() {
	stat -f %Mp%Lp ${1}
}

# Copy and create dir if not exist
function cpmkdir() {
    test -d "${2}" || mkdir -p "${2}" && cp ${1} "${2}"
}

# Count coffe
alias coffee='VALUE=$( cat ~/.cupsocoffee ) ; VALUE=$(( $VALUE + 1 )); echo $VALUE > ~/.cupsocoffee ; echo $VALUE'

# Unsecure http Google Chrome
alias chrome-unsecure="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=test --unsafely-treat-insecure-origin-as-secure=http://localhost:8080"

# Open in chrome
alias chrome="open -a 'Google Chrome'"

# Open in firefox
alias firefox="open -a 'Firefox'"

# Base64 encode function
function base64_enc() {
    echo -n ${1} | base64
}

# Base64 decode function
function base64_dec() {
    echo -n ${1} | base64 -D
}

# Alias vim to mvim
if [ -f "`which mvim`" ]; then
    alias vim="mvim -v"
fi

alias conda_activate='export PATH="$HOME/anaconda/bin:$PATH"'

function count_files() {
    if [ "$1" ]
    then
        find . -type f -name "${1}" | wc -l
    else
        find . -type f | wc -l
    fi
}

function debug_zsh() {
    zsh -xv 2>&1 | ts -i "%.s" > $HOME/zsh_startup.log
}

function show_symlinks() {
    if [ $# -eq 2 ]; then
        find ${1} -maxdepth ${2} -type l -ls
    else
        find ${1} -type l -ls
    fi
}

alias n=nnn

