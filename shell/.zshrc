export ZSH="/Users/dinhmai/.oh-my-zsh"
export TERM="xterm-256color"

POWERLEVEL9K_MODE="nerdfont-complete"
ZSH_THEME="powerlevel9k/powerlevel9k"

export UPDATE_ZSH_DAYS=7

ENABLE_CORRECTION="true"

COMPLETION_WAITING_DOTS="true"

DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
  brew 
  common-aliases 
  docker 
  gitfast 
  github 
  node 
  npm 
  yarn 
  osx
  web-search
  nvm
  zsh-syntax-highlighting
  zsh-better-npm-completion
  zsh-completions
  git
  zsh-autosuggestions
  alias-tips
)

source $ZSH/oh-my-zsh.sh

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"


#------------------------------------------------------------------------------#
#                                    general                                   #
#------------------------------------------------------------------------------#
# set local
LC_CTYPE=en_US.UTF-8
LC_ALL=en_US.UTF-8

export EDITOR=nvim
# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# remove % sign
unsetopt PROMPT_SP

# export STARSHIP_CONFIG=~/.config/starship/starship.toml
# eval "$(starship init zsh)"
# start tmux
# if [ "$TMUX" = "" ]; then tmux; fi

# -t -- /bin/sh -c 'tmux has-session && exec tmux attach || exec tmux'
# export PATH="/usr/local/opt/node@10/bin:$PATH"
# export PATH="/usr/local/opt/node@12/bin:$PATH"

  # Set Spaceship ZSH as a prompt
  # autoload -U promptinit; promptinit
  # prompt spaceship

  
# vi mode
# bindkey -v
# export KEYTIMEOUT=1
# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char
# Change cursor shape for different vi modes.
# function zle-keymap-select {
# if [[ ${KEYMAP} == vicmd ]] ||
     # [[ $1 = 'block' ]]; then
# echo -ne '\e[1 q'
# elif [[ ${KEYMAP} == main ]] ||
       # [[ ${KEYMAP} == viins ]] ||
       # [[ ${KEYMAP} = '' ]] ||
       # [[ $1 = 'beam' ]]; then
# echo -ne '\e[5 q'
# fi
# }
# zle -N zle-keymap-select
# zle-line-init() {
    # zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
# echo -ne "\e[5 q"
# }
# zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
fi
}
bindkey -s '^o' 'lfcd\n'
# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files'

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set location of z installation
. /usr/local/etc/profile.d/z.sh

## FZF FUNCTIONS ##

# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fh [FUZZY PATTERN] - Search in command history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fbr [FUZZY PATTERN] - Checkout specified branch
# Include remote branches, sorted by most recent commit and limited to 30
fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# tm [SESSION_NAME | FUZZY PATTERN] - create new tmux session, or switch to existing one.
# Running `tm` will let you fuzzy-find a session mame
# Passing an argument to `ftm` will switch to that session if it exists or create it otherwise
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# tm [SESSION_NAME | FUZZY PATTERN] - delete tmux session
# Running `tm` will let you fuzzy-find a session mame to delete
# Passing an argument to `ftm` will delete that session if it exists
ftmk() {
  if [ $1 ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux kill-session -t "$session" || echo "No session found to delete."
}

# fuzzy grep via rg and open in vim with line number
fgr() {
  local file
  local line

  read -r file line <<<"$(rg --no-heading --line-number $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}


#------------------------------------------------------------------------------#
#                                    themes                                    #
#------------------------------------------------------------------------------#

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs_joined)
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="clear"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="012"
POWERLEVEL9K_DIR_FOREGROUND='010'
POWERLEVEL9K_DIR_HOME_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_FOREGROUND="012"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="clear"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="012"
POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{008}/%F{cyan}"


POWERLEVEL9K_VCS_CLEAN_BACKGROUND='clear'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='green'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='clear'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='clear'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='green'
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status)
# POWERLEVEL9K_TIME_FORMAT="%D{%m/%d %H:%M:%S}"
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M}"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_HIDE_BRANCH_ICON=true
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_NODE_VERSION_FOREGROUND="black"


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export JAVA_HOME=$(/usr/libexec/java_home)

POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_BACKGROUND="gray"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL_FOREGROUND="yellow"

zsh_wifi_signal(){
        local output=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I) 
        local airport=$(echo $output | grep 'AirPort' | awk -F': ' '{print $2}')

        if [ "$airport" = "Off" ]; then
                local color='%F{yellow}'
                echo -n "%{$color%}Wifi Off"
        else
                local ssid=$(echo $output | grep ' SSID' | awk -F': ' '{print $2}')
                local speed=$(echo $output | grep 'lastTxRate' | awk -F': ' '{print $2}')
                local color='%F{yellow}'

                [[ $speed -gt 300 ]] && color='%F{green}'
                [[ $speed -lt 100 ]] && color='%F{red}'

                echo -n "%{$color%}\uF1EB $speed Mb/s%{%f%}" # removed char not in my PowerLine font 
        fi
}

