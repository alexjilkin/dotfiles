export PATH="./node_modules/.bin:$PATH"
export HOMEBREW_CASK_OPTS="--caskroom=/opt/homebrew-cask/Caskroom"

# useful shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ld="ls -G -lh | grep '^d'"
alias ll="ls -G -lh"
alias ls="ls -G"
alias repos="cd ~/Documents/repos"
alias grep="grep --color=always -i "
alias vi="vim"

# homebrew
alias update_brew="brew update && brew outdated"
alias upgrade_brew="brew upgrade --all && brew outdated"
export PATH="/usr/local/bin:/usr/local/sbin:$PATH"


# enable bash compleation
if [ -f $(brew --prefix)/share/bash-completion/bash_completion ]; then
  . $(brew --prefix)/share/bash-completion/bash_completion
fi

# git
alias git_log="git log --graph --pretty=format:'%Cred%h%Creset - %s %Cgreen(%cr)%Creset by %C(bold blue)%an%C(yellow)%d%Creset' --abbrev-commit --date=relative" # add --all to see all branches and not only the checkedout branch
alias git_log_all="git_log --branches --remotes --tags --decorate"
alias gp="git pull --rebase=preserve"
alias gf="git fetch && git fetch --tags"
alias gs="git status"
alias gd="git diff --ignore-space-at-eol -b -w --ignore-blank-lines"
alias gc='git checkout $(git branch -a | fzf | sed -e "s#^[ \n\t]*remotes/[^/]*/##")'
alias gc-='git checkout -'
alias gcd='git checkout develop'
alias gcm='git checkout master'
alias git_cherrypick='git cherry-pick --signoff -x'

function gl() {
  local out shas sha q k
  while out=$(
      git log --graph \
              --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\
              --abbrev-commit --date=relative --color=always "$@" |
      fzf --ansi --multi --no-sort --reverse --query="$q" \
          --print-query --expect=ctrl-d --toggle-sort=\`); do
    q=$(head -1 <<< "$out")
    k=$(head -2 <<< "$out" | tail -1)
    shas=$(sed '1,2d;s/^[^a-z0-9]*//;/^$/d' <<< "$out" | awk '{print $1}')
    [ -z "$shas" ] && continue
    if [ "$k" = ctrl-d ]; then
      git diff --no-ext-diff --color=always --ignore-space-at-eol -b -w --ignore-blank-lines "$shas" | less -R
    else
      for sha in $shas; do
        git show --color=always "$sha" | less -R
      done
    fi
  done
}

# fzf #
export FZF_COMPLETION_TRIGGER=',,'
export FZF_COMPLETION_OPTS='-m --ansi'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
export MANPATH="$(brew --prefix coreutils)/libexec/gnuman:$MANPATH"

# node
export PATH="$HOME/bin:/usr/local/share/npm/bin:$PATH"


###########
# History #
###########

# Larger bash history (allow 32³ entries; default is 500)
export HISTSIZE=32768
export HISTFILESIZE=$HISTSIZE
export HISTCONTROL=ignoredups

# timestamps for bash history. www.debian-administration.org/users/rossen/weblog/1
# saved for later analysis
export HISTTIMEFORMAT='%F %T '

####################
# general settings #
####################

export PATH=".:$PATH"