twf-widget() {
  local selected=$(twf --height=0.5)
  BUFFER="$BUFFER$selected"
  zle reset-prompt
  zle end-of-line
  return $ret
}
zle -N twf-widget
bindkey '^T' twf-widget

#------------------------------------------------------------------------------#
#                                     alias                                    #
#------------------------------------------------------------------------------#
alias zshconfig="code ~/.zshrc"
alias zshconfigv="vi ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias zshreset="source ~/.zshrc"
alias yclean="rm -rf node_modules/ && yarn install"
alias npmclean="rm -rf node_modules/ && npm install"
alias ls="colorls --dark --sort-dirs --report"
alias lc="colorls --tree --dark"
alias mvnci="mvn clean install -DskipTests"
alias mvnrun="mvn spring-boot:run"
alias dcstop="cd ~/Source/devops/docker && docker-compose stop"
alias dcstart="cd ~/Source/devops/docker && docker-compose start"
alias dc="docker-compose"

alias vim="nvim"
alias vi="nvim"
alias oldvim="vim"
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias c="code-insiders ."
alias ra="flutter emulators --launch Nexus_5X_API_29_x86"
alias cowf="Fortune | cowsay -f vader | lolcat"
alias ns="npm start"
alias rn='npx react-native run-ios --simulator="iPhone 6"'
alias rna='npx react-native run-android'
alias rn6='npx react-native run-ios --simulator="iPhone 6"'
alias rn6s='npx react-native run-ios --simulator="iPhone 6s"'
alias rne='npx react-native run-ios --simulator="iPhone'
alias rn5='npx react-native run-ios --simulator="iPhone 5s"'
alias rn8='npx react-native run-ios --simulator="iPhone 8"'
alias rn8s='npx react-native run-ios --simulator="iPhone 8s"'
alias rnx='npx react-native run-ios --simulator="iPhone X"'
alias rn11='npx react-native run-ios --simulator="iPhone 11"'
alias alacf="vi ~/.config/alacritty/alacritty.yml"

alias sd='sudo shutdown -h now'
alias rs='sudo shutdown -r now'
alias cf='caffeinate -i -t '
alias cfi='caffeinate -i -t 9999999999'
alias pj='cd ~/workspace/project'
alias st='cd ~/workspace/project/swift'
alias uit='cd ~/workspace/project/uit'
alias getAdress='ipconfig getifaddr en0'
alias getadress='ipconfig getifaddr en0'
alias ipad='ipconfig getifaddr en0'
alias fun='cd ~/workspace/Project/fun'
alias ig='ignite'
alias igg='ignite generate'
alias igs='ignite generate screen'
alias igc='ignite generate component'
alias yip='y && cd ios && pod install && cd .. && rn'
alias ev="code ~/.config/nvim/init.vim"
alias vdir="code ~/.config/nvim"
alias config="cd ~/.config"
alias gs="gon "
alias gss="gon screen "
alias gsc="gon component "
alias gsu="gon utils "
alias oiterm="open -a /Applications/iTerm.app ."
alias oi="open -a /Applications/iTerm.app ."
alias pip="pip3"
alias mongosv="mongod --dbpath ~/Documents/mongodb"

alias emu="cd $ANDROID_HOME && cd tools && emulator -avd Nexus5X"
alias devmenu="adb shell input keyevent 82"
alias top="vtop --theme=wizard"
alias ystory= "yarn storybook"
alias py= "py3"
alias f="fuck"

alias wp="cd ~/workspace/project/expo/Expo-bowie"

autoload -U compinit && compinit


#------------------------------------------------------------------------------#
#                                  export path                                 #
#------------------------------------------------------------------------------#

export ANDROID_HOME=$HOME/Library/Android/sdk
PATH=$PATH:$ANDROID_HOME/tools
PATH=$PATH:$ANDROID_HOME/tools/bin
PATH=$PATH:$ANDROID_HOME/platform-tools
PATH=$PATH:$ANDROID_HOME/emulator
PATH="/usr/local/opt/ruby/bin:$PATH"
PATH=$PATH:$(ruby -e 'puts Gem.bindir')
PATH=$PATH:"/Users/dinhmai/.gem/ruby/2.7.0/bin"
PATH=$PATH:~/.npm-global/bin
PATH=~/development/flutter/bin:$PATH
PATH="$PATH:/Users/dinhmai/.dotnet/tools"
PATH="/Users/dinhmai/.deno/bin:$PATH"
export GOPATH="$HOME/go"
PATH="$PATH:$HOME/bin:$GOPATH/bin"
PATH="$PATH:/usr/local/lib/ruby/gems/2.7.0/bin"
export PATH
export NPM_CONFIG_PREFIX=~/.npm-global
export TOOLCHAINS=swift
export GOOGLE_APPLICATION_CREDENTIALS="~/Downloads/adminsdk.json"
# export NODE_ENV=production
# . <(denon --completion)


#------------------------------------------------------------------------------#
#                                 source plugin                                #
#------------------------------------------------------------------------------#

source $(dirname $(gem which colorls))/tab_complete.sh
eval $(thefuck --alias)
export NVIM_TUI_ENABLE_TRUE_COLOR=1
typeset -g ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE='10'

